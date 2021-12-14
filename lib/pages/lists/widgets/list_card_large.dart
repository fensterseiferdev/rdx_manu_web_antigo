import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/helpers/formatters.dart';
import 'package:rdx_manu_web/models/company.dart';
import 'package:rdx_manu_web/models/list_item.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'company_units_list.dart';

class ListCardLarge extends StatefulWidget {

  final List<ListItem> listItemsList;
  const ListCardLarge(this.listItemsList);

  @override
  _ListCardLargeState createState() => _ListCardLargeState();
}

class _ListCardLargeState extends State<ListCardLarge> {

  String currentUid = '';

  final MoneyMaskedTextController costPerHour = MoneyMaskedTextController();

  @override
  Widget build(BuildContext context) {
    
    final border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
      ),
    );
    
    if (widget.listItemsList.isNotEmpty) {
      return Wrap(
        children: widget.listItemsList.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SizedBox(
              height: 90,
              child: Material(
                elevation: 5,
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: item.type != 'company'
                      ? null
                      : () {
                          if (item.type == 'company') {
                            showDialog(
                              context: context,
                              builder: (context) => CompanyUnitsList(
                                Company(
                                  uid: item.uid,
                                  name: item.name,
                                  cnpj: '',
                                  socialReason: '',
                                ),
                              ),
                            );
                          }
                        },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        CustomText(
                          text: item.type == 'mechanical'
                              ? '${item.name}   -  '
                              : item.name,
                          size: 23,
                          color: mediumBlue,
                          weight: FontWeight.w600,
                        ),
                        if (item.type == 'mechanical')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomText(
                                text: 'Custo por hora:',
                                size: 12,
                                color: Color.fromRGBO(195, 200, 210, 1),
                                weight: FontWeight.w600,
                              ),
                              Row(
                                children: [
                                  if(currentUid == item.uid)
                                    SizedBox(
                                      width: 120,
                                      height: 35,
                                      child: TextFormField(
                                        onChanged: (value) {
                                          if(value.isEmpty) {
                                            setState(() => costPerHour.updateValue(0));
                                          }
                                        },
                                        cursorColor: lightPurple,
                                        controller: costPerHour,
                                        decoration: InputDecoration(
                                          disabledBorder: border,
                                          enabledBorder: border,
                                          errorBorder: border,
                                          focusedBorder: border,
                                          focusedErrorBorder: border,
                                        ),
                                        style: TextStyle(
                                          fontSize: 23,
                                          color: strongBlue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  else  
                                    CustomText(
                                      text: brasilCurrencyFormat(item.costPerHour!),
                                      size: 23,
                                      color: strongBlue,
                                      weight: FontWeight.w600,
                                    ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () async {
                                      if(currentUid == item.uid) {
                                        await context.read<CloudFirestoreProvider>().updateMechanicalCostPerHour(
                                          item.uid, costPerHour.numberValue,
                                        );
                                        setState(() {
                                          widget.listItemsList.firstWhere((i) => i.uid == item.uid).costPerHour = costPerHour.numberValue;
                                          currentUid = '';
                                        });
                                      } else {
                                        setState(() {
                                          costPerHour.updateValue(item.costPerHour!);
                                          currentUid = item.uid;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      currentUid == item.uid ? Icons.check_circle : Icons.edit,
                                      color: currentUid == item.uid ? Colors.green : Colors.yellow,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        const Expanded(child: SizedBox()),
                        if (item.type == 'company')
                          Container(
                            width: 195,
                            height: 42,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(192, 192, 239, 1),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    text: 'Ver unidades',
                                    size: 18,
                                    color: Color.fromRGBO(169, 169, 232, 1),
                                  ),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color: const Color.fromRGBO(169, 169, 232, 1),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 15,
                                      color: Color.fromRGBO( 169, 169, 232, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (item.type == 'mechanical')
                          Row(
                            children: [
                              if(!item.isActive!)
                                CustomText(
                                  text: 'Inativo',
                                  size: 14,
                                  color: !item.isActive!
                                      ? const Color.fromRGBO(89, 98, 115, 1)
                                      : Colors.transparent,
                                  weight: FontWeight.w600,
                                ),
                              Switch(
                                activeTrackColor: const Color.fromRGBO(121, 121, 204, 1),
                                activeColor: Colors.white,
                                value: item.isActive!,
                                onChanged: (state) async {
                                  await context.read<CloudFirestoreProvider>().updateMechanicalState(item.uid, state);
                                  setState(() {
                                    widget.listItemsList.firstWhere((i) => i.uid == item.uid).isActive = state;
                                  });
                                },
                              ),
                              if(item.isActive!)
                                CustomText(
                                  text: 'Ativo',
                                  size: 14,
                                  color: item.isActive!
                                      ? const Color.fromRGBO(89, 98, 115, 1)
                                      : Colors.transparent,
                                  weight: FontWeight.w600,
                                ),
                              const SizedBox(width: 20),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: Center(
          child: CustomText(
            text: 'Ainda não existe nenhum item nesta lista',
          ),
        ),
      );
    }
  }
}
