import 'package:flutter/material.dart';
import 'package:rdx_manu_web/pages/lists/widgets/lists_large.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';

class ListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<CloudFirestoreProvider>().hasNextListPage = false;
    context.read<CloudFirestoreProvider>().limitFor = 10;

    final listTypes = ['Clientes', 'Peças', 'Equipamentos', 'Mecânicos'];

    return SingleChildScrollView(child: ListsLarge(listTypes));
  }
}
