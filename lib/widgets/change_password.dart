import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rdx_manu_web/constants/style.dart';

class ChangePassword extends StatefulWidget {

  const ChangePassword();
  
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool wrongCurrentPassword = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: lightPurple,
      ),
    );

    final FirebaseAuth auth = FirebaseAuth.instance;

    bool validator() {
      if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
        return false;
      } else if (passwordController.text.length < 6 || confirmPasswordController.text.length < 6) {
        return false;
      } if (passwordController.text == confirmPasswordController.text) {
        return true;
      } else {
        return false;
      }
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 330,
        height: 410,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Text(
              'Redefinir senha:',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextFormField(
                enableInteractiveSelection: false,
                cursorColor: lightPurple,
                controller: currentPasswordController,
                decoration: InputDecoration(
                  disabledBorder: border,
                  enabledBorder: border,
                  errorBorder: border,
                  focusedBorder: border,
                  focusedErrorBorder: border,
                  hintText:  wrongCurrentPassword ? 'Sua senha esta incorreta' : 'confirme sua senha atual',
                  hintStyle: GoogleFonts.poppins(
                    color: wrongCurrentPassword ? Colors.red : null,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onChanged: (validator) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextFormField(
                enableInteractiveSelection: false,
                cursorColor: lightPurple,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Digite sua nova senha',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  disabledBorder: border,
                  enabledBorder: border,
                  errorBorder: border,
                  focusedBorder: border,
                  focusedErrorBorder: border,
                ),
                onChanged: (validator) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextFormField(
                enableInteractiveSelection: false,
                cursorColor: lightPurple,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirme sua nova senha',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  disabledBorder: border,
                  enabledBorder: border,
                  errorBorder: border,
                  focusedBorder: border,
                  focusedErrorBorder: border,
                ),
                onChanged: (validator) {
                  setState(() {});
                },
              ),
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              width: 130,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    validator() ? lightPurple : Colors.grey,
                  ),
                ),
                onPressed: validator() ? () async {
                  setState(() => loading = true);
                  try{
                    final credential = EmailAuthProvider.credential(
                      email: auth.currentUser!.email!, password: currentPasswordController.text,
                    );
                    await auth.currentUser!.reauthenticateWithCredential(credential);
                    await auth.currentUser!.updatePassword(confirmPasswordController.text);
                    Navigator.of(context).pop(true);
                  } catch(e) {
                    currentPasswordController.clear();
                    setState(() => wrongCurrentPassword = true);
                  }
                  setState(() => loading = false);
                } : null,
                child: loading ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      Colors.white,
                    ),
                  )
                ) : Text(
                  'salvar',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}