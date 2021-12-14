import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/provider/add_provider.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

class RegisterBusinessPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fantasyName = TextEditingController();
  final TextEditingController socialReason = TextEditingController();
  final TextEditingController cnpj = TextEditingController();

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
              text: 'CADASTRAR EMPRESA',
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
                        text: 'Cadastramento de empresa',
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
                            controller: fantasyName,
                            validator: (fantasyName) {
                              if(fantasyName!.isEmpty) {
                                return 'Digite um Nome fantasia';
                              } else {
                                return null;
                              }
                            },
                            cursorColor: lightPurple,
                            decoration: registerFormFieldsDecoration.copyWith(
                              hintText: 'Nome Fantasia',
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
                            controller: socialReason,
                            validator: (socialReason) {
                              if(socialReason!.isEmpty) {
                                return 'Digite uma Razão social';
                              } else {
                                return null;
                              }
                            },
                            cursorColor: lightPurple,
                            decoration: registerFormFieldsDecoration.copyWith(
                              hintText: 'Razão Social',
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
                            controller: cnpj,
                            validator: (cnpj) {
                              if(cnpj!.isEmpty) {
                                return 'Digite um CNPJ';
                              } else if(!CNPJValidator.isValid(cnpj)) {
                                return 'Digite um CNPJ válido';
                              } else {
                                return null;
                              }
                            },
                            cursorColor: lightPurple,
                            decoration: registerFormFieldsDecoration.copyWith(
                              hintText: 'Digite o CNPJ da matriz',
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CnpjInputFormatter(),
                            ],
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
                                onPressed: () {
                                  fantasyName.clear();
                                  socialReason.clear();
                                  cnpj.clear();
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
                                  if(_formKey.currentState!.validate()) {
                                    await context.read<AddProvider>().addBusiness(
                                      fantasyName: fantasyName.text, socialReason: socialReason.text, cnpj: cnpj.text,
                                    );
                                    fantasyName.clear();
                                    socialReason.clear();
                                    cnpj.clear();
                                  }
                                }, 
                                child: const CustomText(
                                  text: 'Adicionar a lista',
                                  color: Color.fromRGBO(1, 110, 255, 1),
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