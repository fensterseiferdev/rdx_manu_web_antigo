import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String clientRefPath;
  bool changedPassword;
  final bool isActive;

  UserModel({required this.uid, this.name = '', this.clientRefPath = '', required this.changedPassword, required this.isActive,});

  factory UserModel.fromDocument(QueryDocumentSnapshot userDoc) {
    return UserModel(
      uid: userDoc.id,
      clientRefPath: userDoc.reference.path.split('/')[1],
      changedPassword: userDoc['changed_password'] as bool,
      isActive: userDoc['active'] as bool,
    );
  }

}
