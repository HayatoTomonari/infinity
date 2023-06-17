import 'package:flutter/material.dart';
import 'package:si_proto/models/app_user.dart';
import 'package:si_proto/pages/home.dart';
import 'package:si_proto/pages/notice.dart';
import 'package:si_proto/pages/setting.dart';
import 'package:si_proto/pages/payment.dart';

import '../models/team.dart';

class TopPage extends StatefulWidget {
  const TopPage(this.user, this.team, {super.key});
  final AppUser user;
  final Team team;
  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: [
          Home(widget.user, widget.team),
          Payment(widget.user, widget.team),
          Notice(widget.user, widget.team),
          Setting(widget.user, widget.team),
        ][_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.payment), label: '入金'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'お知らせ'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
