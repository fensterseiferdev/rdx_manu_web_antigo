import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/add_option_item.dart';
import 'package:rdx_manu_web/services/navigation_service.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

import '../../locator.dart';

class AddOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final List<AddOptionItem> addOptions = [
      AddOptionItem(
        iconAsset: 'assets/icons/cliente.svg',
        title: 'Cliente',
        subTitle: 'Cadastre o seu cliente.',
        routeName: '/register_business',
      ),
      AddOptionItem(
        iconAsset: 'assets/icons/unidade.svg',
        title: 'Unidade',
        subTitle: 'Cadastre unidades do seu cliente.',
        routeName: '/register_unity',
      ),
      AddOptionItem(
        iconAsset: 'assets/icons/mecanico.svg',
        title: 'Mecânico',
        subTitle: 'Cadastre mecânicoszn responsáveis pelos reparos.',
        routeName: '/register_mechanical',
      ),
      AddOptionItem(
        iconAsset: 'assets/icons/requester.svg',
        title: 'Requisitante',
        subTitle: 'Cadastre os requisitantes responsáveis pelos chamados.',
        routeName: '/register_requester',
      ),
      AddOptionItem(
        iconAsset: 'assets/icons/approver.svg',
        title: 'Aprovador',
        subTitle: 'Cadastre aprovadores do orçamento do mecânico.',
        routeName: '/register_approver',
      ),
      AddOptionItem(
        iconAsset: 'assets/icons/fork_lift.svg',
        title: 'Equipamento',
        subTitle: 'Cadastre equipamentos da sua empresa.',
        routeName: '/register_equipments',
      ),
      AddOptionItem(
        iconAsset: 'assets/icons/peca.svg',
        title: 'Peça',
        subTitle: 'Cadastre peças de substituição de equipamentos.',
        routeName: '/register_parts',
      ),
      AddOptionItem(
        iconAsset: 'assets/icons/os.svg',
        title: 'Criar outro usuário',
        subTitle: 'Crie um novo usuário pós-venda ou aprovador.',
        routeName: '/register_user',
      ),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: CustomText(
            text: 'O QUE VOCÊ DESEJA CADASTRAR?',
            color: lightPurple,
            size: 56,
            weight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: addOptions.sublist(0, 4).map((addOption) {
            return Padding(
              padding: EdgeInsets.only(right: addOptions.sublist(0, 4).last.title == addOption.title ? 0 : 22),
              child: SizedBox(
                width: 215,
                height: 200,
                child: Material(
                  borderRadius: BorderRadius.circular(14),
                  elevation: 5,
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      locator<NavigationService>().navigateTo(routeName: addOption.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            addOption.iconAsset,
                            width: 70,
                            height: 70,
                            color: strongPurple,
                          ),
                          CustomText(
                            text: addOption.title,
                            size: 16,
                          ),
                          CustomText(
                            text: addOption.subTitle,
                            size: 13,
                            color: lightGrey,
                            maxLines: 3,
                            align: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList()
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: addOptions.sublist(4, 8).map((addOption) {
            return Padding(
              padding: EdgeInsets.only(right: addOptions.sublist(4, 8).last.title == addOption.title ? 0 : 22),
              child: SizedBox(
                width: 215,
                height: 200,
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  elevation: 5,
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      locator<NavigationService>().navigateTo(routeName: addOption.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            addOption.iconAsset,
                            width: 70,
                            height: 70,
                            color: strongPurple,
                          ),
                          CustomText(
                            text: addOption.title,
                            size: 16,
                          ),
                          CustomText(
                            text: addOption.subTitle,
                            size: 13,
                            color: lightGrey,
                            maxLines: 3,
                            align: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList()
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
