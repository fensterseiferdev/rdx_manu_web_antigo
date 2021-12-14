import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final int? maxLines;
  final FontStyle? style;
  final TextAlign? align;

  const CustomText({required this.text, this.size, this.color, this.weight, this.maxLines, this.style, this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: align ?? TextAlign.start,
      style: GoogleFonts.poppins(
        fontSize: size ?? 16,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.bold,
        fontStyle: style ?? FontStyle.normal,
      ),
    );
  }
}
