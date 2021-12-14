import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/instances.dart';
import 'package:rdx_manu_web/models/user_model.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/widgets/change_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  late User _user;
  late final Status _status = Status.Uninitialized;
  late UserModel _userModel;

  //getter
  Status get status => _status;
  User get user => _user;
  UserModel get userModel => _userModel;
  set userModel(UserModel model) {
    _userModel = model;
    notifyListeners();
  }

  AuthProvider.initialize() {
    // _fireSetUp();
  }

  // _fireSetUp() async {
  //     if(auth.currentUser != null) {
  //       await _onStateChanged(auth.currentUser);
  //     } else {
  //       _status = Status.Unauthenticated;
  //       _userModel = UserModel(uid: '',);
  //       notifyListeners();
  //     }
    // await initialization.then((value) {
    //   auth.authStateChanges().listen((user) async {
    //     await _onStateChanged(user);
    //   });
    // });
  // }

  Future<UserModel > loadCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = auth.currentUser;
    await prefs.setString('id', user!.uid);
    return _userModel = await getUserById(user.uid);
    // notifyListeners();
    
  }


  Future<void> signIn({required String email, required String password, required Function onFail, required Function onSucess, required BuildContext context}) async {
    try{
      final authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      final userData = await getUserById(authResult.user!.uid);
      // _status = Status.Authenticated;
      if(userData.isActive) {
        if(!userData.changedPassword) {
          final bool? changed = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => const ChangePassword(),
          );
          if(changed != null && changed is bool && changed == true) {
            await context.read<CloudFirestoreProvider>().changedPass(userData.clientRefPath);
            userData.changedPassword = true;
            _userModel = userData;
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('id', authResult.user!.uid);
            notifyListeners(); 
            onSucess();
          } else {
            auth.signOut();
          }
        } else {
          _userModel = userData;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('id', authResult.user!.uid);
          notifyListeners(); 
          onSucess();
        }
      } else {
        auth.signOut();
        onFail('Conta desativada!');
      }
    } catch(e) {
      auth.signOut();
      onFail(e.toString());
    }
  }

  Future<UserModel> getUserById(String uid) async {
    final userRef = await firestore.collectionGroup('private_users').where('user_uid', isEqualTo: uid).get();
    return UserModel.fromDocument(userRef.docs.first);
  }

}
