import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/helpers/validators.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final PageController pageController = PageController();

  bool sendingEmail = false;

  bool invalidEmail = false;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    Future<void> _sendResetPasswordEmail() async {
      setState(() => sendingEmail = true);
      try {
        if (!emailValid(emailController.text)) {
          setState(() => invalidEmail = true);
          emailController.clear();
        } else {
          await auth.sendPasswordResetEmail(email: emailController.text);
          pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 10),
            action: SnackBarAction(
              textColor: Colors.white,
              onPressed: () =>
                  launch('https://api.whatsapp.com/send?phone=555511989865532&text=Ol%C3%A1!%20Preciso%20de%20suporte%20com%20a%20RDX%20Manu.'),
              label: 'Falar com o suporte',
            ),
            content: const CustomText(
              text: 'Não foi possível completar a sua solicitação.\nEntre em contato com o suporte - 55 11 9 8986-5532',
              align: TextAlign.center,
            ),
          ),
        );
      }
      setState(() => sendingEmail = false);
    }

    return Dialog(
      child: SizedBox(
        width: 380,
        height: 390,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            //RESET PASS FORM
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.lock,
                        size: 60,
                        color: lightPurple,
                      ),
                      const SizedBox(height: 15),
                      const CustomText(
                        text: 'Recadastrar Senha',
                        size: 24,
                        weight: FontWeight.w600,
                      ),
                      const CustomText(
                        text: 'Informe o seu e-mail para que possamos enviar um link para redefinir a sua senha.',
                        size: 13,
                        maxLines: 2,
                        weight: FontWeight.w600,
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        enabled: !sendingEmail,
                        onFieldSubmitted: (value) async {
                          await _sendResetPasswordEmail();
                        },
                        controller: emailController,

                        onChanged: (email) {
                          setState(() => invalidEmail = false);
                        },
                        cursorColor: lightPurple,
                        decoration: InputDecoration(
                          hintText: invalidEmail ? 'Email inválido' : 'Digite seu email atual',
                          isDense: true,
                          hintStyle: GoogleFonts.poppins(
                            color: invalidEmail ? Colors.red : lightPurple,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          fillColor: bgFormFiel,
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
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 180,
                        height: 35,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              bgButton,
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: sendingEmail ? null : _sendResetPasswordEmail,
                          child: sendingEmail
                              ? const SizedBox(
                                  width: 26,
                                  height: 26,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : CustomText(
                                text: 'Confirmar',
                                color: strongPurple,
                                weight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //EMAIL SENDED ADVICE
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.check,
                        size: 60,
                        color: Colors.green,
                      ),
                      SizedBox(height: 15),
                      CustomText(
                        text: 'Seu email foi enviado com sucesso!',
                        size: 18,
                        maxLines: 2,
                        weight: FontWeight.w600,
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34),
                        child: CustomText(
                          text: 'Por favor, verifique sua caixa de email para redefinir sua senha',
                          align: TextAlign.justify,
                          weight: FontWeight.w600,
                          size: 16,
                          color: Colors.grey,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 180,
                  height: 35,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        bgButton,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: CustomText(
                      text: 'Fechar',
                      color: strongPurple,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 35),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
