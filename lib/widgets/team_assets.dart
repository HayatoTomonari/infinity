import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_proto/firebase/connection_db.dart';
import 'package:si_proto/models/app_user.dart';
import 'package:si_proto/models/team.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:intl/intl.dart';

class TeamAssets extends StatefulWidget {
  const TeamAssets({super.key});
  @override
  State<TeamAssets> createState() => _TeamAssetsState();
}

class _TeamAssetsState extends State<TeamAssets> {
  final formatter = NumberFormat("#,###");
  Team team = const Team();

  Future getVer() async {
    AppUser getUser = await ConnectionDb.getAppUser();
    Team getTeam = await ConnectionDb.getTeam(getUser.teamId);
    setState(() {
      team = getTeam;
    });
  }

  @override
  void initState() {
    super.initState();
    getVer();
  }

  @override
  Widget build(BuildContext context) {
    String assets = formatter.format(team.assets);
    return Positioned(
      top: 150,
      left: 30,
      child: GestureDetector(
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
                          Text(
                            team.teamName,
                            style: GoogleFonts.kameron(
                                fontSize: 20, color: ConstantsColor.kTextColor),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 28),
                      child: Row(
                        children: [
                          Text(
                            '資産総額',
                            style: GoogleFonts.kameron(
                                fontSize: 15, color: ConstantsColor.kTextColor),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 1, bottom: 35, left: 28),
                      child: Row(
                        children: [
                          Text(
                            '$assets 円',
                            style: GoogleFonts.kameron(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: ConstantsColor.kTextColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
