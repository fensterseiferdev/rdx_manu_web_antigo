import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/helpers/formatters.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class BudgetInformations extends StatelessWidget {

  final ServiceOrder serviceOrder;
  const BudgetInformations(this.serviceOrder);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(246, 247, 251, 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: mediumBlue,
                  ),
                  const SizedBox(width: 15),
                  CustomText(
                    text: 'ORÇAMENTO TOTAL DO CHAMADO',
                    size: 16,
                    color: mediumBlue,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if(serviceOrder.descount > 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Orçamento sem desconto:',
                        color: mediumBlue,
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(246, 247, 251, 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                          child: CustomText(
                            text: brasilCurrencyFormat(serviceOrder.budget),
                            color: mediumBlue,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Desconto:',
                        color: mediumBlue,
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(246, 247, 251, 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                          child: CustomText(
                            text: brasilCurrencyFormat(serviceOrder.descount),
                            color: mediumBlue,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Orçamento final:',
                  color: mediumBlue,
                  size: 18,
                  weight: FontWeight.w600,
                ),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromRGBO(246, 247, 251, 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    child: CustomText(
                      text: brasilCurrencyFormat(serviceOrder.budget - serviceOrder.descount),
                      color: mediumBlue,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
