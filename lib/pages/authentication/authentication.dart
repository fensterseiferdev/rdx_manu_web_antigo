import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/helpers/validators.dart';
import 'package:rdx_manu_web/locator.dart';
import 'package:rdx_manu_web/pages/authentication/widgets/custom_background.dart';
import 'package:rdx_manu_web/pages/authentication/widgets/forgot_password.dart';
import 'package:rdx_manu_web/pages/authentication/widgets/sign_in_error.dart';
import 'package:rdx_manu_web/provider/auth_provider.dart';
import 'package:rdx_manu_web/routing/routes.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final breakPoint = mediaQueryWidth >= 1140;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color.fromRGBO(237, 234, 242, 1),
        width: 2.0,
      ),
    );

    Future<void> _signIn() async {
      if(_formKey.currentState!.validate()) {
        setState(() => loading = true);
        await context.read<AuthProvider>().signIn(
          email: emailController.text, password: passwordController.text,
          onFail: (e) {
            showDialog(
              context: context,
              builder: (context) => SignInError(authError: e.toString()),
            );
          },
          onSucess: () {
            locator<NavigationService>().globalNavigateTo(layoutRoute, context);
          },
          context: context,
        );
        setState(() => loading = false);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomBackground(),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BEM-VINDO',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: lightPurple,
                        fontSize: 60,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (breakPoint)
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                topLeft: Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Color.fromRGBO(73, 56, 120, 1),
                                  spreadRadius: -1,
                                  offset: Offset(1, 3),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/login.png',
                              height: 500,
                            ),
                          ),
                        Container(
                          height: 500,
                          margin: const EdgeInsets.only(
                              bottom: 16, right: 16, top: 16),
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              topLeft: breakPoint
                                  ? Radius.zero
                                  : const Radius.circular(16),
                              bottomLeft: breakPoint
                                  ? Radius.zero
                                  : const Radius.circular(16),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Color.fromRGBO(73, 56, 120, 1),
                                spreadRadius: -1,
                                offset: Offset(-1, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/logo.svg',
                                  height: 60,
                                ),
                                const SizedBox(height: 35),
                                Text(
                                  'ENTRAR NO SISTEMA',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: strongPurple,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  enabled: !loading,
                                  cursorColor: lightPurple,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (email) {
                                    if (!emailValid(email!)) {
                                      return 'Digite um e-mail válido';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onFieldSubmitted: (value) => _signIn(),
                                  decoration: InputDecoration(
                                    hintText: 'E-mail',
                                    isDense: true,
                                    hintStyle: GoogleFonts.poppins(
                                      color: lightPurple,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    fillColor: bgFormFiel,
                                    filled: true,
                                    errorStyle: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    disabledBorder: border,
                                    enabledBorder: border,
                                    focusedBorder: border,
                                    errorBorder: border,
                                    focusedErrorBorder: border,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  enabled: !loading,
                                  cursorColor: lightPurple,
                                  controller: passwordController,
                                  obscureText: true,
                                  validator: (password) {
                                    if (password!.isEmpty) {
                                      return 'Digite uma senha';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onFieldSubmitted: (value) => _signIn(),
                                  decoration: InputDecoration(
                                    hintText: 'Senha',
                                    isDense: true,
                                    hintStyle: GoogleFonts.poppins(
                                      color: lightPurple,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    fillColor: bgFormFiel,
                                    filled: true,
                                    errorStyle: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    disabledBorder: border,
                                    enabledBorder: border,
                                    focusedBorder: border,
                                    errorBorder: border,
                                    focusedErrorBorder: border,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        bgButton,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    onPressed: loading ? null : _signIn,
                                    child: loading
                                        ? const SizedBox(
                                            width: 28,
                                            height: 28,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                Colors.white,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'Entrar',
                                            style: TextStyle(
                                              color: strongPurple,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => ForgotPassword(),
                                      );
                                    },
                                    child: Text(
                                      'Esqueci a senha',
                                      style: TextStyle(
                                        color: strongPurple,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Todos os direitos reservados - RDX Group.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: lightPurple,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
