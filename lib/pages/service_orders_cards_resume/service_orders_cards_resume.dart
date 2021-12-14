import 'package:flutter/material.dart';
import 'package:rdx_manu_web/pages/service_orders_cards_resume/widgets/need_support_card.dart';
import 'package:rdx_manu_web/pages/service_orders_cards_resume/widgets/service_orders_cards.dart';
import 'package:rdx_manu_web/pages/service_orders_cards_resume/widgets/service_orders_filters.dart';

class ServiceOrdersCardsResumePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            ServiceOrderFilters(),
            const SizedBox(height: 25),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ServiceOrdersCards(),
                NeedSupportCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
