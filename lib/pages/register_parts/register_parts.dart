
import 'package:csv_picker_button/csv_picker_button.dart';
import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/part.dart';
import 'package:rdx_manu_web/pages/register_parts/widgets/send_parts_to_store.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../locator.dart';

class RegisterPartsPage extends StatefulWidget {
  @override
  _RegisterPartsPageState createState() => _RegisterPartsPageState();
}

class _RegisterPartsPageState extends State<RegisterPartsPage> {

  List<SheetPart> sheetParts = [];

  bool processing = false;

  @override
  Widget build(BuildContext context) {


      return ListView(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CustomText(
              text: 'IMPORTAR PLANILHA DE PEÇAS',
              maxLines: 1,
              align: TextAlign.center,
              color: lightPurple,
              weight: FontWeight.bold,
              size: 56,
            ),
          ),
          CustomText(
            text: 'Crie ou atualize os registros por meio de planilhas CSV.',
            align: TextAlign.center,
            color:  mediumBlue,
            weight: FontWeight.w600,
            size: 15,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: '1',
                  color: lightPurple,
                  weight: FontWeight.bold,
                  size: 56,
                ),
                const SizedBox(width: 18),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color.fromRGBO(73, 56, 120, 0.45),
                        spreadRadius: -1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Utilize a planilha modelo, insira e salve os seus dados. Mantenha essa planilha salva para as suas futuras atualizações de dados.',
                        color:  mediumBlue,
                        weight: FontWeight.w500,
                        size: 13,
                        maxLines: 5,
                      ),
                      InkWell(
                        onTap: () async {
                          await launch(
                            'https://firebasestorage.googleapis.com/v0/b/rdx-manu.appspot.com/o/modelo%2Fplanilhas%2FPe%C3%A7as.csv?alt=media&token=d0870c46-b857-4f6c-9fd4-d592d706a027',
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.download_rounded, color: strongPurple),
                            CustomText(
                              text: 'Baixar planilha modelo',
                              color: strongPurple,
                              weight: FontWeight.w500,
                              size: 13,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: '2',
                  color: lightPurple,
                  weight: FontWeight.bold,
                  size: 56,
                ),
                const SizedBox(width: 10),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color.fromRGBO(73, 56, 120, 0.45),
                        spreadRadius: -1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CustomText(
                    text: 'Tenha cuidado para não repetir o campo "código" na planilha. Caso isso ocorra, somente um equipamento será cadastrado de todos que tiverem o mesmo código.',
                    color:  mediumBlue,
                    weight: FontWeight.w500,
                    size: 13,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: '3',
                  color: lightPurple,
                  weight: FontWeight.bold,
                  size: 56,
                ),
                const SizedBox(width: 10),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color.fromRGBO(73, 56, 120, 0.45),
                        spreadRadius: -1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CustomText(
                    text: 'Para criar novos registros, insira um novo código que ainda não está sendo utilizado nos seus cadastros, preenchendo todos os dados.',
                    color:  mediumBlue,
                    weight: FontWeight.w500,
                    size: 13,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: '4',
                  color: lightPurple,
                  weight: FontWeight.bold,
                  size: 56,
                ),
                const SizedBox(width: 10),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color.fromRGBO(73, 56, 120, 0.45),
                        spreadRadius: -1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CustomText(
                    text: 'Ao finalizar o preenchimento da planilha modelo, salve no formato CSV(Separado por Ponto e Vírgula). Anexe sua planilha e aguarde o processamento ser realizado.',
                    color:  mediumBlue,
                    weight: FontWeight.w500,
                    size: 13,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 35,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.black12,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                      ),
                    ),
                    onPressed: processing ? null : () {
                      locator<NavigationService>().goBack();
                    },
                    child: CustomText(
                      text: 'Voltar',
                      color:  mediumBlue,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                SizedBox(
                  height: 35,
                  child: CsvButton(
                    buttonStyle: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.black12,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                      ),
                    ),
                    csvConfiguration: CsvConfiguration(separator: Separator.semicolon),
                    onJsonReceived: (import) {
                      if(!processing) {
                        setState(() => processing = true);
                      }
                      try{
                        sheetParts.add(SheetPart.fromSheet(import));
                      } catch(e) {}
                    },
                    onDone: () async {
                      setState(() => processing = false);
                      await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => SendPartsToStore(sheetParts),
                      );
                    },
                    child: processing ? 
                    SizedBox(
                      width: 23,
                      height: 23,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(
                          lightPurple,
                        ),
                      ),
                    ) :
                    CustomText(
                      text: 'Anexar planilha',
                      color:  mediumBlue,
                      weight: FontWeight.w600,
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
