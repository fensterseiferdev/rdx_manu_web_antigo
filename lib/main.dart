import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/constants/instances.dart';
import 'package:rdx_manu_web/pages/authentication/authentication.dart';
import 'package:rdx_manu_web/provider/add_provider.dart';
import 'package:rdx_manu_web/provider/auth_provider.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/provider/filter_provider.dart';
import 'package:rdx_manu_web/provider/unity_management_provider.dart';
import 'package:rdx_manu_web/routing/router.dart';
import 'package:rdx_manu_web/routing/routes.dart';

import 'constants/style.dart';
import 'layout.dart';
import 'locator.dart';
import 'models/user_model.dart';

void main() {
  // setPathUrlStrategy();
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider.initialize()),
        ChangeNotifierProvider(create: (_) => CloudFirestoreProvider()),
        Provider(create: (_) => AddProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => UnityManagementProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: generateRoute,
      initialRoute: pageControllerRoute,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      title: 'RDX - Manu',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        fontFamily: GoogleFonts.poppins().fontFamily,
        // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        //     .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        primarySwatch: Colors.blue,
      ),
      // home: AuthenticationPage(),
    );
  }
}

class AppPagesController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const  [Text("Something went wrong")],
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (auth.currentUser != null) {
            return FutureBuilder<UserModel>(
              future: context.read<AuthProvider>().loadCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.data!.isActive) {
                    auth.signOut();
                    return AuthenticationPage();
                  } else {
                    context.read<AuthProvider>().userModel = snapshot.data!;
                    return SiteLayout();
                  }
                } else {
                  return const SizedBox();
                }
              },
            );
          } else {
            return AuthenticationPage();
          }
        } else {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator()],
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}
