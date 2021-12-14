import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/constants/instances.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/provider/filter_provider.dart';
import 'package:rdx_manu_web/routing/routes.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';
import 'package:rdx_manu_web/widgets/side_menu_item.dart';

import '../locator.dart';
import 'custom_text.dart';


class SideMenu extends StatefulWidget {

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with SingleTickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {
    rotationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: 5,
      color: Colors.white,
      child: Column(
        children: [
          // if (ResponsiveWidget.isSmallScreen(context))
          //   Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       SizedBox(
          //         height: 40,
          //       ),
          //       Row(
          //         children: [
          //           SizedBox(width: _width / 48),
          //           Padding(
          //             padding: const EdgeInsets.only(right: 12),
          //             child: Image.asset("assets/icons/logo.png"),
          //           ),
          //           Flexible(
          //             child: CustomText(
          //               text: "Dash",
          //               size: 20,
          //                
          //               color: Colors.black,
          //             ),
          //           ),
          //           SizedBox(width: _width / 48),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 30,
          //       ),
          //     ],
          //   ),
          // Divider(
          //   color: lightGrey.withOpacity(.1),
          // ),
          const SizedBox(height: 30),
          SvgPicture.asset(
            'assets/icons/logo.svg',
            width: 35,
            height: 35,
          ),
          const SizedBox(height: 40),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItemRoutes.map((item) {
              return SideMenuItem(
                itemName: item.name,
                itemAsset: item.assetPath,
                onTap: () {
                  locator<NavigationService>().navigateTo(routeName: item.route);
                },
              );
            }).toList(),
          ),
          Expanded(child: Container()),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () async {
              context.read<FilterProvider>().clear();
              rotationController.forward(from: 0.0);
            },
            child: CircleAvatar(
              backgroundColor: light,
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
                child: Icon(
                  Icons.refresh,
                  size: 30,
                  color: strongPurple,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () async {
              await auth.signOut();
              locator<NavigationService>().globalNavigateTo(authenticationPageRoute, context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: light,
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: const CustomText(
                text: 'Sair',
                size: 14,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
