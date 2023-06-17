import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/constants_text.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    const double height = 220;
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: _HeaderBackground(height: height),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: _HeaderCircles(height: height),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: _HeaderTitle(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontFamily: 'Exo', color: Colors.white)
        .copyWith(fontSize: 30, letterSpacing: 35, fontWeight: FontWeight.w700);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: Offset(-(textStyle.letterSpacing! * .5), 0),
              child: Text(ConstantsText.appTitle, style: textStyle),
            ),
          ], // Edit from here...
        ).animate().fadeIn(delay: .8.seconds, duration: .7.seconds)
      ],
    );
  }
}

class _HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height,
        size.width,
        size.height * 0.6,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _HeaderBackground extends StatelessWidget {
  final double height;

  const _HeaderBackground({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _HeaderCurveClipper(),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              Colors.deepPurple,
              Colors.pink,
            ],
            stops: [0, 1],
          ),
        ),
      ),
    );
  }
}

class _HeaderCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.5),
      12,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.1),
      12,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _HeaderCircles extends StatelessWidget {
  final double height;

  const _HeaderCircles({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HeaderCirclePainter(),
      child: SizedBox(
        width: double.infinity,
        height: height,
      ),
    );
  }
}