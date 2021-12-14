import 'package:flutter/material.dart';
import 'package:rdx_manu_web/provider/add_provider.dart';
import 'package:rdx_manu_web/provider/auth_provider.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/widgets/large_screen.dart';
import 'package:provider/provider.dart';
import 'helpers/local_navigator.dart';
import 'helpers/reponsiveness.dart';


class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    context.read<CloudFirestoreProvider>().userModel = 
      context.read<AuthProvider>().userModel;
    context.read<AddProvider>().userModel = 
      context.read<AuthProvider>().userModel;  
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      // appBar:  topNavigationBar(context, scaffoldKey),
      // drawer: Drawer(
      //   child: SideMenu(),
      // ),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
      smallScreen: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: localNavigator(),
      )
      ),
    );
  }
}
