import 'package:flutter/material.dart';

class EquipmentImageView extends StatelessWidget {

  final String img;
  const EquipmentImageView(this.img);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 350,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: NetworkImage(img),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}