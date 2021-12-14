import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/unity_user.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class UnityUsersDisplayCardLarge extends StatefulWidget {
  final String userType;
  final List<UnityUser> unitsUsers;
  const UnityUsersDisplayCardLarge({required this.userType, required this.unitsUsers});

  @override
  _UnityUsersDisplayCardLargeState createState() =>
      _UnityUsersDisplayCardLargeState();
}

class _UnityUsersDisplayCardLargeState
    extends State<UnityUsersDisplayCardLarge> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 40,
      child: Material(
        color: Colors.white,
        elevation: 3,
        borderRadius: BorderRadius.circular(12),
        child: Column(
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
                text: widget.userType == 'requester'
                    ? 'REQUISITANTES'
                    : 'APROVADORES',
                size: 15,
                color: strongLightPurple,
              ),
            ),
            Column(
              children: widget.unitsUsers.map((unityUser) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 25),
                  child: Material(
                    elevation: 5,
                    color: Colors.white,
                    shadowColor: const Color.fromRGBO(73, 56, 120, 0.38),
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: unityUser.name,
                            color: strongBlue,
                            size: 17,
                          ),
                          Row(
                            children: [
                              CustomText(
                                text: 'Inativo',
                                size: 14,
                                color: !unityUser.isActive
                                      ? const Color.fromRGBO(89, 98, 115, 1)
                                      : Colors.transparent,
                                weight: FontWeight.w600,
                              ),
                              Switch(
                                activeTrackColor:
                                    const Color.fromRGBO(121, 121, 204, 1),
                                activeColor: Colors.white,
                                value: unityUser.isActive,
                                onChanged: (state) async {
                                  await context.read<CloudFirestoreProvider>().desactiveUnityUser(unityUser.uid, state);
                                  setState(() {
                                    widget.unitsUsers[widget.unitsUsers.indexWhere((user) => user.uid == unityUser.uid)].isActive = state;
                                  });
                                },
                              ),
                              CustomText(
                                text: 'Ativo',
                                size: 14,
                                color: unityUser.isActive
                                  ? const Color.fromRGBO(89, 98, 115, 1)
                                  : Colors.transparent,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
