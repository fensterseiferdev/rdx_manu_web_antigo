import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/locator.dart';
import 'package:rdx_manu_web/pages/unity_view/widgets/unity_equipments_display.dart';
import 'package:rdx_manu_web/pages/unity_view/widgets/unity_name_manager.dart';
import 'package:rdx_manu_web/pages/unity_view/widgets/unity_selector_drop_down.dart';
import 'package:rdx_manu_web/pages/unity_view/widgets/unity_users_display_cards.dart';
import 'package:rdx_manu_web/provider/unity_management_provider.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class UnityViewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 60),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'DETALHES DA UNIDADE',
                  color: lightPurple,
                  size: 52,
                ),
                UnitySelectorDropDown(),
              ],
            ),
            UnityNameManager(context.watch<UnityManagementProvider>().selectedUnity.name),
            const SizedBox(height: 20),
            UnityUsersDisplayCards(),
            const SizedBox(height: 30),
            UnityEquipmentsDisplay(),
            const SizedBox(height: 35),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: Color.fromRGBO(139, 147, 162, 1),
                    ),
                  ),
                ),
                onPressed: () {
                  locator<NavigationService>().goBack();
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: CustomText(
                    text: 'Voltar para a tela de clientes',
                    size: 16,
                    color: Color.fromRGBO(111, 118, 133, 1),
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}