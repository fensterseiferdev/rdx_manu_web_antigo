import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/helpers/formatters.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class LaborInformations extends StatelessWidget {

  final ServiceOrder serviceOrder;
  const LaborInformations(this.serviceOrder);

  @override
  Widget build(BuildContext context) {

    String laborValue() {
      double laborValue = 0;
      
      laborValue += serviceOrder.laborCostPerHour! * serviceOrder.laborHours!;
      laborValue += (serviceOrder.laborCostPerHour! * serviceOrder.laborMinutes!) / 60;

      return brasilCurrencyFormat(laborValue);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 25, bottom: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Custo de mão de obra:',
                  color: mediumBlue,
                  size: 16,
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: 'Tempo:',
                        color: mediumBlue,
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                      const SizedBox(width: 30),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(246, 247, 251, 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                          child: CustomText(
                            text: '${serviceOrder.laborHours}:${serviceOrder.laborMinutes}',
                            color: mediumBlue,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: 'Valor:',
                        color: mediumBlue,
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                      const SizedBox(width: 30),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(246, 247, 251, 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                          child: CustomText(
                            text: laborValue(),
                            color: mediumBlue,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Custo da visita técnica:',
                  color: mediumBlue,
                  size: 16,
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: 'Visita técnica:',
                        color: mediumBlue,
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                      const SizedBox(width: 30),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(246, 247, 251, 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                          child: CustomText(
                            text: brasilCurrencyFormat(
                              serviceOrder.technicalVisitCost! + serviceOrder.travelCost!,
                            ),
                            color: mediumBlue,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                CustomText(
                  text: '*Obs.: o valor deste item contempla a saída\n do técnico e adicional de deslocamento,\n se houver.',
                  size: 12,
                  style: FontStyle.italic,
                  color: mediumBlue,
                  weight: FontWeight.normal,
                  maxLines: 3,
                ),
                const SizedBox(height: 5),
                CustomText(
                  text: '*Custo de R\$2,00 por km acima de 100km\n de deslocamento total.',
                  size: 12,
                  style: FontStyle.italic,
                  color: mediumBlue,
                  weight: FontWeight.normal,
                  maxLines: 3,
                ),
              ],
            ), 
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
