import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/progress_item.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class Progress extends StatelessWidget {
  final ServiceOrder serviceOrder;
  const Progress(this.serviceOrder);

  @override
  Widget build(BuildContext context) {

    final List<ProgressItem> progressItems = [
      ProgressItem(name: 'Chamado aberto', isChecked: serviceOrder.stage >= -1),
      ProgressItem(name: 'Orçamento pendente', isChecked: serviceOrder.stage >= 1 || serviceOrder.stage == -1),
      ProgressItem(name: 'Chamado orçado', isChecked: serviceOrder.stage >= 2 || serviceOrder.stage == -1),
      ProgressItem(name: 'Orçamento aprovado', isChecked: serviceOrder.stage >= 4),
      ProgressItem(name: 'Chamado finalizado', isChecked: serviceOrder.stage >= 5),
      ProgressItem(name: 'Serviço avaliado', isChecked: serviceOrder.rate > 0),
    ];

    Widget progressCheck({required String progressName, required bool isChecked}) {
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            if(isChecked)
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(0, 183, 79, 1),
                ),
                child: const Icon(
                  Icons.check,
                  size: 15,
                  color: Colors.white,
                ),
              )
            else
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(width: 10),
            CustomText(
              text: progressName,
              color:  mediumBlue,
              size: 15,
            ),
          ],
        ),
      );
    }

    return Material(
      color: Colors.white,
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Material(
                color: const Color.fromRGBO(246, 247, 251, 1),
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                  child: CustomText(
                    text: 'ANDAMENTO',
                    size: 15,
                    color:  mediumBlue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: progressItems.map((progress) {
                return Column(
                  children: [
                    progressCheck(
                      progressName: progress.name,
                      isChecked: progress.isChecked,
                    ),
                    if(progressItems.last.name != progress.name)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(19, 6, 0, 6),
                          width: 2,
                          height: 35,
                          color: const Color.fromRGBO(195, 200, 210, 1),
                        ),
                      ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}


