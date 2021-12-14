import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/unity_equipment.dart';
import 'package:rdx_manu_web/pages/unity_view/widgets/select_and_create_new_unity_equipments.dart';
import 'package:rdx_manu_web/pages/unity_view/widgets/unity_equipment_card.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class UnityEquipmentsDisplayLarge extends StatefulWidget {

  final List<UnityEquipment> unityEquipments;
  const UnityEquipmentsDisplayLarge(this.unityEquipments);

  @override
  _UnityEquipmentsDisplayLargeState createState() => _UnityEquipmentsDisplayLargeState();
}

class _UnityEquipmentsDisplayLargeState extends State<UnityEquipmentsDisplayLarge> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 25),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(232, 232, 251, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    text: 'EQUIPAMENTOS',
                    size: 15,
                    color: strongLightPurple,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () async {
                    final newUnityEquipments = await showDialog(
                      barrierDismissible: false,
                      context: context, 
                      builder: (context) => SelectAndCreateNewUnityEquipments(),
                    );
                    if(newUnityEquipments is List<UnityEquipment> && newUnityEquipments.isNotEmpty) {
                      setState(() {
                        widget.unityEquipments.addAll(newUnityEquipments);
                      });
                    }   
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12, 
                          offset: Offset(0, 2), 
                          spreadRadius: 2, 
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Color.fromRGBO(149, 137, 197, 1),
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: widget.unityEquipments.map((unityEquipment) {
                return UnityEquipmentCard(
                  unityEquipment: unityEquipment,
                  onUpdate: (String equipmentUid, bool newState) {
                    widget.unityEquipments[widget.unityEquipments.indexWhere(
                      (e) => e.uid == equipmentUid)].isActive = newState;
                  },
                  onDelete: (String equipmentUid) {
                    widget.unityEquipments.removeWhere((e) => e.uid == equipmentUid);
                    setState(() {});
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}