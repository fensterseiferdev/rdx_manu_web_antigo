import 'package:flutter/material.dart';
import 'package:rdx_manu_web/helpers/reponsiveness.dart';
import 'package:rdx_manu_web/widgets/vertical_menu_item.dart';

import 'horizontal_menu_item.dart';


class SideMenuItem extends StatelessWidget {
  final String itemName;
  final String itemAsset;
  final Function onTap;

  const SideMenuItem({required this.itemName, required this.itemAsset, required this.onTap });

  @override
  Widget build(BuildContext context) {
    if(ResponsiveWidget.isCustomSize(context)){
      return VertticalMenuItem(itemName: itemName, itemAsset: itemAsset, onTap: onTap);
    }else{
      return HorizontalMenuItem(itemName: itemName, itemAsset: itemAsset, onTap: onTap);
    }
  }
}