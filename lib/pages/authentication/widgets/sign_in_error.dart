import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class SignInError extends StatelessWidget {

  final String authError;

  const SignInError({required this.authError});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Color.fromRGBO(88, 88, 88, 1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const CustomText(
              text: 'Conta inválida!',
              color: Colors.black,
              size: 22,
              weight: FontWeight.w500,
            ),
            const SizedBox(height: 14),
            Center(
              child: Wrap(
                children: [
                  CustomText(
                    text: authError.contains('[firebase_auth/user-not-found]') ?  
                      'Email e senha não encontrados. \nPor favor, tente novamente' : 
                      authError.contains('[firebase_auth/wrong-password]') ? 
                      'Senha incorreta! Por favor, tente novamente' : 
                      authError.contains('Conta desativada!') ?
                      'Sua conta foi desativada.' :
                      'Erro ao acessar o sistema. \nPor favor, tente novamente',
                    align: TextAlign.center,
                    color: Colors.black,
                    size: 16,
                    maxLines: 2,
                    weight: FontWeight.w500,
                  ),
                ],  
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  lightPurple,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const CustomText(
                text: 'Fechar',
                color: Colors.white,
                size: 16,
                weight: FontWeight.w500,
                ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}