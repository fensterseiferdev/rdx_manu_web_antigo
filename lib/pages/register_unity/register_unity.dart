
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/company.dart';
import 'package:rdx_manu_web/pages/register_unity/widgets/company_picker_dropdown_button.dart';
import 'package:rdx_manu_web/provider/add_provider.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

import '../../locator.dart';

class RegisterUnityPage extends StatefulWidget {

  @override
  _RegisterUnityPageState createState() => _RegisterUnityPageState();
}

class _RegisterUnityPageState extends State<RegisterUnityPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController cnpjController = TextEditingController();

  Company? _selectedCompany;

  
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
              text: 'CADASTRAR UNIDADE',
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
                        text: 'Cadastramento de unidade',
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
                                  controller: nameController,
                                  validator: (name) {
                                    if(name!.isEmpty) {
                                      return 'Digite um nome para a unidade';
                                    } else {
                                      return null;
                                    }
                                  },
                                  cursorColor: lightPurple,
                                  decoration: registerFormFieldsDecoration.copyWith(
                                    hintText: 'Nome da unidade',
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
                              child: SizedBox(
                                height: 90,
                                child: TextFormField(
                                  controller: addressController,
                                  validator: (address) {
                                    if(address!.isEmpty) {
                                      return 'Digite um endereço válido';
                                    } else {
                                      return null;
                                    }
                                  },
                                  cursorColor: lightPurple,
                                  decoration: registerFormFieldsDecoration.copyWith(
                                    hintText: 'Endereço',
                                    hintStyle: TextStyle(
                                      color:  mediumBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                            FutureBuilder<List<Company>>(
                              future: context.read<CloudFirestoreProvider>().loadCompanies(),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done) {
                                  return CompanyPickerDropdownButton(
                                    snapshot.data!, _selectedCompany,
                                    (Company company) {
                                      _selectedCompany = company;
                                    }
                                  );
                                } else {
                                  return Expanded(
                                    child: Container(
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
                                    ),
                                  );
                                }
                              }
                            ),
                            const SizedBox(width: 50),
                            Expanded(
                              child: SizedBox(
                                height: 90,
                                child: TextFormField(
                                  controller: cnpjController,
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
                                    hintText: 'CNPJ',
                                    hintStyle: TextStyle(
                                      color:  mediumBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CnpjInputFormatter(),
                                  ],
                                ),
                              ),
                            ),
                            
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
                                  nameController.clear();
                                  addressController.clear();
                                  cnpjController.clear();
                                  _selectedCompany = null;
                                  setState(() {});
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
                                    _formKey.currentState!.save();
                                    await context.read<AddProvider>().addUnity(
                                      name: nameController.text,
                                      cnpj: cnpjController.text,
                                      address: addressController.text,
                                      company: _selectedCompany!,
                                    );
                                    nameController.clear();
                                    addressController.clear();
                                    cnpjController.clear();
                                    _selectedCompany = null;
                                    setState(() {});
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