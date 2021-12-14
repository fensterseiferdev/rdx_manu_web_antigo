import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/unity_equipment.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class NewUnityEquipmentToPickList extends StatefulWidget {

  final List<UnityEquipment> unityEquipments;
  final Function onTap;
  const NewUnityEquipmentToPickList({required this.unityEquipments, required this.onTap});

  @override
  _NewUnityEquipmentToPickListState createState() => _NewUnityEquipmentToPickListState();
}

class _NewUnityEquipmentToPickListState extends State<NewUnityEquipmentToPickList> {
  UnityEquipment _selectedUnityEquipment = UnityEquipment(); 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              CustomText(
                text: 'Selecione um equipamento',
                size: 18,
                color: mediumBlue,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  color: mediumBlue,
                  size: 30,
                ),
              ), 
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: widget.unityEquipments.map((unityEquipment) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedUnityEquipment = unityEquipment;
                    });
                  },
                  child: Container(
                    color: _selectedUnityEquipment.uid == unityEquipment.uid ? 
                      const Color.fromRGBO(170, 170, 232, 1) :
                      Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: unityEquipment.description,
                          size: 18,
                          color: _selectedUnityEquipment.uid == unityEquipment.uid ? Colors.white : mediumBlue,
                        ),
                        if(_selectedUnityEquipment.uid == unityEquipment.uid)
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 26,
                          )
                        else
                          const SizedBox(),  
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ), 
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 25),
          child: Center(
            child: SizedBox(
              width: 160,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    _selectedUnityEquipment.uid.isEmpty ? 
                      Colors.grey : 
                      const Color.fromRGBO(170, 170, 232, 1)
                  ),
                ),
                onPressed: _selectedUnityEquipment.uid.isEmpty ? null : () {
                  widget.onTap(_selectedUnityEquipment);
                },
                child: const CustomText(
                  text: 'Confirmar',
                  size: 16,
                  color: Colors.white,
                  weight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}