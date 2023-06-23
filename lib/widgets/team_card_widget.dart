import 'package:flutter/material.dart';
import 'package:si_proto/components/custom_future_builder.dart';
import 'package:si_proto/firebase/connection_db.dart';
import 'package:si_proto/models/user_model.dart';
import 'package:si_proto/models/team_model.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:intl/intl.dart';
import 'package:si_proto/utils/constants_text.dart';

class TeamCardWidget extends StatefulWidget {
  const TeamCardWidget({super.key});
  @override
  State<TeamCardWidget> createState() => _TeamCardWidgetState();
}

class _TeamCardWidgetState extends State<TeamCardWidget> {
  final formatter = NumberFormat("#,###");
  TeamModel teamModel = const TeamModel();
  late Future<bool> waitingProcess;

  Future<bool> getTeamModel() async {
    UserModel getUser = await ConnectionDb.getUserModel();
    TeamModel getTeam = await ConnectionDb.getTeamModel(getUser.teamId);
    setState(() {
      teamModel = getTeam;
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    waitingProcess = getTeamModel();
  }

  @override
  Widget build(BuildContext context) {
    String assets = formatter.format(teamModel.assets);
    return CustomFutureBuilder(
        waitingProcess,
        GestureDetector(
          onTap: () {},
          child: Container(
              height: 261,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Colors.deepPurple,
                        Colors.pink,
                      ])),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(teamModel.teamName,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: ConstantsColor.lightTextColor))
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15, left: 28),
                        child: Row(
                          children: [
                            Text(ConstantsText.totalAssets,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: ConstantsColor.lightTextColor))
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 1, bottom: 35, left: 28),
                        child: Row(
                          children: [
                            Text('$assets ${ConstantsText.yen}',
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: ConstantsColor.lightTextColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}
