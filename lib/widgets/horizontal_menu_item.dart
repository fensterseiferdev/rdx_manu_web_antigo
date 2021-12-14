import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:rdx_manu_web/constants/style.dart';


class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final String itemAsset;
  final Function onTap;
  const HorizontalMenuItem({required this.itemName, required this.itemAsset, required this.onTap});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () => onTap(),
        child: SizedBox(
          width: 100,
          child: Column(
            children: [
              const SizedBox(height: 3),
              CircleAvatar(
                backgroundColor: light,
                radius: 21,
                child: SvgPicture.asset(
                  itemAsset,
                  color: strongPurple,
                  height: 22,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                itemName,
                style: GoogleFonts.poppins(
                  color: strongPurple,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
