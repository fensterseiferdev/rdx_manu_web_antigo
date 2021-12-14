import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Container(
        color: Colors.white,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            lightPurple,
          ),
        )
      ),
    );
  }
}