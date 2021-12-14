import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/unity_equipment.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';

import 'new_equipments_form.dart';
import 'new_unity_equipment_to_pick_list.dart';

class SelectAndCreateNewUnityEquipments extends StatefulWidget {

  @override
  _SelectAndCreateNewUnityEquipmentsState createState() => _SelectAndCreateNewUnityEquipmentsState();
}

class _SelectAndCreateNewUnityEquipmentsState extends State<SelectAndCreateNewUnityEquipments> {

  UnityEquipment pickedUnityEquipment = UnityEquipment();

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 610,
        height: 570,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: pickedUnityEquipment.uid.isEmpty ? FutureBuilder<List<UnityEquipment>>(
            future: context.read<CloudFirestoreProvider>().loadStoreEquipments(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return NewUnityEquipmentToPickList(
                  unityEquipments: snapshot.data!,
                  onTap: (UnityEquipment unityEquipment) {
                    setState(() {
                      pickedUnityEquipment = unityEquipment;
                    });
                  },
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
            },
          ) : NewEquipmentsForm(pickedUnityEquipment),
      ),
    );
  }
}