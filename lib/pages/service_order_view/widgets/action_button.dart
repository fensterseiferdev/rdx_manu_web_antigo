import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/show_mechanicals_list.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/unfreeze_service_order.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class ActionButton extends StatelessWidget {
  final ServiceOrder serviceOrder;
  final Function onAction;
  const ActionButton(this.serviceOrder, this.onAction);

  @override
  Widget build(BuildContext context) {
    if (serviceOrder.stage == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              const BorderSide(
                color: Color.fromRGBO(152, 198, 254, 1),
              ),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            ),
          ),
          onPressed: () async {
            final mechanicalList = 
              await context.read<CloudFirestoreProvider>().loadMechanicals();
            final response = await showDialog(
              barrierDismissible: false,
              context: context, 
              builder: (context) => ShowMechanicalsList(mechanicalList, serviceOrder.uid),
            );
            if(response != null && response is Map<String, dynamic>) {
              onAction(response);
            }
          },
          child: const CustomText(
            text: 'Alocar mecânico',
            size: 16,
            color: Color.fromRGBO(1, 110, 255, 1),
            weight: FontWeight.w500,
          ),
        ),
      );
    } else if(serviceOrder.stage == 2) {
      return Padding(
        padding: const EdgeInsets.only(top: 25, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              text: 'Aguardando aprovação da unidade',
              color: mediumBlue,
              size: 15,
              weight: FontWeight.w600,
            ),
          ],
        ),
      );
    } else if (serviceOrder.stage == 3) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, right: 25),
          child: OutlinedButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Color.fromRGBO(152, 198, 254, 1),
                ),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              ),
            ),
            onPressed: () async {
              final response = await context.read<CloudFirestoreProvider>().approveOs(serviceOrder.uid);
              if(response is Map<String, dynamic> && response.isNotEmpty) {
                onAction(response);
              }
            },
            child: const CustomText(
              text: 'Aprovar',
              size: 19,
              color: Color.fromRGBO(1, 110, 255, 1),
              weight: FontWeight.w500,
            ),
          ),
        ),
      );
    } else if (serviceOrder.stage == -1) {
      return Padding(
        padding: const EdgeInsets.only(top: 25, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Color.fromRGBO(73, 56, 120, 1),
                  ),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                ),
              ),
              onPressed: () async {
                final response = await showDialog(
                  context: context,
                  builder: (context) {
                    return UnfreezeServiceOrder(serviceOrder);
                  }
                );
                if(response != null && response is Map<String, dynamic>) {
                  onAction(response);
                }
              },
              child: const CustomText(
                text: 'Descongelar OS',
                size: 16,
                color: Color.fromRGBO(73, 56, 120, 1),
                weight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
