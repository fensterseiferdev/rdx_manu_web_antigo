// import 'package:flutter/material.dart';
// import 'package:rdx_manu_web/constants/style.dart';
// import 'package:rdx_manu_web/widgets/custom_text.dart';

// class MyAccountPage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 500,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CustomText(
//             text: 'MINHA CONTA',
//             color: lightPurple,
//             size: 56,
//           ),
//           const SizedBox(height: 20),
//           Material(
//             elevation: 5,
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(25, 20, 25, 25),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 80,
//                     child: SizedBox(
//                       height: 45,
//                       child: TextFormField(
//                         minLines: null,
//                         maxLines: null,
//                         expands: true,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color.fromRGBO(246, 245, 247, 1),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rdx_manu_web/constants/instances.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/pages/my_account/widgets/password_changed.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';

import '../../locator.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final TextEditingController currentPasswordController =
      TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool wrongCurrentPassword = false;

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    bool validator() {
      if (currentPasswordController.text.isEmpty) {
        return false;
      } if (passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        return false;
      } else if (passwordController.text.length < 6 ||
          confirmPasswordController.text.length < 6) {
        return false;
      }
      if (passwordController.text == confirmPasswordController.text) {
        return true;
      } else {
        return false;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 0, 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'MINHA CONTA',
                  style: GoogleFonts.poppins(
                    fontSize: 54,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(198, 198, 227, 1),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 25, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: lightPurple,
                            controller: currentPasswordController,
                            onChanged: (validator) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: wrongCurrentPassword
                                  ? 'Sua senha esta incorreta'
                                  : 'confirme sua senha atual',
                              hintStyle: TextStyle(
                                color: wrongCurrentPassword
                                    ? Colors.red
                                    : lightPurple,
                                    
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              isDense: true,
                              fillColor: const Color.fromRGBO(246, 245, 247, 1),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(237, 234, 242, 1),
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(237, 234, 242, 1),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: lightPurple,
                            controller: passwordController,
                            onChanged: (validator) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Digite sua nova senha',
                              isDense: true,
                              hintStyle: TextStyle(
                                color: wrongCurrentPassword
                                    ? Colors.red
                                    : lightPurple,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,    
                              ),
                              fillColor: const Color.fromRGBO(246, 245, 247, 1),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(237, 234, 242, 1),
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(237, 234, 242, 1),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: lightPurple,
                            controller: confirmPasswordController,
                            onChanged: (validator) {
                              if (wrongCurrentPassword) setState(() => wrongCurrentPassword = false);
                              setState(() {});
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Confirme sua nova senha',
                              isDense: true,
                              hintStyle: TextStyle(
                                color: wrongCurrentPassword
                                    ? Colors.red
                                    : lightPurple,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,    
                              ),
                              fillColor: const Color.fromRGBO(246, 245, 247, 1),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(237, 234, 242, 1),
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(237, 234, 242, 1),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 35,
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      const BorderSide(
                                        color:
                                            Color.fromRGBO(183, 160, 246, 1),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    locator<NavigationService>().goBack();
                                  },
                                  child: Text(
                                    'Voltar',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(73, 56, 120, 1),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 90,
                                height: 35,
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      BorderSide(
                                        color: validator()
                                            ? Colors.blue[700]!
                                            : Colors.grey,
                                      ),
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
                                      await showDialog(context: context, builder: (context) => PasswordChanged());
                                      passwordController.clear();
                                      currentPasswordController.clear();
                                      confirmPasswordController.clear();
                                    } catch(e) {
                                      currentPasswordController.clear();
                                      setState(() => wrongCurrentPassword = true);
                                    }
                                    setState(() => loading = false);
                                  } : null,
                                  child: loading ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.blue[700],
                                      ),
                                    )
                                  ) : Text(
                                    'Atualizar',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: validator()
                                          ? Colors.blue[700]
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
