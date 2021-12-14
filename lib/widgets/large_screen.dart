import 'package:flutter/material.dart';
import 'package:rdx_manu_web/routing/router.dart';
import 'package:rdx_manu_web/routing/routes.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';
import 'package:rdx_manu_web/widgets/side_menu.dart';

import '../locator.dart';

class LargeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: SideMenu(),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Navigator(
              key: locator<NavigationService>().navigatorKey,
              onGenerateRoute: generateRoute,
              initialRoute: homePageRoute,
            ),
          ),
        ),
      ],
    );
  }
}
