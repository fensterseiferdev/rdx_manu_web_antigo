import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/unity_equipment.dart';
import 'package:rdx_manu_web/pages/unity_view/widgets/unity_equipments_display_large.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/provider/unity_management_provider.dart';

class UnityEquipmentsDisplay extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UnityEquipment>>(
      future: context.read<CloudFirestoreProvider>().loadUnityEquipments(
        context.read<UnityManagementProvider>().selectedUnity.uid,
        context.read<UnityManagementProvider>().selectedUnity.company!.uid,
      ),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return UnityEquipmentsDisplayLarge(snapshot.data!);
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