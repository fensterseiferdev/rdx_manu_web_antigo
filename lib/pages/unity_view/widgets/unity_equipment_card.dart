import 'package:flutter/material.dart';
import 'package:rdx_manu_web/models/unity_equipment.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/provider/unity_management_provider.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class UnityEquipmentCard extends StatefulWidget {

  final UnityEquipment unityEquipment;
  final Function onUpdate;
  final Function onDelete;
  const UnityEquipmentCard({required this.unityEquipment, required this.onUpdate, required this.onDelete});

  @override
  _UnityEquipmentCardState createState() => _UnityEquipmentCardState();
}

class _UnityEquipmentCardState extends State<UnityEquipmentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Material(
        elevation: 5,
        shadowColor: const Color.fromRGBO(73, 56, 120, 0.38),
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: widget.unityEquipment.description,
                      size: 20,
                      color: const Color.fromRGBO(89, 98, 115, 1),
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text: 'Nº de chassi: ${widget.unityEquipment.chassisNumber}',
                      size: 15,
                      color: const Color.fromRGBO(89, 98, 115, 1),
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: 'Nº de frota: ${widget.unityEquipment.fleetNumber}',
                      size: 15,
                      color: const Color.fromRGBO(89, 98, 115, 1),
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: widget.unityEquipment.contractType == 'sell' ? 'Tipo de contrato: Venda' : 'Tipo de contrato: Locação',
                      size: 15,
                      color: const Color.fromRGBO(89, 98, 115, 1),
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  if(!widget.unityEquipment.isActive!)
                    const CustomText(
                      text: 'Inativo',
                      size: 14,
                      color: Color.fromRGBO(89, 98, 115, 1),
                      weight: FontWeight.w600,
                    ),
                  Switch(
                    activeTrackColor: const Color.fromRGBO(121, 121, 204, 1),
                    activeColor: Colors.white,
                    value: widget.unityEquipment.isActive!,
                    onChanged: (state) async {
                      await context.read<CloudFirestoreProvider>().desactiveUnityEquipment(
                        context.read<UnityManagementProvider>().selectedUnity, widget.unityEquipment.uid, state
                      );
                      setState(() {
                        widget.onUpdate(widget.unityEquipment.uid, state);
                      });
                    },
                  ),
                  if(widget.unityEquipment.isActive!)
                  const CustomText(
                    text: 'Ativo',
                    size: 14,
                    color: Color.fromRGBO(89, 98, 115, 1),
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      await context.read<CloudFirestoreProvider>().deleteEquipmentFromUnity(
                        context.read<UnityManagementProvider>().selectedUnity,
                        widget.unityEquipment.uid,
                      );
                      widget.onDelete(widget.unityEquipment.uid);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
