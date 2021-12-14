import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/unity_equipment.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/provider/unity_management_provider.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class NewEquipmentsForm extends StatefulWidget {

  final UnityEquipment pickedUnityEquipment;
  const NewEquipmentsForm(this.pickedUnityEquipment);

  @override
  _NewEquipmentsFormState createState() => _NewEquipmentsFormState();
}

class _NewEquipmentsFormState extends State<NewEquipmentsForm> {
  final List<UnityEquipment> newUnityEquipments = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController chassisController = TextEditingController();

  final TextEditingController fleetNumberController = TextEditingController();

  final MoneyMaskedTextController visitCostController = MoneyMaskedTextController();

  final MoneyMaskedTextController travelCostController = MoneyMaskedTextController();

  String _selectedContractType = '';

  DateTime? _pickedDateTime;

  String _chassisOrFleetNumberInvalidError = '';

  bool _checkingChassisAndFleetNumber = false;

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {

    bool isFormCompleted() {
      if(chassisController.text.isNotEmpty 
        && fleetNumberController.text.isNotEmpty 
        && visitCostController.numberValue >= 0 
        && travelCostController.numberValue >= 0 
        && _selectedContractType.isNotEmpty
        && _pickedDateTime != null
      ) {
        return true;
      } else {
        return false;
      }
    }

    void resetForm() {
      setState(() {
        chassisController.clear(); 
        fleetNumberController.clear(); 
        visitCostController.updateValue(0); 
        travelCostController.updateValue(0); 
        _selectedContractType = '';
        _pickedDateTime = null;
      });
    }

    UnityEquipment generateUnityEquipment() {
      return UnityEquipment(
        isActive: true,
        brand: widget.pickedUnityEquipment.brand,
        capacity: widget.pickedUnityEquipment.capacity,
        chassisNumber: chassisController.text,
        contractType: _selectedContractType,
        fleetNumber: fleetNumberController.text,
        group: widget.pickedUnityEquipment.group,
        description: widget.pickedUnityEquipment.description,
        technicalVisitCost: visitCostController.numberValue,
        travelCost: travelCostController.numberValue,
        warranty: _pickedDateTime,
      );
    }

    Future<void> _addUnityEquipmentToList() async {
      if(_formKey.currentState!.validate()) {
        setState(() => _checkingChassisAndFleetNumber = true);
        final result = await context.read<UnityManagementProvider>().checkChassisAndFleetNumber(
          userModel: context.read<CloudFirestoreProvider>().userModel,
          chassis: chassisController.text,
          fleetNumber: fleetNumberController.text,
          unityEquipments: newUnityEquipments,
        );
        
        if(result.isNotEmpty) {
          setState(() => _chassisOrFleetNumberInvalidError = result);
        } else {
          setState(() {
            _chassisOrFleetNumberInvalidError = '';
            newUnityEquipments.add(generateUnityEquipment());
          });
          resetForm();
        }
        setState(() => _checkingChassisAndFleetNumber = false);
      }
    }

    Future<void> _saveNewEquipments() async {
      setState(() => isSaving = true);
      final result = await context.read<UnityManagementProvider>().addNewEquipments(
        userModel: context.read<CloudFirestoreProvider>().userModel,
        unityEquipments: newUnityEquipments,
      );
      Navigator.of(context).pop(result);
      setState(() => isSaving = false);
    }


    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  CustomText(
                    text: 'Insira os dados deste equipamento:',
                    size: 17,
                    color: mediumBlue,
                  ),
                  InkWell(
                    onTap: _checkingChassisAndFleetNumber || isSaving ? null :  () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: mediumBlue,
                      size: 30,
                    ),
                  ), 
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: widget.pickedUnityEquipment.description,
                  color: mediumBlue,
                  size: 18,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: !_checkingChassisAndFleetNumber && !isSaving,
                      onChanged: (value) {
                        setState(() {
                          _chassisOrFleetNumberInvalidError = '';
                        });
                      },
                      controller: chassisController,
                      validator: (chassis) {
                        if(chassis!.isEmpty) {
                          return 'Digite um chassi';
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (value) => _addUnityEquipmentToList,
                      cursorColor: const Color.fromRGBO(125, 125, 207, 1),
                      decoration: addEquipmentToUnityFieldDecoration.copyWith(
                        labelText: 'Chassi',
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: TextFormField(
                      enabled: !_checkingChassisAndFleetNumber && !isSaving,
                      onChanged: (value) {
                        setState(() {
                          _chassisOrFleetNumberInvalidError = '';
                        });
                      },
                      controller: fleetNumberController,
                      validator: (fleetNumber) {
                        if(fleetNumber!.isEmpty) {
                          return 'Digite um número de frota';
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (value) => _addUnityEquipmentToList,
                      cursorColor: const Color.fromRGBO(125, 125, 207, 1),
                      decoration: addEquipmentToUnityFieldDecoration.copyWith(
                        labelText: 'Número de frota',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: !_checkingChassisAndFleetNumber && !isSaving,
                      onChanged: (value) {
                        setState(() {
                          if(value.isEmpty) {
                            visitCostController.updateValue(0);
                          }
                          _chassisOrFleetNumberInvalidError = '';
                        });
                      },
                      controller: visitCostController,
                      validator: (visitCost) {
                        if(visitCost!.isEmpty || visitCostController.numberValue < 0) {
                          return 'Digite um custo de visita válido';
                        }  else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (value) => _addUnityEquipmentToList,
                      cursorColor: const Color.fromRGBO(125, 125, 207, 1),
                      decoration: addEquipmentToUnityFieldDecoration.copyWith(
                        labelText: 'Custo de visita',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: TextFormField(
                      enabled: !_checkingChassisAndFleetNumber && !isSaving,
                      onChanged: (value) {
                        if(value.isEmpty) {
                          travelCostController.updateValue(0);
                        }
                        setState(() {
                          _chassisOrFleetNumberInvalidError = '';
                        });
                      },
                      controller: travelCostController,
                      validator: (travelCost) {
                        if(travelCost!.isEmpty || travelCostController.numberValue < 0) {
                          return 'Digite um custo de deslocamento válido';
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (value) => _addUnityEquipmentToList,
                      cursorColor: const Color.fromRGBO(125, 125, 207, 1),
                      decoration: addEquipmentToUnityFieldDecoration.copyWith(
                        labelText: 'Custo de deslocamento',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(203, 195, 245, 1),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        icon: Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(176, 165, 229, 1),
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(89, 98, 115, 1),
                        ),
                        onChanged: _checkingChassisAndFleetNumber == true || isSaving == true ? null : (selectedContractType) {
                          setState(() {
                            _selectedContractType = selectedContractType.toString();
                          });
                        },
                        hint: Text(
                          'Selecione um método',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(89, 98, 115, 1),
                          ),
                        ),
                        value: _selectedContractType.isEmpty ? null: _selectedContractType,
                        underline: const SizedBox(),
                        items: ['Locação', 'Venda'].map((op) {
                          return DropdownMenuItem(
                            value: op,
                            child: Text(
                              op,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(89, 98, 115, 1),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: _pickedDateTime == null ? ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(125, 125, 207, 1),
                        ),
                      ),
                      onPressed: _checkingChassisAndFleetNumber == true || isSaving == true ? null : () async {
                        final pickedDate = await showDatePicker(
                          context: context, 
                          initialDate: DateTime.now(), 
                          firstDate: DateTime.now().subtract(const Duration(days: 1)),
                          lastDate: DateTime.now().add(const Duration(days: 3650)),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData(
                                colorScheme: const ColorScheme.light(
                                  primary: Color.fromRGBO(125, 125, 207, 1),
                                  surface: Color.fromRGBO(125, 125, 207, 1),
                                  onSurface: Color.fromRGBO(125, 125, 207, 1),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if(pickedDate != null) {
                          setState(() {
                            _pickedDateTime = pickedDate;
                          });
                        }
                      },
                      child: const CustomText(
                        text: 'Selecionar tempo de garantia',
                        size: 14,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ) : 
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: '${_pickedDateTime!.day}/${_pickedDateTime!.month}/${_pickedDateTime!.year}',
                            color: mediumBlue,
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: _checkingChassisAndFleetNumber == true || isSaving == true ? null : () async {
                              final pickedDate = await showDatePicker(
                                context: context, 
                                initialDate: DateTime.now(), 
                                firstDate: DateTime.now().subtract(const Duration(days: 1)),
                                lastDate: DateTime.now().add(const Duration(days: 3650)),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData(
                                      colorScheme: const ColorScheme.light(
                                        primary: Color.fromRGBO(125, 125, 207, 1),
                                        surface: Color.fromRGBO(125, 125, 207, 1),
                                        onSurface: Color.fromRGBO(125, 125, 207, 1),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if(pickedDate != null) {
                                setState(() {
                                  _pickedDateTime = pickedDate;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.yellow,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: 'Quantidade de equipamentos adicionados: ${newUnityEquipments.length}',
                  size: 17,
                  color: mediumBlue,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: _chassisOrFleetNumberInvalidError,
                  color: Colors.red,
                  weight: FontWeight.w500,
                  size: 14,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 260,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      isFormCompleted() ? const Color.fromRGBO(170, 170, 232, 1) : Colors.grey,
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                  onPressed: !isFormCompleted() || _checkingChassisAndFleetNumber || isSaving ? null : _addUnityEquipmentToList, 
                  child: _checkingChassisAndFleetNumber ? 
                  const SizedBox(
                    width: 23,
                    height: 23,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        Colors.white,
                      ),
                    ),
                  ) : const CustomText(
                    text: 'Adicionar equipamento à lista',
                    color: Colors.white,
                    weight: FontWeight.w400,
                    size: 15,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // const Color.fromRGBO(170, 170, 232, 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            color: Color.fromRGBO(164, 164, 226, 1),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                      onPressed: _checkingChassisAndFleetNumber || isSaving ? null : resetForm, 
                      child: const CustomText(
                        text: 'Cancelar',
                        color: Color.fromRGBO(164, 164, 226, 1),
                        weight: FontWeight.w400,
                        size: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          newUnityEquipments.isNotEmpty ? 
                            const Color.fromRGBO(170, 170, 232, 1) 
                            : Colors.grey,
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                      onPressed: newUnityEquipments.isNotEmpty && !isSaving || !_checkingChassisAndFleetNumber ? _saveNewEquipments : null, 
                      child: isSaving ? 
                      const SizedBox(
                        width: 23,
                        height: 23,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            Colors.white,
                          ),
                        ),
                      ) :
                      const CustomText(
                        text: 'Salvar',
                        color: Colors.white,
                        weight: FontWeight.w400,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}