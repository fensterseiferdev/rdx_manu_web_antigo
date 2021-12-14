import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/sheet_equipment.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class SendEquipmentsToStore extends StatelessWidget {
  final List<SheetEquipment> sheetEquipments;
  const SendEquipmentsToStore(this.sheetEquipments);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: FutureBuilder(
          future: context.read<CloudFirestoreProvider>().saveSheetEquipments(sheetEquipments),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: CustomText(
                      text: 'Equipamentos enviados com sucesso!',
                      size: 17,
                      color: Color.fromRGBO(89, 98, 115, 1),
                      weight: FontWeight.w600,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 120,
                    height: 35,
                    child: ElevatedButton(
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
                        size: 15,
                        color: Colors.white,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(),
                ],
              );
              
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: CustomText(
                      text: 'Enviando seus equipamentos, aguarde!',
                      size: 17,
                      color: Color.fromRGBO(89, 98, 115, 1),
                      weight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 15),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 48,
                            height: 48,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                lightPurple,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(),
                ],
              );
            }
          }
        ),
      ),
    );
  }
}
