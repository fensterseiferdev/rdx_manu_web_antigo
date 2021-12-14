import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:rdx_manu_web/constants/style.dart';


class VertticalMenuItem extends StatelessWidget {
  final String itemName;
  final String itemAsset;
  final Function onTap;
  const VertticalMenuItem({required this.itemName, required this.itemAsset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: SizedBox(
        child: Row(
          children: [
            // Visibility(
            //   visible: menuController.isHovering(itemName) ||
            //       menuController.isActive(itemName),
            //   maintainSize: true,
            //   maintainAnimation: true,
            //   maintainState: true,
            //   child: Container(
            //     width: 3,
            //     height: 72,
            //     color: Colors.white,
            //   ),
            // ),
            Expanded(
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SvgPicture.asset(
                        itemAsset,
                        color: strongPurple,
                        height: 22,
                      ),
                    ),
                    // if (!menuController.isActive(itemName))
                    //   Flexible(
                    //     child: CustomText(
                    //       text: itemName,
                    //       color: menuController.isHovering(itemName)
                    //           ? Colors.white
                    //           : lightGrey,
                    //     ),
                    //   )
                    // else
                    //   Flexible(
                    //     child: CustomText(
                    //       text: itemName,
                    //       color: Colors.white,
                    //       size: 18,
                            
                    //     ),
                    //   )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
