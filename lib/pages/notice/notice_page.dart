import 'package:flutter/material.dart';

import '../../widgets/header_widget.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column(children: [HeaderWidget(), Text("notice")]));
  }
}
