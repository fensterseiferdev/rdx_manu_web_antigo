import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color light = const Color(0xFFEDEAF2);
Color lightPurple = const Color(0xFFC6C6E3);
Color strongPurple = const Color(0xFF493878);
Color strongLightPurple = const Color.fromRGBO(121, 121, 204, 1);
Color mediumBlue = const Color.fromRGBO(35, 48, 71, 1);
Color strongBlue = const Color.fromRGBO(89, 98, 115, 1);
Color lightGrey = const Color(0xFFC3C8D2);
Color filterBlue = const Color(0xFF6886FF);
Color bgFormFiel = const Color.fromRGBO(246, 245, 247, 1);
Color bgButton = const Color.fromRGBO(204, 209, 255, 1);

final registerFormFieldsDecoration = InputDecoration(
  hintStyle: GoogleFonts.poppins(
    fontSize: 12,
    color: const Color.fromRGBO(35, 48, 71, 1),
    fontWeight: FontWeight.w600,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color.fromRGBO(237, 234, 242, 1),
    ),
    borderRadius: BorderRadius.circular(9),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color.fromRGBO(237, 234, 242, 1),
    ),
    borderRadius: BorderRadius.circular(9),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color.fromRGBO(237, 234, 242, 1),
    ),
    borderRadius: BorderRadius.circular(9),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color.fromRGBO(237, 234, 242, 1),
    ),
    borderRadius: BorderRadius.circular(9),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color.fromRGBO(237, 234, 242, 1),
    ),
    borderRadius: BorderRadius.circular(9),
  ),
  border: InputBorder.none,
  fillColor: const Color.fromRGBO(246, 245, 247, 1),
  filled: true,
);

final addEquipmentToUnityFieldDecoration = InputDecoration(
  labelText: '',
  labelStyle: GoogleFonts.poppins(
    color: Colors.grey,
    fontSize: 13,
    fontWeight: FontWeight.bold,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Color.fromRGBO(125, 125, 207, 1),
      width: 2.0,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Color.fromRGBO(125, 125, 207, 1),
      width: 2.0,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Color.fromRGBO(125, 125, 207, 1),
      width: 2.0,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Color.fromRGBO(125, 125, 207, 1),
      width: 2.0,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Color.fromRGBO(125, 125, 207, 1),
      width: 2.0,
    ),
  ),
);
