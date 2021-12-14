import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/unity.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class SelectUnityDropdown extends StatefulWidget {
  final Unity? initialUnity;
  final List<Unity> units;
  final Function onTap;
  const SelectUnityDropdown(this.initialUnity, this.units, this.onTap);

  @override
  _SelectUnityDropdownState createState() => _SelectUnityDropdownState();
}

class _SelectUnityDropdownState extends State<SelectUnityDropdown> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: widget.initialUnity == null ? const Text('Selecionar unidade') : Text(widget.initialUnity!.name),
      style: TextStyle(
        color: mediumBlue,
        fontWeight: FontWeight.bold,
      ),
      isExpanded: true,
      isDense: true,
      underline: const SizedBox(),
      onChanged: (value) {},
      items: widget.units.map((unity) {
        return DropdownMenuItem(
          onTap: () {
            widget.onTap(unity);
          },
          value: unity.name,
          child: CustomText(
            text: unity.name,
          ),
        );
      }).toList(),
    );
  }
}
