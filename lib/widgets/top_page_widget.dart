import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:si_proto/components/custom_future_builder.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:si_proto/widgets/header_widget.dart';

import '../firebase/connection_db.dart';
import '../models/team_model.dart';
import '../models/user_model.dart';
import '../utils/constants_text.dart';
import 'team_member_list_widget.dart';
import 'team_card_widget.dart';

class TopPageWidget extends StatefulWidget {
  const TopPageWidget({super.key});
  @override
  State<TopPageWidget> createState() => _TopPageWidgetState();
}

class _TopPageWidgetState extends State<TopPageWidget> {
  final formatter = NumberFormat("#,###");
  List<UserModel> teamMember = [];
  List<Image> images = [];
  TeamModel teamModel = const TeamModel();
  Uint8List bytes = Uint8List(0);
  String needYen = '';
  int participant = 0;
  late Future<bool> waitingProcess;

  Future<bool> getTeamModel() async {
    UserModel getUser = await ConnectionDb.getUserModel();
    TeamModel getTeam = await ConnectionDb.getTeamModel(getUser.teamId);
    String imageUrl = await ConnectionDb.getImageUrl(getTeam.imageUrl);
    final response = await get(Uri.parse(imageUrl));
    List<UserModel> teamMember =
        await ConnectionDb.getTeamMember(getUser.teamId);
    List<Image> images = [];
    for (UserModel user in teamMember) {
      images.add(Image.network(await ConnectionDb.getImageUrl(user.imageUrl)));
    }
    setState(() {
      teamModel = getTeam;
      bytes = response.bodyBytes;
      needYen = formatter.format(getTeam.goalAmount - getTeam.assets);
      participant = teamMember.length;
      this.teamMember = teamMember;
      this.images = images;
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
    final scrollController = ScrollController();
    return Scaffold(
        body: CustomFutureBuilder(
            waitingProcess,
            Scrollbar(
                controller: scrollController,
                child: SingleChildScrollView(
                    child: Column(children: [
                  const HeaderWidget(),
                  TeamCardWidget(
                    teamModel: teamModel,
                    bytes: bytes,
                    needYen: needYen,
                    participant: participant,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 60),
                    child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          ConstantsText.participant,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 20,
                              color: ConstantsColor.darkTextColor),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TeamMemberListWidget(
                      scrollController: scrollController,
                      teamMember: teamMember,
                      images: images,
                    ),
                  )
                ])))));
  }
}
