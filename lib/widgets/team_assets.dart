import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:intl/intl.dart';

import '../models/app_user.dart';
import '../models/team.dart';

class TeamAssets extends StatelessWidget {
  const TeamAssets(this.user, this.team, {super.key});
  final AppUser user;
  final Team team;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");
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
                      padding:
                          const EdgeInsets.only(top: 15, left: 28),
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
