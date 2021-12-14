import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/event_date_item.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class EventDatesDisplay extends StatelessWidget {

  final ServiceOrder serviceOrder;
  const EventDatesDisplay(this.serviceOrder);

  @override
  Widget build(BuildContext context) {

    final List<EventDateItem> eventDateItems = [
      EventDateItem(name: 'Criação:', date: serviceOrder.createdAt, hadHappened: true),
      EventDateItem(name: 'Alocação:', date: serviceOrder.allocatedAt, hadHappened: serviceOrder.allocatedAt != null),
      EventDateItem(name: 'Orçado:', date: serviceOrder.budgetAt, hadHappened: serviceOrder.budgetAt != null),
      EventDateItem(name: 'Aprovado:', date: serviceOrder.approvedUnAt, hadHappened: serviceOrder.approvedUnAt != null),
      EventDateItem(name: 'Aprovado P.V:', date: serviceOrder.approvedPvAt, hadHappened: serviceOrder.approvedPvAt != null),
      EventDateItem(name: 'Finalizado:', date: serviceOrder.osFinishedAt, hadHappened: serviceOrder.osFinishedAt != null),
    ];

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
                    text: 'EVENTOS',
                    size: 15,
                    color:  mediumBlue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: eventDateItems.map((eventDate) {
                if(eventDate.hadHappened) {
                  final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
                  final formattedDate = dateFormat.format(eventDate.date!);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CustomText(
                            text: '${eventDate.name}  ',
                            color:  mediumBlue,
                            size: 15,
                          ),
                          CustomText(
                            text: formattedDate,
                            color:  mediumBlue,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}