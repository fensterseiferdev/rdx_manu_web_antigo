import 'package:flutter/material.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class StageTapeIndicator extends StatelessWidget {
  final ServiceOrder serviceOrder;
  const StageTapeIndicator(this.serviceOrder);

  @override
  Widget build(BuildContext context) {
    String stageText() {
      if (serviceOrder.stage == -1) {
        return 'ORÇAMENTO RECUSADO PELA UNIDADE';
      } else if (serviceOrder.stage == 0) {
        return 'ALOCAÇÃO PENDENTE';
      } else if (serviceOrder.stage == 1) {
        return 'AGUARDANDO ORÇAMENTO DO MECÂNICO';
      } else if (serviceOrder.stage == 2) {
        return 'AGUARDANDO APROVAÇÃO DA UNIDADE';
      } else if (serviceOrder.stage == 3) {
        return 'VERIFIQUE O ORÇAMENTO';
      } else if (serviceOrder.stage == 4) {
        return 'AGUARDANDO FINALIZAÇÃO DO MECÂNICO';
      } else if (serviceOrder.stage == 5 && serviceOrder.rate == 0) {
        return 'SERVIÇO CONCLUÍDO';
      } else if (serviceOrder.rate > 0) {
        return 'SERVIÇO CONCLUÍDO E AVALIADO';
      } else {
        return '';
      }
    }

    Color stageTextColor() {
      if (serviceOrder.stage == -1) {
        return const Color.fromRGBO(250, 90, 89, 1);
      } else if ([0, 1, 2, 3, 4].contains(serviceOrder.stage)) {
        return Colors.orange;
      } else if (serviceOrder.stage == 5 && serviceOrder.rate == 0) {
        return const Color.fromRGBO(0, 183, 79, 1);
      } else if (serviceOrder.rate > 0) {
        return const Color.fromRGBO(1, 110, 255, 1);
      } else {
        return Colors.transparent;
      }
    }

    Color? stageTapeColor() {
      if (serviceOrder.stage == -1) {
        return const Color.fromRGBO(255, 219, 219, 1);
      } else if ([0, 1, 2, 3, 4].contains(serviceOrder.stage)) {
        return Colors.orange[50];
      } else if (serviceOrder.stage == 5 && serviceOrder.rate == 0) {
        return const Color.fromRGBO(219, 255, 235, 1);
      } else if (serviceOrder.rate > 0) {
        return const Color.fromRGBO(219, 232, 255, 1);
      } else {
        return Colors.transparent;
      }
    }

    return Container(
      alignment: Alignment.center,
      color: stageTapeColor(),
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (serviceOrder.stage == -1)
              Container(
                width: 21,
                height: 21,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: stageTextColor(),
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: stageTextColor(),
                ),
              )
            else
              Icon(
                Icons.info_outline,
                color: stageTextColor(),
              ),
            CustomText(
              text: stageText(),
              size: 16,
              color: stageTextColor(),
            ),
          ],
        ),
      ),
    );
  }
}
