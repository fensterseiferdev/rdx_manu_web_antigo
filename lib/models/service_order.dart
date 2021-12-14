import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rdx_manu_web/models/os_part.dart';

import 'manual_inclusion.dart';

class ServiceOrder {
  String uid;
  int index;
  String companyName;
  String unityName;
  String equipmentName;
  String equipmentContractType;
  String equipmentChassisNumber;
  String equipmentFleetNumber;
  String equipmentGroup;
  String equipmentBrand;
  String equipmentCapacity;
  String equipmentState;
  List<String> imagesUrl;
  String audioUrl;
  int stage;
  double budget;
  double descount;
  String mechanicalUidRef;
  DateTime createdAt;
  DateTime? allocatedAt;
  DateTime? budgetAt;
  DateTime? approvedUnAt;
  DateTime? approvedPvAt;
  DateTime? osFinishedAt;
  double? laborCostPerHour;
  double? laborHours;
  double? laborMinutes;
  String? km;
  String? horimetro;
  String? equipmentClassification;
  String? equipmentApprovalCriteria;
  List<String>? equipmentProblems;
  double? technicalVisitCost;
  double? travelCost;
  List<OsPart>? osParts;
  List<ManualInclusion>? manualInclusions;
  double rate;

  ServiceOrder({
    required this.uid,
    required this.index,
    required this.companyName,
    required this.unityName,
    required this.equipmentName,
    required this.equipmentContractType,
    required this.equipmentChassisNumber,
    required this.equipmentFleetNumber,
    required this.equipmentGroup,
    required this.equipmentBrand,
    required this.equipmentCapacity,
    required this.equipmentState,
    required this.imagesUrl,
    required this.audioUrl,
    required this.stage,
    this.budget = 0,
    this.descount = 0,
    required this.mechanicalUidRef,
    required this.createdAt,
    this.allocatedAt,
    this.budgetAt,
    this.approvedUnAt,
    this.approvedPvAt,
    this.osFinishedAt,
    this.laborCostPerHour,
    this.laborHours,
    this.laborMinutes,
    this.km,
    this.horimetro,
    this.equipmentClassification,
    this.equipmentApprovalCriteria,
    this.equipmentProblems,
    this.technicalVisitCost,
    this.travelCost,
    this.osParts,
    this.manualInclusions,
    this.rate = 0,
  }) {
    uid = uid;
    index = index;
    companyName = companyName;
    unityName = unityName;
    equipmentName = equipmentName;
    equipmentContractType = equipmentContractType;
    equipmentChassisNumber = equipmentChassisNumber;
    equipmentFleetNumber = equipmentFleetNumber;
    equipmentGroup = equipmentGroup;
    equipmentBrand = equipmentBrand;
    equipmentCapacity = equipmentCapacity;
    equipmentState = equipmentState;
    imagesUrl = imagesUrl;
    audioUrl = audioUrl;
    stage = stage;
    budget = budget;
    descount = descount;
    mechanicalUidRef = mechanicalUidRef;
    createdAt = createdAt;
    allocatedAt = allocatedAt;
    budgetAt = budgetAt;
    approvedUnAt = approvedUnAt;
    approvedPvAt = approvedPvAt;
    osFinishedAt = osFinishedAt;
    laborCostPerHour = laborCostPerHour;
    laborHours = laborHours;
    laborMinutes = laborMinutes;
    km = km;
    horimetro = horimetro;
    equipmentClassification = equipmentClassification;
    equipmentApprovalCriteria = equipmentApprovalCriteria;
    equipmentProblems = equipmentProblems;
    technicalVisitCost = technicalVisitCost;
    travelCost = travelCost;
    osParts = osParts;
    manualInclusions = manualInclusions;
    rate = rate;
  }

  factory ServiceOrder.fromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> serviceOrderMap,
      String osUid) {
    DateTime? dateFrom(String value) {
      if (serviceOrderMap['event_dates'][value] != null) {
        return (serviceOrderMap['event_dates'][value] as Timestamp).toDate();
      } else {
        return null;
      }
    }

    double? laborForm(String value) {
      if (serviceOrderMap.data().containsKey('budget_data')) {
        return double.parse(
            serviceOrderMap['budget_data']['labor'][value].toString());
      } else {
        return null;
      }
    }

    String? budgetDataFrom(String value) {
      if (serviceOrderMap.data().containsKey('budget_data')) {
        return serviceOrderMap['budget_data'][value].toString();
      } else {
        return null;
      }
    }

    List<OsPart>? exportPartsListFromMap() {
      if (serviceOrderMap.data().containsKey('budget_data')) {
        final List<OsPart> osParts = [];
        final partsMapList =
            serviceOrderMap.data()['budget_data']['parts'] as List<dynamic>;
        for (final partMap in partsMapList) {
          osParts.add(OsPart.fromDocument(partMap as Map<String, dynamic>));
        }
        return osParts;
      } else {
        return null;
      }
    }

    List<ManualInclusion>? exportManualInclusionsListFromMap() {
      if (serviceOrderMap.data().containsKey('budget_data')) {
        final List<ManualInclusion> manualInclusions = [];
        final manualInclusionsMapList =
            serviceOrderMap.data()['budget_data']['manual_inclusions'] as List<dynamic>;
        for (final manualInclusionMap in manualInclusionsMapList) {
          manualInclusions.add(ManualInclusion.fromDocument(manualInclusionMap as Map<String, dynamic>));
        }
        return manualInclusions;
      } else {
        return null;
      }
    }

    return ServiceOrder(
      uid: osUid,
      index: int.parse(serviceOrderMap['index'].toString()),
      companyName: serviceOrderMap['equipment']['company']['name'].toString(),
      unityName:
          serviceOrderMap['equipment']['company']['unity_name'].toString(),
      equipmentName: serviceOrderMap['equipment']['name'].toString(),
      equipmentContractType:
          serviceOrderMap['equipment']['contract_type'].toString(),
      equipmentChassisNumber:
          serviceOrderMap['equipment']['chassis'].toString(),
      equipmentFleetNumber:
          serviceOrderMap['equipment']['fleet_number'].toString(),
      equipmentGroup: serviceOrderMap['equipment']['group'].toString(),
      equipmentBrand: serviceOrderMap['equipment']['brand'].toString(),
      equipmentCapacity: serviceOrderMap['equipment']['capacity'].toString(),
      equipmentState: serviceOrderMap['equipment']['state'].toString(),
      audioUrl: serviceOrderMap['equipment']['audio'].toString(),
      imagesUrl:
          List.from(serviceOrderMap['equipment']['images'] as List<dynamic>),
      stage: int.parse(serviceOrderMap['stage'].toString()),
      mechanicalUidRef:
          serviceOrderMap['references']['mechanical_uid'].toString(),
      budget: double.parse(serviceOrderMap['budget'].toString()),
      descount: double.parse(serviceOrderMap['descount'].toString()),
      createdAt:
          (serviceOrderMap['event_dates']['creation'] as Timestamp).toDate(),
      allocatedAt: dateFrom('allocated'),
      budgetAt: dateFrom('budget'),
      approvedUnAt: dateFrom('approved'),
      approvedPvAt: dateFrom('client_approved'),
      osFinishedAt: dateFrom('finished'),
      laborCostPerHour: laborForm('cost_per_hour'),
      laborHours: laborForm('hours'),
      laborMinutes: laborForm('minutes'),
      horimetro: budgetDataFrom('horimetro'),
      km: budgetDataFrom('km'),
      equipmentApprovalCriteria: budgetDataFrom('approval_criteria'),
      equipmentClassification: budgetDataFrom('classification'),
      equipmentProblems: serviceOrderMap.data().containsKey('budget_data')
          ? List.from(
              serviceOrderMap['budget_data']['problems'] as List<dynamic>)
          : null,
      technicalVisitCost: double.parse(
          serviceOrderMap['equipment']['technical_visit_cost'].toString()),
      travelCost:
          double.parse(serviceOrderMap['equipment']['travel_cost'].toString()),
      osParts: exportPartsListFromMap(),
      manualInclusions: exportManualInclusionsListFromMap(),
      rate: double.parse(serviceOrderMap['rate'].toString()),
    );
  }
}
