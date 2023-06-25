import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:si_proto/components/custom_future_builder.dart';
import 'package:si_proto/firebase/connection_db.dart';
import 'package:si_proto/models/user_model.dart';
import 'package:si_proto/models/team_model.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:intl/intl.dart';
import 'package:si_proto/utils/constants_text.dart';
import 'package:avatar_glow/avatar_glow.dart';

class TeamCardWidget extends StatefulWidget {
  const TeamCardWidget({super.key});
  @override
  State<TeamCardWidget> createState() => _TeamCardWidgetState();
}

class _TeamCardWidgetState extends State<TeamCardWidget> {
  final formatter = NumberFormat("#,###");
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
    setState(() {
      teamModel = getTeam;
      bytes = response.bodyBytes;
      needYen = formatter.format(getTeam.goalAmount - getTeam.assets);
      participant = teamMember.length;
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
                        padding: const EdgeInsets.only(top: 16, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AvatarGlow(
                              glowColor: Colors.white,
                              endRadius: 40.0,
                              duration: const Duration(milliseconds: 2000),
                              repeat: true,
                              showTwoGlows: true,
                              repeatPauseDuration:
                                  const Duration(milliseconds: 100),
                              child: Material(
                                elevation: 8.0,
                                shape: const CircleBorder(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[100],
                                    radius: 30.0,
                                    child: Image.memory(bytes),
                                  ),
                                ),
                              ),
                            ),
                            Text(teamModel.teamName,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: ConstantsColor.lightTextColor))
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(90, -25),
                        child: Row(
                          children: [
                            Text(
                                '${ConstantsText.participant}${participant.toString()}${ConstantsText.person}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: ConstantsColor.lightTextColor))
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 28),
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
                        padding: const EdgeInsets.only(top: 1, left: 28),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 28),
                        child: Row(
                          children: [
                            Text(
                                '${ConstantsText.upToTargetAmount}$needYen ${ConstantsText.yen}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: ConstantsColor.lightTextColor))
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
