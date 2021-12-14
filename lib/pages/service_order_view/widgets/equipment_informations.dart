import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

import 'equipment_image_view.dart';

class EquipmentInformations extends StatefulWidget {
  final ServiceOrder serviceOrder;
  const EquipmentInformations(this.serviceOrder);

  @override
  _EquipmentInformationsState createState() => _EquipmentInformationsState();
}

class _EquipmentInformationsState extends State<EquipmentInformations> {
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();

  @override
  void initState() {
    super.initState();
    _mPlayer!.openAudioSession();
  }

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      _mPlayer!.closeAudioSession();
      _mPlayer = null;

      super.dispose();
    }

    Future<void> stopPlayer() async {
      await _mPlayer!.stopPlayer();
      setState(() {});
    }

    Future<void> startPlayer() async {
      setState(() {});
      await _mPlayer!.startPlayer(
          fromURI: widget.serviceOrder.audioUrl,
          whenFinished: () {
            stopPlayer();
          });
      setState(() {});
    }

    Widget equipmentInfoLine(
        {required String title1,
        required String value1,
        required String title2,
        required String value2}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title1,
                      style: TextStyle(
                        color: mediumBlue,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: value1,
                      style: TextStyle(
                        color: mediumBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title2,
                      style: TextStyle(
                        color: mediumBlue,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: value2,
                      style: TextStyle(
                        color: mediumBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      );
    }

    Widget equipmentStateDisplay(
        {required String stateName, required bool isSelected}) {
      return Material(
        borderRadius: BorderRadius.circular(4),
        color:
            isSelected ? const Color.fromRGBO(151, 151, 216, 1) : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          child: CustomText(
            text: stateName,
            color: isSelected ? Colors.white : const Color.fromRGBO(151, 151, 151, 1),
            size: 14,
            // color: Color.fromRGBO(151, 151, 151, 1),
            weight: FontWeight.w500,
            style: FontStyle.italic,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(246, 247, 251, 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: mediumBlue,
                  ),
                  const SizedBox(width: 15),
                  CustomText(
                    text: 'INFORMAÇÕES DO EQUIPAMENTO',
                    size: 16,
                    color: mediumBlue,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          equipmentInfoLine(
            title1: 'Equipamento:  ',
            value1: widget.serviceOrder.equipmentName,
            title2: 'Tipo de contrato:  ',
            value2: widget.serviceOrder.equipmentContractType == 'sell'
                ? 'Venda'
                : 'Locação',
          ),
          equipmentInfoLine(
            title1: 'Chassi:  ',
            value1: widget.serviceOrder.equipmentChassisNumber,
            title2: 'Número de frota:  ',
            value2: widget.serviceOrder.equipmentFleetNumber,
          ),
          equipmentInfoLine(
            title1: 'Marca:  ',
            value1: widget.serviceOrder.equipmentBrand,
            title2: 'Grupo:  ',
            value2: widget.serviceOrder.equipmentGroup,
          ),
          equipmentInfoLine(
            title1: 'Capacidade:  ',
            value1: widget.serviceOrder.equipmentCapacity,
            title2: '',
            value2: '',
          ),
          if(widget.serviceOrder.stage >= 2 || widget.serviceOrder.stage == -1)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(right: 65),
                          width: 225,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(
                              color: const Color.fromRGBO(207, 207, 207, 1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: CustomText(
                                  text: 'Horímetro:',
                                  size: 16,
                                  color: mediumBlue,
                                  weight: FontWeight.normal,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 15),
                                alignment: Alignment.center,
                                width: 80,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromRGBO(246, 247, 251, 1),
                                ),
                                child: CustomText(
                                  text: widget.serviceOrder.horimetro!,
                                  size: 14,
                                  color: mediumBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(right: 65),
                          width: 225,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(
                              color: const Color.fromRGBO(207, 207, 207, 1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: CustomText(
                                  text: 'Km:',
                                  size: 16,
                                  color: mediumBlue,
                                  weight: FontWeight.normal,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 15),
                                alignment: Alignment.center,
                                width: 80,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromRGBO(246, 247, 251, 1),
                                ),
                                child: CustomText(
                                  text: widget.serviceOrder.km!,
                                  size: 14,
                                  color: mediumBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Material(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(246, 247, 251, 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: mediumBlue,
                        ),
                        const SizedBox(width: 15),
                        CustomText(
                          text: 'RESUMO DO CHAMADO',
                          size: 16,
                          color: mediumBlue,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                equipmentInfoLine(
                  title1: 'Situação do equipamento:  ',
                  value1: 
                    '${widget.serviceOrder.equipmentState.characters.first.toUpperCase()}${widget.serviceOrder.equipmentState.substring(1)}'.replaceAll('_', ' '),
                  title2: 'Tipo de manutenção:  ',
                  value2: '${widget.serviceOrder.equipmentClassification!.characters.first.toUpperCase()}${widget.serviceOrder.equipmentClassification!.substring(1)}',
                ),
                equipmentInfoLine(
                  title1: 'Classificação:  ',
                  value1: 
                    '${widget.serviceOrder.equipmentApprovalCriteria!.characters.first.toUpperCase()}${widget.serviceOrder.equipmentApprovalCriteria!.substring(1)}'.replaceAll('_', ' '),
                  title2: '',
                  value2: '',
                ),
                const SizedBox(height: 15),
                CustomText(
                  text: 'Lista de problemas:',
                  color: mediumBlue,
                  size: 15,
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 10),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: widget.serviceOrder.equipmentProblems!.map((problem) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromRGBO(151, 151, 216, 1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                            child: CustomText(
                              text: problem,
                              color: Colors.white,
                              size: 14,
                              // color: Color.fromRGBO(151, 151, 151, 1),
                              weight: FontWeight.w500,
                              style: FontStyle.italic,
                            ),
                          ),
                        ),
                        if(problem != widget.serviceOrder.equipmentProblems!.last)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            width: 20,
                            height: 2,
                            color: lightGrey,
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Situação do equipamento:',
                  color: mediumBlue,
                  size: 15,
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 10),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    equipmentStateDisplay(
                      stateName: 'Não liga',
                      isSelected: widget.serviceOrder.equipmentState == 'nao_liga',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      width: 20,
                      height: 2,
                      color: lightGrey,
                    ),
                    equipmentStateDisplay(
                      stateName: 'Liga e não roda',
                      isSelected:
                          widget.serviceOrder.equipmentState == 'liga_e_nao_roda',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      width: 20,
                      height: 2,
                      color: lightGrey,
                    ),
                    equipmentStateDisplay(
                      stateName: 'Liga e roda',
                      isSelected: widget.serviceOrder.equipmentState == 'liga_e_roda',
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Imagens do equipamento:',
                      color: mediumBlue,
                      size: 15,
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: widget.serviceOrder.imagesUrl.map((image) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      EquipmentImageView(image),
                                );
                              },
                              child: Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      image,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    CustomText(
                      text: 'Áudio com detalhes do problema:',
                      color: mediumBlue,
                      size: 15,
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      alignment: Alignment.center,
                      width: 160,
                      height: 160,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: _mPlayer!.isPlaying ? stopPlayer : startPlayer,
                        child: CircleAvatar(
                          backgroundColor: lightPurple,
                          radius: 40,
                          child: Icon(
                            _mPlayer!.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 35),
          
        ],
      ),
    );
  }
}
