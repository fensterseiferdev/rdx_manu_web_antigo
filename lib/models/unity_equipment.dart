import 'package:rdx_manu_web/models/company.dart';

class UnityEquipment {
  String uid;
  final String code;
  final String description;
  final String chassisNumber;
  final String fleetNumber;
  final String contractType;
  final String brand;
  final String capacity;
  final String group;
  final double technicalVisitCost;
  final double travelCost;
  final DateTime? warranty;
  bool? isActive;
  Company? company;

  UnityEquipment({
    this.uid = '',
    this.description = '',
    this.chassisNumber = '',
    this.fleetNumber = '',
    this.contractType = '',
    this.isActive,
    this.code = '',
    this.brand = '',
    this.capacity = '',
    this.group = '',
    this.technicalVisitCost = 0,
    this.travelCost = 0,
    this.warranty,
    this.company,
  });


  factory UnityEquipment.fromUnity(Map<String, dynamic> equipmentMap, String equipmentUid) {
    return UnityEquipment(
      uid: equipmentUid,
      description: equipmentMap['name'].toString(),
      chassisNumber: equipmentMap['chassis'].toString(),
      fleetNumber: equipmentMap['fleet_number'].toString(),
      contractType: equipmentMap['contract_type'].toString(),
      isActive: equipmentMap['active'] as bool,
    );
  }

  factory UnityEquipment.fromStore(Map<String, dynamic> equipmentMap, String equipmentUid) {
    return UnityEquipment(
      uid: equipmentUid,
      code: equipmentMap['code'].toString(),
      description: equipmentMap['description'].toString(),
      brand: equipmentMap['brand'].toString(),
      capacity: equipmentMap['capacity'].toString(),
      group: equipmentMap['group'].toString(),
    );
  }

}
