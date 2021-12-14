import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class LaborTime extends StatelessWidget {

  final ServiceOrder serviceOrder;
  const LaborTime(this.serviceOrder);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Material(
                color: const Color.fromRGBO(246, 247, 251, 1),
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                  child: CustomText(
                    text: 'TEMPO - MÃO DE OBRA',
                    size: 15,
                    color:  mediumBlue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: CustomText(
                text: '${serviceOrder.laborHours}h${serviceOrder.laborMinutes}min',
                size: 30,
                color:  mediumBlue,
                weight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
