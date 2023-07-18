import 'package:flutter/material.dart';
import 'package:si_proto/pages/team/team_create_page.dart';
import 'package:si_proto/widgets/team_list_widget.dart';

import '../../components/custom_button.dart';
import '../../utils/constants_color.dart';
import '../../utils/constants_text.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scaffold(
        appBar: AppBar(
          title: const Text(ConstantsText.teamPageTitle),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient:
                LinearGradient(colors: [Colors.deepPurple, Colors.pink])),
          ),
        ),
        body: Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 60),
                    child: SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          labelText: 'チームを作成する',
                          onPressedFunction: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TeamCreatePage()),
                          ),
                          textColor: ConstantsColor.darkButtonTextColor,
                          backColor: ConstantsColor.darkButtonBackColor,
                        ))),
                const Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        ConstantsText.teamList,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 20,
                            color: ConstantsColor.darkTextColor),
                      )),
                ),
                TeamListWidget(scrollController: scrollController),
              ],
            ))));
  }
}
