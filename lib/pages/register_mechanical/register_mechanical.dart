import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/instances.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/helpers/validators.dart';
import 'package:rdx_manu_web/models/unity_user.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';
import 'package:rdx_manu_web/widgets/client_pass_confirmation.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';
import '../../locator.dart';

class RegisterMechanicalPage extends StatefulWidget {

  @override
  _RegisterMechanicalPageState createState() => _RegisterMechanicalPageState();
}

class _RegisterMechanicalPageState extends State<RegisterMechanicalPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final MoneyMaskedTextController costPerHourController = MoneyMaskedTextController();

  bool creatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20, 
        bottom: 20,
        right: MediaQuery.of(context).size.width * .25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: CustomText(
              text: 'CADASTRAR MECÂNICO',
              size: 56,
              color: lightPurple,
            ),
          ),
          
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Cadastramento de mecânico',
                        size: 28,
                        color: strongPurple,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 90,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 45,
                          child: TextFormField(
                            enabled: !creatingAccount,
                            controller: fullNameController,
                            validator: (fullName) {
                              if(fullName!.isEmpty) {
                                return 'Digite o nome completo';
                              } else {
                                return null;
                              }
                            },
                            cursorColor: lightPurple,
                            decoration: registerFormFieldsDecoration.copyWith(
                              hintText: 'Nome completo',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 90,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 45,
                          child: TextFormField(
                            enabled: !creatingAccount,
                            controller: emailController,
                            validator: (email) {
                              if(email!.isEmpty) {
                                return 'Digite um e-mail';
                              } else if(!emailValid(email)) {
                                return 'Digite um e-mail válido';
                              } else {
                                return null;
                              }
                            },
                            cursorColor: lightPurple,
                            decoration: registerFormFieldsDecoration.copyWith(
                              hintText: 'E-mail',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 90,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 45,
                          child: TextFormField(
                            enabled: !creatingAccount,
                            controller: passController,
                            validator: (pass) {
                              if(pass!.isEmpty) {
                                return 'Digite uma senha para o mecânico';
                              } else if(pass.length < 8) {
                                return 'Digite uma senha com pelo menos 8 caracteres';
                              } else {
                                return null;
                              }
                            },
                            cursorColor: lightPurple,
                            decoration: registerFormFieldsDecoration.copyWith(
                              hintText: 'Digite uma senha para o mecânico',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 90,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 45,
                          child: TextFormField(
                            enabled: !creatingAccount,
                            controller: costPerHourController,
                            validator: (costPerHour) {
                              if(costPerHour!.isEmpty) {
                                return 'Digite um valor por hora para o mecânico';
                              } else if(costPerHourController.numberValue <= 0) {
                                return 'Digite um valor por hora maior que 0';
                              } else {
                                return null;
                              }
                            },
                            cursorColor: lightPurple,
                            decoration: registerFormFieldsDecoration,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                BorderSide(
                                  color: strongPurple,
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 14,
                                ),
                              ),
                            ),
                            onPressed: () {
                              locator<NavigationService>().goBack();
                            },
                            child: CustomText(
                              text: 'Voltar',
                              color: strongPurple,
                              size: 14,
                            ),
                          ),
                          Row(
                            children: [
                              OutlinedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                    const BorderSide(
                                      color: Color.fromRGBO(206, 206, 206, 1),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 14,
                                    ),
                                  ),
                                ),
                                onPressed: creatingAccount ? null : () {
                                  fullNameController.clear();
                                  emailController.clear();
                                  passController.clear();
                                  costPerHourController.clear();
                                }, 
                                child: const CustomText(
                                  text: 'Cancelar',
                                  color: Color.fromRGBO(126, 126, 126, 1),
                                  size: 14,
                                ),
                              ),
                              const SizedBox(width: 15),
                              SizedBox(
                                width: 190,
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      const BorderSide(
                                        color: Color.fromRGBO(152, 198, 254, 1),
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 14,
                                      ),
                                    ),
                                  ),
                                  onPressed: creatingAccount ? null : () async {
                                    if(_formKey.currentState!.validate()) {
                                      setState(() => creatingAccount = true);
                                      try{
                                        final clientPass = await showDialog(
                                          context: context, builder: (context) => ClientPassConfirmation(),
                                        );
                                        if(clientPass is String && clientPass.isNotEmpty) {
                                          final currentEmail = auth.currentUser!.email;
                                          final userResult = await auth.createUserWithEmailAndPassword(
                                            email: emailController.text, 
                                            password: passController.text,
                                          );
                                          await context.read<CloudFirestoreProvider>().createUserAccount(
                                            unityUser: UnityUser(
                                              uid: userResult.user!.uid,
                                              name: fullNameController.text,
                                              userType: 'mechanical',
                                              email: emailController.text,
                                              costPerHour: costPerHourController.numberValue,
                                              isActive: false,
                                            ),
                                            context: context,
                                          );
                                          await auth.signInWithEmailAndPassword(
                                            email: currentEmail!, password: clientPass,
                                          );
                                          locator<NavigationService>().goBack();
                                        }
                                      } catch(e) {
                                        emailAlreadyExists(e.toString(), context);
                                      }
                                    }
                                    setState(() => creatingAccount = false);
                                  }, 
                                  child: creatingAccount ? 
                                  const SizedBox(
                                    width: 23,
                                    height: 23,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(
                                        Color.fromRGBO(152, 198, 254, 1),
                                      ),
                                    ),
                                  )
                                  : const CustomText(
                                    text: 'Adicionar a lista',
                                    color: Color.fromRGBO(1, 110, 255, 1),
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}