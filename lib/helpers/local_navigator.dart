import 'package:flutter/cupertino.dart';
import 'package:rdx_manu_web/constants/controllers.dart';
import 'package:rdx_manu_web/constants/instances.dart';
import 'package:rdx_manu_web/routing/router.dart';
import 'package:rdx_manu_web/routing/routes.dart';

Navigator localNavigator() => Navigator(
  key: navigationController.navigatorKey,
  onGenerateRoute: generateRoute,
  initialRoute: auth.currentUser != null ? homePageRoute : authenticationPageRoute,
);



