import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class FilterCard extends StatelessWidget {
  final String name;
  final int quantity;
  final Function onTap;

  const FilterCard(
      {required this.name, required this.quantity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          right: name != 'O.S. finalizadas' ? _width / 88 : 0,
        ),
        child: Material(
          elevation: 5,
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => onTap(),
            child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CustomText(
                      text: name,
                      size: 14,
                      color: lightPurple,
                      weight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          Row(
                            children: [
                              const CustomText(
                                text: 'Ordens de\nServiços:',
                                maxLines: 2,
                                align: TextAlign.right,
                                size: 10,
                                weight: FontWeight.bold,
                                color: Color.fromRGBO(89, 98, 115, 1),
                              ),
                              const SizedBox(width: 10),
                              CustomText(
                                text: quantity.toString(),
                                size: 34,
                                maxLines: 1,
                                color: const Color.fromRGBO(89, 98, 115, 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 3),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CustomText(
                  //         text: 'Orders de serviço:',
                  //         size: 13,
                  //         color:  mediumBlue,
                  //       ),
                  //       CustomText(
                  //         text: quantity.toString(),
                  //         size: 15,
                  //         maxLines: 1,
                  //         color:  mediumBlue,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
