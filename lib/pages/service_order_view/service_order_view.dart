import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/action_button.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/budget_informations.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/equipment_informations.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/event_dates_display.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/labor_informations.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/labor_time.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/manual_inclusions_list_table.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/os_part_list_table.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/progress.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/rate.dart';
import 'package:rdx_manu_web/pages/service_order_view/widgets/stage_tape_indicator.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class ServiceOrderViewPage extends StatefulWidget {
  final ServiceOrder serviceOrder;
  const ServiceOrderViewPage(this.serviceOrder);

  @override
  _ServiceOrderViewPageState createState() => _ServiceOrderViewPageState();
}

class _ServiceOrderViewPageState extends State<ServiceOrderViewPage> {
  @override
  Widget build(BuildContext context) {

    String createdDate() {
      final date = widget.serviceOrder.createdAt;
      return '${date.day}/${date.month}/${date.year}';
    }

    void responseHandler(Map<String, dynamic> response) {
      if(widget.serviceOrder.stage == 0) {
        widget.serviceOrder.allocatedAt = (response['event_dates.allocated'] as Timestamp).toDate();
        widget.serviceOrder.mechanicalUidRef = response['references.mechanical_uid'].toString();
        widget.serviceOrder.stage = int.parse(response['stage'].toString());
        setState(() {});
      } else if(widget.serviceOrder.stage == -1) {
        if(response.containsKey('descount')) {
          widget.serviceOrder.stage = 2;
          widget.serviceOrder.descount = double.parse(response['descount'].toString());
          setState(() {});
        } else {
          widget.serviceOrder.stage = 2;
          setState(() {});
        }
      } else if(widget.serviceOrder.stage == 3) {
        widget.serviceOrder.stage = 4;
        widget.serviceOrder.approvedPvAt = (response['event_dates.client_approved'] as Timestamp).toDate();
        setState(() {});
      }
    }

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 35, bottom: 20),
                child: CustomText(
                  text: 'ORDEM DE SERVIÇO',
                  size: 44,
                  color: lightPurple,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Material(
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Manutenção de equipamento',
                                    size: 23,
                                    color:  mediumBlue,
                                  ),
                                  CustomText(
                                    text: '#0${widget.serviceOrder.index}',
                                    size: 25,
                                    color:  mediumBlue,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomText(
                                    text: 'Data de criação: ${createdDate()}',
                                    size: 16,
                                    color: lightGrey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        StageTapeIndicator(widget.serviceOrder),
                        const SizedBox(height: 30),
                        EquipmentInformations(widget.serviceOrder),
                        const SizedBox(height: 30),
                        if(widget.serviceOrder.osParts != null && widget.serviceOrder.osParts!.isNotEmpty)
                          OsPartListTable(widget.serviceOrder.osParts),
                        if(widget.serviceOrder.stage >= 2 || widget.serviceOrder.stage == -1)
                          LaborInformations(widget.serviceOrder),
                        if(widget.serviceOrder.manualInclusions != null && widget.serviceOrder.manualInclusions!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ManualInclusionsListTable(widget.serviceOrder.manualInclusions),
                          ),
                        if(widget.serviceOrder.stage >= 2 || widget.serviceOrder.stage == -1)
                          Padding(
                            padding: const EdgeInsets.only(top: 35),
                            child: BudgetInformations(widget.serviceOrder),
                          ),
                        ActionButton(widget.serviceOrder, (Map<String, dynamic> response) => responseHandler(response)),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 280,
                  child: Column(
                    children: [
                      Material(
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
                                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                                    child: CustomText(
                                      text: 'INFORMAÇÕES DA EMPRESA',
                                      size: 15,
                                      color:  mediumBlue,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              CustomText(
                                text: 'Empresa: ${widget.serviceOrder.companyName}',
                                color:  mediumBlue,
                                size: 15,
                              ),
                              const SizedBox(height: 10),
                              CustomText(
                                text: 'Unidade: ${widget.serviceOrder.unityName}',
                                color:  mediumBlue,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Progress(widget.serviceOrder),
                      if(widget.serviceOrder.laborCostPerHour != null && widget.serviceOrder.laborHours != null && widget.serviceOrder.laborMinutes != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: LaborTime(widget.serviceOrder),
                        ),
                      const SizedBox(height: 15),
                      EventDatesDisplay(widget.serviceOrder),
                      if(widget.serviceOrder.rate > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Rate(widget.serviceOrder),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
