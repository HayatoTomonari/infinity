import 'package:flutter/material.dart';
import 'package:si_proto/home/home.dart';
import 'package:si_proto/home/notice.dart';
import 'package:si_proto/home/setting.dart';
import 'package:si_proto/home/payment.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  static const _screens = [
    Home(),
    Payment(),
    Notice(),
    Setting(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
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
