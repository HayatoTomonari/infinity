import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:si_proto/utils/constants_text.dart';

import '../models/user_model.dart';

class TeamMemberListWidget extends StatefulWidget {
  const TeamMemberListWidget(
      {required this.scrollController,
      required this.teamMember,
      required this.images,
      Key? key})
      : super(key: key);
  final ScrollController scrollController;
  final List<UserModel> teamMember;
  final List<Image> images;

  @override
  State<TeamMemberListWidget> createState() => _TeamMemberListWidgetState();
}

class _TeamMemberListWidgetState extends State<TeamMemberListWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.teamMember.isNotEmpty
        ? ListView.builder(
            controller: widget.scrollController,
            shrinkWrap: true,
            primary: false,
            itemCount: widget.teamMember.length,
            itemBuilder: (context, index) {
              return userComponent(
                  user: widget.teamMember[index], image: widget.images[index]);
            })
        : const Center(
            child: Text(
            ConstantsText.noUsersFound,
            style: TextStyle(color: ConstantsColor.darkTextColor),
          ));
  }

  userComponent({required UserModel user, required Image image}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: image,
                )),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user.userName,
                  style: const TextStyle(color: ConstantsColor.darkTextColor)),
              const SizedBox(
                height: 5,
              ),
              Text(user.comment, style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w300)),
            ])
          ]),
        ],
      ),
    );
  }
}
