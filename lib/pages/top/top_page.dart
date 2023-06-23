import 'package:flutter/material.dart';
import 'package:si_proto/pages/team/team_page.dart';
import 'package:si_proto/widgets/top_page_widget.dart';
import 'package:si_proto/pages/notice/notice_page.dart';
import 'package:si_proto/pages/setting/setting_page.dart';
import 'package:si_proto/pages/payment/payment_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});
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
          const TopPageWidget(),
          const TeamPage(),
          const PaymentPage(),
          const NoticePage(),
          const SettingPage(),
        ][_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.supervisor_account), label: 'チーム'),
            BottomNavigationBarItem(icon: Icon(Icons.payment), label: '入金'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'お知らせ'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
