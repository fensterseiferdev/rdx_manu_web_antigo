import 'package:flutter/material.dart';
import 'package:rdx_manu_web/pages/service_orders_cards_resume/widgets/large_service_orders_filters.dart';

class ServiceOrderFilters extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // if(ResponsiveWidget.isLargeScreen(context)) {
      return LargeServiceOrdersFilters();
    // } else {
    //   return SizedBox();
    // }
  }
}