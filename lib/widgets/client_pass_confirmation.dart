import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/instances.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class ClientPassConfirmation extends StatefulWidget {
  
  @override
  _ClientPassConfirmationState createState() => _ClientPassConfirmationState();
}

class _ClientPassConfirmationState extends State<ClientPassConfirmation> {
  final TextEditingController passController = TextEditingController();

  bool wrongPassword = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 300,
        child: Material(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 15,
                ),
                child: TextFormField(
                  controller: passController,
                  onChanged: (value) {
                    if(wrongPassword) {
                      setState(() => wrongPassword = false);
                    }
                  },
                  cursorColor: lightPurple,
                  decoration: InputDecoration(
                    hintText: wrongPassword ? 'Senha incorreta' : 'Digite a sua senha',
                    hintStyle: wrongPassword ? const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ) : null,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: lightPurple,
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: lightPurple,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: lightPurple,
                      ),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: lightPurple,
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: lightPurple,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          lightPurple,
                        ),
                      ),
                      onPressed: () async {
                        try{
                          final credential = EmailAuthProvider.credential(
                            email: auth.currentUser!.email!, password: passController.text,
                          );
                          await auth.currentUser!.reauthenticateWithCredential(credential);
                          Navigator.of(context).pop(passController.text);
                        }catch(e) {
                          passController.clear();
                          setState(() {
                            wrongPassword = true;
                          });
                        }
                      },
                      child: const CustomText(
                        text: 'Confirmar',
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
