import 'package:flutter/material.dart';
import 'package:rdx_manu_web/models/unity_user.dart';
import 'package:rdx_manu_web/pages/unity_view/widgets/unity_users_display_card_large.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/provider/unity_management_provider.dart';

class UnityUsersDisplayCards extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UnityUser>>(
      future: context.read<CloudFirestoreProvider>().loadUnityUsers(
        context.read<UnityManagementProvider>().selectedUnity.uid
      ),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UnityUsersDisplayCardLarge(
                userType: 'requester',
                unitsUsers: snapshot.data!.where((user) => user.userType == 'requester').toList(),
              ),
              Expanded(flex: 10, child: Container()),
              UnityUsersDisplayCardLarge(
                userType: 'approver',
                unitsUsers: snapshot.data!.where((user) => user.userType == 'approver').toList(),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      }
    );
  }
}