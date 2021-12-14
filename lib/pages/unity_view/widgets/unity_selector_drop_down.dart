import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/provider/unity_management_provider.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class UnitySelectorDropDown extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: 'Cliente:',
                  color: strongBlue,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: CustomText(
                    text: context.read<UnityManagementProvider>().selectedUnity.company!.name,
                    color: strongLightPurple,
                    size: 15,
                    // weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(203, 195, 245, 1),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
              child: DropdownButton(
                onTap: () {},
                isExpanded: true,
                isDense: true,
                icon: Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(176, 165, 229, 1),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                onChanged: (value) {},
                value: context.watch<UnityManagementProvider>().selectedUnity.name,
                style: TextStyle(
                  color: strongLightPurple,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                items: context.watch<UnityManagementProvider>().units.map((unity) {
                  return DropdownMenuItem(
                    onTap: () {
                      context.read<UnityManagementProvider>().selectedUnity = unity;
                    },
                    value: unity.name,
                    child: Text(unity.name),
                  );
                }).toList(),
                underline: const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}