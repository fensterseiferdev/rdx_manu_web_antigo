import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/helpers/formatters.dart';
import 'package:rdx_manu_web/locator.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/routing/routes.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class ServiceOrderResumeCard extends StatelessWidget {

  final ServiceOrder serviceOrder;
  const ServiceOrderResumeCard(this.serviceOrder);

  @override
  Widget build(BuildContext context) {

    String stageToString() {
      if (serviceOrder.rate > 0) {
        return 'Avaliada';
      } else if (serviceOrder.stage == 5 || serviceOrder.stage == 6) {
        return 'Finalizada';
      } else if (serviceOrder.stage == 4) {
        return 'Em execução';
      } else if (serviceOrder.stage == 3) {
        return 'Aprovação p.s. pendente';
      } else if (serviceOrder.stage == -1) {
        return 'Reprovada';
      } else if (serviceOrder.stage == 2) {
        return 'Aprovação un. pendente';
      } else if (serviceOrder.stage == 1) {
        return 'Orçamento pendente';
      } else {
        return 'Alocação pendente';
      }
    }

    Color stageColor() {
      if (serviceOrder.rate > 0) {
        return const Color.fromRGBO(1, 110, 255, 1);
      } else if (serviceOrder.stage == 5) {
        return const Color.fromRGBO(0, 183, 79, 1);
      } else if (serviceOrder.stage == 4) {
        return const Color.fromRGBO(1, 110, 255, 1);
      } else if (serviceOrder.stage == 3) {
        return const Color.fromRGBO(250, 153, 89, 1);
      } else if (serviceOrder.stage == -1) {
        return const Color.fromRGBO(250, 90, 89, 1);
      } else if (serviceOrder.stage == 2) {
        return const Color.fromRGBO(250, 153, 89, 1);
      } else if (serviceOrder.stage == 1) {
        return const Color.fromRGBO(250, 153, 89, 1);
      } else {
        return const Color.fromRGBO(73, 56, 120, 1);
      }
    }

    Color stageBackgrondColor() {
      if (serviceOrder.rate > 0) {
        return const Color.fromRGBO(219, 232, 255, 1);
      } else if (serviceOrder.stage == 5) {
        return const Color.fromRGBO(219, 255, 235, 1);
      } else if (serviceOrder.stage == 4) {
        return const Color.fromRGBO(219, 232, 255, 1);
      } else if (serviceOrder.stage == 3) {
        return const Color.fromRGBO(255, 245, 219, 1);
      } else if (serviceOrder.stage == -1) {
        return const Color.fromRGBO(255, 219, 219, 1);
      } else if (serviceOrder.stage == 2) {
        return const Color.fromRGBO(255, 245, 219, 1);
      } else if (serviceOrder.stage == 1) {
        return const Color.fromRGBO(255, 245, 219, 1);
      } else {
        return const Color.fromRGBO(198, 198, 227, 1);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 110,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          elevation: 5,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              locator<NavigationService>().navigateTo(
                routeName: serviceOrderPageRoute,
                args: serviceOrder,
              );
            },
            child: Row(
              children: [
                Expanded(
                  flex: 17,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: '#0${serviceOrder.index.toString()}',
                        size: 44,
                        color: lightPurple,
                         
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'NOME DA UNIDADE',
                        size: 13,
                        color: lightPurple,
                         
                      ),
                      CustomText(
                        text: serviceOrder.unityName,
                        size: 12,
                        color:  mediumBlue,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: 'CRIADA EM:',
                        size: 13,
                        color: lightPurple,
                         
                      ),
                      CustomText(
                        text: DateFormat('dd/MM/yyyy').format(serviceOrder.createdAt),
                        size: 12,
                        color:  mediumBlue,
                        weight: FontWeight.bold, 
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'MANUTENÇÃO EM:',
                        size: 13,
                        color: lightPurple,
                      ),
                      CustomText(
                        text: serviceOrder.equipmentName,
                        size: 12,
                        color:  mediumBlue,
                         
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: '',
                        size: 13,
                        color: lightPurple,
                         
                      ),
                      CustomText(
                        text: '',
                        size: 12,
                        color:  mediumBlue,
                         
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Nº DO CHASSI',
                        size: 13,
                        color: lightPurple,
                         
                      ),
                      CustomText(
                        text: serviceOrder.equipmentChassisNumber,
                        size: 12,
                        color:  mediumBlue,
                         
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: 'Nº DA FROTA',
                        size: 13,
                        color: lightPurple,
                         
                      ),
                      CustomText(
                        text: serviceOrder.equipmentFleetNumber,
                        size: 12,
                        color:  mediumBlue,
                         
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 28,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          color: stageBackgrondColor(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: CustomText(
                              text: stageToString(),
                              size: 11,
                              color: stageColor(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: AutoSizeText(
                              'Orçamento total: ${brasilCurrencyFormat(serviceOrder.budget - serviceOrder.descount)}',
                              maxFontSize: 13,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}