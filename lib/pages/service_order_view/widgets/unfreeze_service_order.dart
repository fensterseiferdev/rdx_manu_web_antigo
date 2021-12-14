import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';

class UnfreezeServiceOrder extends StatefulWidget {
  final ServiceOrder serviceOrder;
  const UnfreezeServiceOrder(this.serviceOrder);

  @override
  _UnfreezeServiceOrderState createState() => _UnfreezeServiceOrderState();
}

class _UnfreezeServiceOrderState extends State<UnfreezeServiceOrder> {
  final PageController pageController = PageController();

  final MoneyMaskedTextController descountController =
      MoneyMaskedTextController();

  @override
  Widget build(BuildContext context) {

    final cloudFirestoreProvider = context.read<CloudFirestoreProvider>();

    return Dialog(
      child: SizedBox(
        width: 380,
        height: 200,
        child: PageView(
          controller: pageController,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Deseja habilitar desconto?',
                  style: GoogleFonts.poppins(
                    color: const Color.fromRGBO(35, 48, 71, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 90,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                                color: Color.fromRGBO(35, 48, 71, 1)),
                          ),
                        ),
                        onPressed: () async {
                          await cloudFirestoreProvider.unfreezeServiceOrder(
                            widget.serviceOrder.uid,
                          );
                          Navigator.of(context).pop({'stage': 2});
                        },
                        child: Text(
                          'Não',
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(35, 48, 71, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    SizedBox(
                      width: 90,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                                color: Color.fromRGBO(35, 48, 71, 1)),
                          ),
                        ),
                        onPressed: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          'Sim',
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(35, 48, 71, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Digite o valor do desconto',
                  style: GoogleFonts.poppins(
                    color: const Color.fromRGBO(35, 48, 71, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SizedBox(
                    width: 160,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: descountController,
                      cursorColor: const Color.fromRGBO(35, 48, 71, 1),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(35, 48, 71, 1),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(35, 48, 71, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 140,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                                color: Color.fromRGBO(35, 48, 71, 1)),
                          ),
                        ),
                        onPressed: () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          'Cancelar',
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(35, 48, 71, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    SizedBox(
                      width: 140,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                                color: Color.fromRGBO(35, 48, 71, 1)),
                          ),
                        ),
                        onPressed: () async {
                          await cloudFirestoreProvider.unfreezeWithDescount(
                            widget.serviceOrder.uid, descountController.numberValue,
                          );
                          Navigator.of(context).pop({
                            'stage': 2,
                            'descount': descountController.numberValue,
                          });
                        },
                        child: Text(
                          'Confirmar',
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(35, 48, 71, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

