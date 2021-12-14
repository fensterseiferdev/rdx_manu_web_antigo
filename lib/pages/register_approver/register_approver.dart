import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/constants/instances.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/helpers/validators.dart';
import 'package:rdx_manu_web/models/company.dart';
import 'package:rdx_manu_web/models/unity.dart';
import 'package:rdx_manu_web/models/unity_user.dart';
import 'package:rdx_manu_web/pages/register_requester/widgets/select_client_dropdown.dart';
import 'package:rdx_manu_web/pages/register_requester/widgets/select_unity_dropdown.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';
import 'package:rdx_manu_web/widgets/client_pass_confirmation.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

import '../../locator.dart';

class RegisterApproverPage extends StatefulWidget {

  @override
  _RegisterApproverPageState createState() => _RegisterApproverPageState();
}

class _RegisterApproverPageState extends State<RegisterApproverPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  Company? company;

  Unity? unity;

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
              text: 'CADASTRAR APROVADOR',
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
                        text: 'Cadastramento de aprovador',
                        size: 28,
                        color: strongPurple,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 90,
                                child: TextFormField(
                                  controller: fullNameController,
                                  validator: (fullName) {
                                    if(fullName!.isEmpty) {
                                      return 'Digite um nome';
                                    } else {
                                      return null;
                                    }
                                  },
                                  cursorColor: lightPurple,
                                  decoration: registerFormFieldsDecoration.copyWith(
                                    hintText: 'Nome completo',
                                    hintStyle: TextStyle(
                                      color:  mediumBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 50),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 35),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(246, 245, 247, 1),
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(
                                    color: const Color.fromRGBO(237, 234, 242, 1),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                height: 55,
                                child: FutureBuilder<List<Company>>(
                                  future: context.read<CloudFirestoreProvider>().loadCompanies(),
                                  builder: (context, snapshot) {
                                    if(snapshot.connectionState == ConnectionState.done) {
                                      return SelectClientDropdown(
                                        company,
                                        snapshot.data!,
                                        (Company company) {
                                          setState(() {
                                            this.company = company;
                                            unity = null;
                                          });
                                        }
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 90,
                                child: TextFormField(
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
                                    hintStyle: TextStyle(
                                      color:  mediumBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 50),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 35),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(246, 245, 247, 1),
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(
                                    color: const Color.fromRGBO(237, 234, 242, 1),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                height: 55,
                                child: company == null ? const SizedBox() : FutureBuilder<List<Unity>>(
                                  future: context.read<CloudFirestoreProvider>().loadUnits(company!.uid),
                                  builder: (context, snapshot) {
                                    if(snapshot.connectionState == ConnectionState.done) {
                                      return SelectUnityDropdown(
                                        unity,
                                        snapshot.data!,
                                        (Unity unity) {
                                          setState(() {
                                            this.unity = unity;
                                          });
                                        }
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 90,
                                child: TextFormField(
                                  controller: passController,
                                  validator: (pass) {
                                    if(pass!.isEmpty) {
                                      return 'Digite uma senha para o aprovador';
                                    } else if(pass.length < 8) {
                                      return 'Digite uma senha com pelo menos 8 caracteres';
                                    } else {
                                      return null;
                                    }
                                  },
                                  cursorColor: lightPurple,
                                  decoration: registerFormFieldsDecoration.copyWith(
                                    hintText: 'Senha',
                                    hintStyle: TextStyle(
                                      color:  mediumBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 50),
                            Expanded(child: Container()),
                          ],
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
                                onPressed: () {
                                  fullNameController.clear();
                                  emailController.clear();
                                  passController.clear();
                                  setState(() {
                                    company = null;
                                    unity = null;
                                  }); 
                                },
                                child: const CustomText(
                                  text: 'Cancelar',
                                  color: Color.fromRGBO(126, 126, 126, 1),
                                  size: 14,
                                ),
                              ),
                              const SizedBox(width: 15),
                              OutlinedButton(
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
                                onPressed: () async {
                                  if(_formKey.currentState!.validate() && company != null && unity != null) {
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
                                          company: company,
                                          unity: unity,
                                          unityUser: UnityUser(
                                            uid: userResult.user!.uid,
                                            name: fullNameController.text,
                                            userType: 'approver',
                                            email: emailController.text,
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
                                }, 
                                child: const CustomText(
                                  text: 'Adicionar a lista',
                                  color: const Color.fromRGBO(1, 110, 255, 1),
                                  size: 14,
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