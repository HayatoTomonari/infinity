import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:si_proto/models/team_model.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:si_proto/utils/constants_text.dart';
import 'package:clay_containers/clay_containers.dart';

import '../components/custom_future_builder.dart';
import '../firebase/connection_db.dart';

class TeamListWidget extends StatefulWidget {
  const TeamListWidget({required this.scrollController, Key? key})
      : super(key: key);
  final ScrollController scrollController;

  @override
  State<TeamListWidget> createState() => _TeamListWidgetState();
}

class _TeamListWidgetState extends State<TeamListWidget> {
  final formatter = NumberFormat("#,###");
  late Future<bool> waitingProcess;
  List<TeamModel> teams = [];
  List<Image> images = [];

  Future<bool> getTeams() async {
    List<TeamModel> teams = await ConnectionDb.getTeams();
    List<Image> images = [];
    for (TeamModel teams in teams) {
      images.add(Image.network(await ConnectionDb.getImageUrl(teams.imageUrl)));
    }
    setState(() {
      this.teams = teams;
      this.images = images;
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    waitingProcess = getTeams();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
        waitingProcess,
        teams.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                controller: widget.scrollController,
                shrinkWrap: true,
                primary: false,
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  return teamComponent(
                      team: teams[index], image: images[index]);
                })
            : const Center(
                child: Text(
                ConstantsText.noTeamsFound,
                style: TextStyle(color: ConstantsColor.darkTextColor),
              )));
  }

  teamComponent({required TeamModel team, required Image image}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ClayContainer(
        borderRadius: 15,
        depth: 50,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                SizedBox(
                    width: 70,
                    height: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: image,
                    )),
                const SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(team.teamName,
                      style:
                          const TextStyle(color: ConstantsColor.darkTextColor)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      '${ConstantsText.goalAmount}: ${formatter.format(team.goalAmount)} ${ConstantsText.yen}',
                      style:
                          const TextStyle(color: ConstantsColor.darkTextColor)),
                  Text(
                      '${ConstantsText.monthDeposit}: ${formatter.format(team.monthDeposit)} ${ConstantsText.yen}',
                      style:
                          const TextStyle(color: ConstantsColor.darkTextColor)),
                  Text(
                      '${ConstantsText.recruitmentNumbers}: ${formatter.format(team.recruitmentNumbers)} ${ConstantsText.person}',
                      style:
                          const TextStyle(color: ConstantsColor.darkTextColor)),
                ])
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
