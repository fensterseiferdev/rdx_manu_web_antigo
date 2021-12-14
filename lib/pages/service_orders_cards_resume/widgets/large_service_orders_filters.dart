import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/models/os_filter_data.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/provider/filter_provider.dart';
import 'filter_card.dart';

class LargeServiceOrdersFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OsFilterData>>(
      future: context.read<CloudFirestoreProvider>().loadOSFiltersData(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {

          return Row(
            children: snapshot.data!.map((filter) {
              return FilterCard(
                name: filter.name,
                quantity: filter.quantity,
                onTap: () {
                  context.read<FilterProvider>().search = '';
                  context.read<FilterProvider>().searchController.clear();
                  context.read<FilterProvider>().selectedFilter = filter.name;
                  context.read<FilterProvider>().filterStage = snapshot.data!.indexOf(filter);
                },
              ); 
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                lightPurple,
              ),
            ),
          );
        }
      }
    );
  }
}
