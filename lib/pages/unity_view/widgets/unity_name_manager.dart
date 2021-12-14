import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/provider/unity_management_provider.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class UnityNameManager extends StatefulWidget {

  final String unityName;
  const UnityNameManager(this.unityName);

  @override
  _UnityNameManagerState createState() => _UnityNameManagerState();
}

class _UnityNameManagerState extends State<UnityNameManager> {
  bool isEditing = false;

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: 'Nome da unidade:  ',
          color: lightPurple.withOpacity(.8),
          size: 22,
        ),
        if(!isEditing)
          SizedBox(
            width: 180,
            child: CustomText(
              text: context.watch<UnityManagementProvider>().selectedUnity.name,
              color: strongBlue,
              size: 22,
              weight: FontWeight.bold,
            ),
          )
        else  
          SizedBox(
            width: 180,
            child: TextFormField(
              readOnly: !isEditing,
              cursorColor: lightPurple,
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {});
              },
              controller: nameController,
              style: TextStyle(
                color: strongBlue,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        const SizedBox(width: 5),
        if(!isEditing)
          InkWell(
            onTap: () {
              setState(() {
                isEditing = true;
                nameController.text = context.read<UnityManagementProvider>().selectedUnity.name;
              });
            },
            child: const Icon(
              Icons.edit,
              color: Colors.yellow,
              size: 25,
            ),
          )
        else
          InkWell(
            onTap: nameController.text == widget.unityName ? null : () async {
              setState(() {
                isEditing = false;
              });
              await context.read<UnityManagementProvider>().changeUnityName(
                nameController.text,
                context.read<CloudFirestoreProvider>().userModel.clientRefPath,
              );
            },
            child: Icon(
              Icons.check_circle,
              color: nameController.text == widget.unityName ? Colors.grey : Colors.green,
              size: 25,
            ),
          ),
      ],
    );
  }
}
