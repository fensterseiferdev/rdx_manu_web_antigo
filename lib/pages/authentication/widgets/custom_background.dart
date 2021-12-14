import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          radius: 1.5,
          colors: [
            Color.fromRGBO(249, 249, 249, 1),
            Color.fromRGBO(225, 220, 233, 1),
          ],
        ),
      ),
    );
  }
}