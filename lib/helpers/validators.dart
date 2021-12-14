import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rdx_manu_web/widgets/email_already_exists.dart';

bool emailValid(String email) {
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
  return regex.hasMatch(email);
}

void emailAlreadyExists(String error, BuildContext context) {
  if (error.contains('[firebase_auth/email-already-in-use]')) {
    showDialog(
      context: context, 
      builder: (context) => EmailAlreadyExists(),
    );
  }
}
