import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:si_proto/utils/constants_text.dart';

class CustomFutureBuilder extends StatefulWidget {
  const CustomFutureBuilder(this.waitingProcess, this.widget, {super.key});
  final Widget widget;
  final Future<bool> waitingProcess;
  @override
  State<CustomFutureBuilder> createState() => _CustomFutureBuilderState();
}

class _CustomFutureBuilderState extends State<CustomFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.waitingProcess,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: Colors.deepPurple,
                size: 100,
              ),
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return widget.widget;
          } else {
            return const Text(ConstantsText.unexpectedError);
          }
        });
  }
}
