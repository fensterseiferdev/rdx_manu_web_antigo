import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/helpers/formatters.dart';
import 'package:rdx_manu_web/models/manual_inclusion.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class ManualInclusionsListTable extends StatelessWidget {

  final List<ManualInclusion>? manualInclusions;
  const ManualInclusionsListTable(this.manualInclusions);

  @override
  Widget build(BuildContext context) {
    if(manualInclusions == null) {
      return const SizedBox();
    } else {

      final List<String> manualInclusionsColumns = ['Descrição do custo adicional', 'Quantidade', 'Preço', 'Total por x quantidade'];

      CustomText columnText(String text) => CustomText(
        text: text,
        color: mediumBlue,
        size: 15,
        style: FontStyle.italic,
      );

      CustomText dataRowText(String text) => CustomText(
        text: text,
        color: const Color.fromRGBO(35, 48, 71, 1),
        size: 15,
        weight: FontWeight.w600,
      );

      String totalBudget() {
        double totalPartsBudget = 0;
        for (final manualInclusion in manualInclusions!) {
          totalPartsBudget += manualInclusion.price * manualInclusion.quantity;
        }
        return 'TOTAL: ${brasilCurrencyFormat(totalPartsBudget)}';
      }

      return Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CustomText(
                text: 'Lista de custos adicionais:',
                color: mediumBlue,
                size: 15,
                weight: FontWeight.w500,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 25),
                      Material(
                        color: const Color.fromRGBO(251, 251, 251, 1),
                        borderRadius: BorderRadius.circular(8),
                        elevation: 3,
                        shadowColor: const Color.fromRGBO(73, 56, 120, 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          child: SizedBox(
                            width: 750,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    headingRowHeight: 30,
                                    columns: manualInclusionsColumns.map((pc) {
                                      return DataColumn(
                                        label: columnText(pc),
                                      );
                                    }).toList(),
                                    rows: manualInclusions!.map((manualInclusion) {
                                      return DataRow(
                                        color: MaterialStateProperty.all(
                                          const Color.fromRGBO(251, 251, 251, 1),
                                        ),
                                        cells: [
                                          DataCell(dataRowText(manualInclusion.description)),
                                          DataCell(dataRowText(manualInclusion.quantity.toString())),
                                          DataCell(dataRowText(brasilCurrencyFormat(manualInclusion.price))),
                                          DataCell(dataRowText(brasilCurrencyFormat(manualInclusion.price * manualInclusion.quantity))),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    totalBudget(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: const Color.fromRGBO(35, 48, 71, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
