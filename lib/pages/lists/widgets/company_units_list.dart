import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/company.dart';
import 'package:rdx_manu_web/models/unity.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/provider/unity_management_provider.dart';
import 'package:rdx_manu_web/routing/routes.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

class CompanyUnitsList extends StatelessWidget {

  final Company company;
  const CompanyUnitsList(this.company);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 800,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: FutureBuilder<List<Unity>>(
          future: context.read<CloudFirestoreProvider>().loadCompanyUnits(company),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {

              return Column(
                children: [
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(child: SizedBox()),
                        const Center(
                          child: CustomText(
                            text: 'Selecione uma unidade',
                            size: 20,
                            weight: FontWeight.w600,
                            color: Color.fromRGBO(89, 98, 115, 1),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.close,
                                  size: 28,
                                  color: Color.fromRGBO(89, 98, 115, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  SingleChildScrollView(
                    child: Column(
                      children: snapshot.data!.map((unity) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                          height: 55,
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            elevation: 3,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                context.read<UnityManagementProvider>().selectedUnity = unity;
                                context.read<UnityManagementProvider>().units = snapshot.data!;
                                Navigator.of(context).pop();
                                locator<NavigationService>().navigateTo(routeName: unityViewPageRoute);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      unity.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        color: const Color.fromRGBO(89, 98, 115, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    // width: 230,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromRGBO(192, 192, 239, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Ver detalhes da unidade',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: const Color.fromRGBO(169, 169, 232, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  

                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    lightPurple,
                  )
                ),
              );  
            }
          }
        ),
      ),
    );
  }
}