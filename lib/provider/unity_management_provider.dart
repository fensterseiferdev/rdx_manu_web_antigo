import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/instances.dart';
import 'package:rdx_manu_web/models/unity.dart';
import 'package:rdx_manu_web/models/unity_equipment.dart';
import 'package:rdx_manu_web/models/user_model.dart';

class UnityManagementProvider extends ChangeNotifier {

  late Unity _selectedUnity;
  late List<Unity> units;

  DocumentReference<Map<String, dynamic>> unityRef(String clientUid) => firestore.doc('clients/$clientUid/companies/${_selectedUnity.company!.uid}/units/${_selectedUnity.uid}');

  Unity get selectedUnity => _selectedUnity;
  set selectedUnity(Unity newUnity) {
    _selectedUnity = newUnity;
    notifyListeners(); 
  }

  Future<void> changeUnityName(String newName, String clientUid) async {
    try{

      //TROCA NOME LOCAL NA LISTA
      units[units.indexWhere((u) => u.name == _selectedUnity.name)].name = newName;
      //TROCA NOME LOCAL NA SELECTED UNITY
      _selectedUnity.name = newName;
      //TROCA NO DOC DA UNITY
      await unityRef(clientUid).update({'name': newName});
      //TROCA NOS EQUIPAMENTOS DA UNITY
      final unityEquipmentsQuery = await unityRef(clientUid).collection('unity_equipments').get();
      for(final unityEquipmentDoc in unityEquipmentsQuery.docs) {
        await unityRef(clientUid).collection('unity_equipments').doc(unityEquipmentDoc.id).update({
          'company.unity_name': newName,
        });
      }
      //TROCA NAS OS
      final serviceOrdersQuery = await firestore.collection('clients/$clientUid/service_orders')
        .where('equipment.company.unity_uid', isEqualTo: _selectedUnity.uid).get();
      for(final serviceOrderDoc in serviceOrdersQuery.docs) {
        await firestore.collection('clients/$clientUid/service_orders').doc(serviceOrderDoc.id).update({
          'equipment.company.unity_name': newName,
        });
      }
      //TROCA NOS USUÁRIOS DA UNITY
      final unityUsersQuery = await firestore.collection('clients/$clientUid/units_users')
        .where('company.unity_uid', isEqualTo: _selectedUnity.uid).get();
      for(final unityUserDoc in unityUsersQuery.docs) {
        await firestore.collection('clients/$clientUid/units_users').doc(unityUserDoc.id).update({
          'company.unity_name': newName,
        });
      }
      notifyListeners();
    }catch(e) {
    }
  }
  
  Future<String> checkChassisAndFleetNumber({required UserModel userModel, required String chassis, required String fleetNumber, required List<UnityEquipment> unityEquipments}) async {
    String result = '';
    //VERIFICA SE JÁ EXISTE NA LISTA DE NOVOS
    for(final unityEquipment in unityEquipments) {
      if(unityEquipment.chassisNumber == chassis) {
        return result = 'Chassi já existente nesta lista';
      }
      if(unityEquipment.fleetNumber == fleetNumber) {
        if(result == 'Chassi já existente nesta lista') {
          return result = 'Chassi e Número de frota já existentes nesta lista';
        } else {
          return result = 'Número de frota já existente nesta lista';
        }
      }
    }
    //VERIRICA SE NA UNIDADE JÁ EXISTE ESSE EQUIPAMENTO
    final unityEquipmentsQuery =
      await firestore.collection('clients/${userModel.clientRefPath}/companies/${_selectedUnity.company!.uid}/units/${_selectedUnity.uid}/unity_equipments').get();
    for(final unityEquipment in unityEquipmentsQuery.docs) {
      if(unityEquipment['chassis'].toString() == chassis) {
        return result = 'Chassi já existente nesta unidade';
      }
      if(unityEquipment['fleet_number'].toString() == fleetNumber) {
        if(result == 'Chassi já existente nesta unidade') {
          return result = 'Chassi e Número de frota já existentes nesta unidade';
        } else {
          return result = 'Número de frota já existente nesta unidade';
        }
      }
    }
    //VERIFICA SE JÁ EXISTE EM TODAS AS UNIDADES
    final unitsQuery =
      await firestore.collection('clients/${userModel.clientRefPath}/companies/${_selectedUnity.company!.uid}/units').get();
    for(final unityDoc in unitsQuery.docs) {
      final unityEquipmentsQuery = 
        await firestore.collection('clients/${userModel.clientRefPath}/companies/${_selectedUnity.company!.uid}/units/${unityDoc.id}/unity_equipments').get();
      for(final unityEquipment in unityEquipmentsQuery.docs) {
        if(unityEquipment['chassis'].toString() == chassis) {
          return result = 'Chassi já existente em outra unidade';
        }
        if(unityEquipment['fleet_number'].toString() == fleetNumber) {
          if(result == 'Chassi já existente em outra unidade') {
            return result = 'Chassi e Número de frota já existentes em outra unidade';
          } else {
            return result = 'Número de frota já existente em outra unidade';
          }
        }
      }
    }
    
    return result;
  }

  Future<List<UnityEquipment>> addNewEquipments({required UserModel userModel, required List<UnityEquipment> unityEquipments}) async {
    try{
      for(final unityEquipment in unityEquipments) {
        final result =
          await firestore.collection('clients/${userModel.clientRefPath}/companies/${_selectedUnity.company!.uid}/units/${_selectedUnity.uid}/unity_equipments').add({
            'active': true,
            'brand': unityEquipment.brand,
            'capacity': unityEquipment.capacity,
            'chassis': unityEquipment.chassisNumber,
            'client_uid': userModel.clientRefPath,
            'company': {
              'name': selectedUnity.company!.name,
              'uid': selectedUnity.company!.uid,
              'unity_name': selectedUnity.name,
              'unity_uid': selectedUnity.uid,
            },
            'contract_type': unityEquipment.contractType,
            'fleet_number': unityEquipment.fleetNumber,
            'group': unityEquipment.group,
            'name': unityEquipment.description,
            'technical_visit_cost': unityEquipment.technicalVisitCost,
            'travel_cost': unityEquipment.travelCost,
            'warranty': Timestamp.fromDate(unityEquipment.warranty!),
          });
        unityEquipment.uid = result.id;
      }
      return unityEquipments;
    } catch(e) {
      return [];
    }
  }

}