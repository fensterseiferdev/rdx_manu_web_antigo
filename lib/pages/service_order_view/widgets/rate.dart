import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rdx_manu_web/models/service_order.dart';

class Rate extends StatelessWidget {

  final ServiceOrder serviceOrder;
  const Rate(this.serviceOrder);

  @override
  Widget build(BuildContext context) {

    Widget starIconRate(int i) {
      return Icon(
        Icons.star,
        color: serviceOrder.rate >= i ? Colors.yellow : Colors.black,
        size: 40,
      );
    }

    return Material(
      elevation: 3,
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 247, 251, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'AVALIAÇÃO',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(35, 48, 71, 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 2, 3, 4, 5].map((i) {
              return starIconRate(i);
            }).toList(),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
