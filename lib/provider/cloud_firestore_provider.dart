import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rdx_manu_web/constants/instances.dart';
import 'package:rdx_manu_web/models/company.dart';
import 'package:rdx_manu_web/models/part.dart';
import 'package:rdx_manu_web/models/sheet_equipment.dart';
import 'package:rdx_manu_web/models/list_item.dart';
import 'package:rdx_manu_web/models/os_filter_data.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/models/unity.dart';
import 'package:rdx_manu_web/models/unity_equipment.dart';
import 'package:rdx_manu_web/models/unity_user.dart';
import 'package:rdx_manu_web/models/user_model.dart';

class CloudFirestoreProvider extends ChangeNotifier {

  late UserModel userModel;
  bool _hasPreviousPage = false;
  bool _hasNextPage = false;

  bool _hasNextListPage = false;

  String _listFor = 'Clientes';
  int _limitFor = 10;

  String get listFor => _listFor;
  set listFor(String value) {
    _listFor = value;
    notifyListeners();
  }

  int get limitFor => _limitFor;
  set limitFor(int value) {
    _limitFor = value;
    notifyListeners();
  }

  bool get hasPreviousPage => _hasPreviousPage;
  set hasPreviousPage(bool value) {
    _hasPreviousPage = value;
    notifyListeners();
  }

  bool get hasNextPage => _hasNextPage;
  set hasNextPage(bool value) {
    _hasNextPage = value;
    notifyListeners();
  }

  bool get hasNextListPage => _hasNextListPage;
  set hasNextListPage(bool value) {
    _hasNextListPage = value;
    notifyListeners();
  }

  QuerySnapshot? currSnap;

  DocumentReference get clientRef => firestore.doc('clients/${userModel.clientRefPath}');

  Future<List<OsFilterData>> loadOSFiltersData() async {
    final serviceOrders = await clientRef.collection('service_orders').orderBy('index').get();
    final serviceOrdersModelList = serviceOrders.docs.map((serviceOrderMap) {
      return ServiceOrder.fromDocument(serviceOrderMap, serviceOrderMap.id);
    }).toList();
    final List<OsFilterData> filtersDataList = generateFiltersDataList(
      ['O.S. finalizadas', 'O.S. em execução', 'Aprovação P.V pendente', 
      'Aprovação pendente', 'Orçamento pendente', 'Alocação pendente']
    );
    for(final serviceOrderModel in serviceOrdersModelList) {
      if(serviceOrderModel.stage == 5) {
        filtersDataList.firstWhere((e) => e.name == 'O.S. finalizadas').quantity += 1;
      } else if(serviceOrderModel.stage == 4) {
        filtersDataList.firstWhere((e) => e.name == 'O.S. em execução').quantity += 1;
      } else if(serviceOrderModel.stage == 3) {
        filtersDataList.firstWhere((e) => e.name == 'Aprovação P.V pendente').quantity += 1;
      } else if(serviceOrderModel.stage == 2) {
        filtersDataList.firstWhere((e) => e.name == 'Aprovação pendente').quantity += 1;
      } else if(serviceOrderModel.stage == 1) {
        filtersDataList.firstWhere((e) => e.name == 'Orçamento pendente').quantity += 1;
      } else if(serviceOrderModel.stage == 0) {
        filtersDataList.firstWhere((e) => e.name == 'Alocação pendente').quantity += 1;
      }
    }
    filtersDataList.sort((a, b) => a.order.compareTo(b.order));
    return filtersDataList;
  }

  List<OsFilterData> generateFiltersDataList(List<String> filterNames) {
    int index = 6;
    return filterNames.map((filterName) {
      final i = index;
      index = index - 1;
      return OsFilterData(name: filterName, quantity: 0, order: i);
    }).toList();
  }

  Future<List<ServiceOrder>> loadOS(String paginationState, QuerySnapshot? currentSnapshot) async {
    try{
      if(paginationState.isEmpty) {
        await clientRef.collection('service_orders').orderBy('index', descending: true).get().then((value) {
          if(value.docs.length >= 11) {
            hasPreviousPage = true;
          }
        });
        final serviceOrdersQuery = await clientRef.collection('service_orders').orderBy('index', descending: true).limit(10).get();
        currSnap = serviceOrdersQuery;
        return serviceOrdersQuery.docs.map((os) => ServiceOrder.fromDocument(os, os.id)).toList();
      
      } else if (paginationState == 'nextPage') {
        if(!hasPreviousPage) {
          hasPreviousPage = true; 
        }
        final serviceOrdersQuery = await clientRef.collection('service_orders').orderBy('index', descending: true).endBeforeDocument(currentSnapshot!.docs.first).limitToLast(10).get();
        currSnap = serviceOrdersQuery;
        return serviceOrdersQuery.docs.map((os) => ServiceOrder.fromDocument(os, os.id)).toList();
      
      } else if (paginationState == 'previousPage') {
        
        if(!hasNextPage) {
          hasNextPage = true; 
        }
        final serviceOrdersQuery = await clientRef.collection('service_orders').orderBy('index', descending: true).startAfterDocument(currentSnapshot!.docs.last).limit(10).get();
        if(serviceOrdersQuery.docs.any((e) => e.data()['index'].toString() == '1')) {
          hasPreviousPage = false;
        }
        currSnap = serviceOrdersQuery;
        return serviceOrdersQuery.docs.map((os) => ServiceOrder.fromDocument(os, os.id)).toList();
      
      } else {
        
        final serviceOrdersQuery = await clientRef.collection('service_orders').orderBy('index', descending: true).limit(10).get();
        currSnap = serviceOrdersQuery;
        return serviceOrdersQuery.docs.map((os) => ServiceOrder.fromDocument(os, os.id)).toList();
      
      }
    }catch(e){
      final serviceOrdersQuery = await clientRef.collection('service_orders').orderBy('index', descending: true).limit(10).get();
      currSnap = serviceOrdersQuery;
      return serviceOrdersQuery.docs.map((os) => ServiceOrder.fromDocument(os, os.id)).toList();
    }
  }

  Future<dynamic> loadSearchedOS(String search) async {
    final index = int.parse(search);
    final serviceOrderQuery = await clientRef.collection('service_orders').where('index', isEqualTo: index).get();
    if(serviceOrderQuery.docs.isNotEmpty) {
      final os = serviceOrderQuery.docs.first;
      return ServiceOrder.fromDocument(os, os.id);
    } else {
      return 'empty list';
    }
  }

  Future<List<ServiceOrder>> loadFilteredServiceOrders(int stage) async {
    final serviceOrdersQuery = await clientRef.collection('service_orders').where('stage', isEqualTo: stage).get();
    final serviceOrdersModelList =  serviceOrdersQuery.docs.map((os) => ServiceOrder.fromDocument(os, os.id)).toList();
    serviceOrdersModelList.sort((a, b) => b.index.compareTo(a.index));
    return serviceOrdersModelList;
  }

  Future<List<Company>> loadCompanies() async {
    final companiesQuery = await clientRef.collection('companies').get();
    return companiesQuery.docs.map((company) => Company.fromDocument(company.data(), company.id)).toList();
  }

  Future<List<Unity>> loadUnits(String companyUid) async {
    final unitsQuery = await clientRef.collection('companies/$companyUid/units').get();
    return unitsQuery.docs.map((unity) => Unity.fromDocument(unity.data(), unity.id, null)).toList();
  }

  Future<List<ListItem>> loadListFor() async {
    if(_listFor == 'Clientes') {
      final test = await clientRef.collection('companies').limit(limitFor + 10).get();
      if(test.docs.length > limitFor) {
        hasNextListPage = true;
      } else {
        hasNextListPage = false;
      }
      final companiesQuery = await clientRef.collection('companies').limit(limitFor).get();
      return companiesQuery.docs.map((company) => ListItem.fromGenericDoc(company.data(), company.id, 'company')).toList();
    } else if (_listFor == 'Peças') {
      final test = await clientRef.collection('client_parts').limit(limitFor + 10).get();
      if(test.docs.length > limitFor) {
        hasNextListPage = true;
      } else {
        hasNextListPage = false;
      }
      final partsQuery = await clientRef.collection('client_parts').limit(limitFor).get();
      return partsQuery.docs.map((part) => ListItem.fromGenericDoc(part.data(), part.id, '')).toList();
    } else if(_listFor == 'Equipamentos') {
      final test = await clientRef.collection('client_equipments').limit(limitFor + 10).get();
      if(test.docs.length > limitFor) {
        hasNextListPage = true;
      } else {
        hasNextListPage = false;
      }
      final equipmentsQuery = await clientRef.collection('client_equipments').limit(limitFor).get();
      return equipmentsQuery.docs.map((equipment) => ListItem.fromGenericDoc(equipment.data(), equipment.id, '')).toList();
    } else if (_listFor == 'Mecânicos') {
      final test = await clientRef.collection('units_users').where('type', isEqualTo: 'mechanical').limit(limitFor + 10).get();
      if(test.docs.length > limitFor) {
        hasNextListPage = true;
      } else {
        hasNextListPage = false;
      }
      final mechanicalsQuery = await clientRef.collection('units_users').where('type', isEqualTo: 'mechanical').limit(limitFor).get();
      return mechanicalsQuery.docs.map((mechanical) => ListItem.fromMechanicalDoc(mechanical.data(), mechanical.id)).toList();
    } else {
      return [];
    }
  }

  Future<List<Unity>> loadCompanyUnits(Company company) async {
    final unitsQuery = await clientRef.collection('companies/${company.uid}/units').get();
    return unitsQuery.docs.map((unity) => Unity.fromDocument(unity.data(), unity.id, company)).toList();
  }

  Future<List<UnityUser>> loadUnityUsers(String unityUid) async {
    final unitsUsers = await clientRef.collection('units_users').where('company.unity_uid', isEqualTo: unityUid).get();
    return unitsUsers.docs.map((unityUserDoc) => UnityUser.fromDocument(unityUserDoc.data(), unityUserDoc.id)).toList();
  }

  Future<List<UnityEquipment>> loadUnityEquipments(String unityUid, String companyUid) async {
    final unityEquipmentsRef = await clientRef.collection('companies/$companyUid/units/$unityUid/unity_equipments').get();
    return unityEquipmentsRef.docs.map((equipmentDoc) => UnityEquipment.fromUnity(equipmentDoc.data(), equipmentDoc.id)).toList();
  }

  Future<void> desactiveUnityUser(String unityUserUid, bool newValue) async {
    await clientRef.collection('units_users').doc(unityUserUid).update({
      'active': newValue,
    });
  }

  Future<void> desactiveUnityEquipment(Unity unity, String unityEquipmentUid, bool newValue) async {
    await clientRef.collection('companies/${unity.company!.uid}/units/${unity.uid}/unity_equipments').doc(unityEquipmentUid).update({
      'active': newValue,
    });
  }

  Future<void> deleteEquipmentFromUnity(Unity unity, String equipmentUid) async {
    await firestore.doc('clients/${userModel.clientRefPath}/companies/${unity.company!.uid}/units/${unity.uid}/unity_equipments/$equipmentUid').delete();
  }

  Future<List<UnityEquipment>> loadStoreEquipments() async {
    final storeEquipmentsQuery = await clientRef.collection('client_equipments').get();
    return storeEquipmentsQuery.docs.map((storeEquipmentDoc) => UnityEquipment.fromStore(storeEquipmentDoc.data(), storeEquipmentDoc.id)).toList();
  }
  
  Future<void> saveSheetEquipments(List<SheetEquipment> sheetEquipments) async {
    for(final sheetEquipment in sheetEquipments) {
      final test = await clientRef.collection('client_equipments').where('code', isEqualTo: sheetEquipment.code).get();
      if(test.docs.isEmpty) {
        await clientRef.collection('client_equipments').add(sheetEquipment.toMap());
      } else {
        await clientRef.collection('client_equipments').doc(test.docs.first.id).update(sheetEquipment.toMap());
      }
    }
  }

  Future<void> saveSheetParts(List<SheetPart> sheetParts) async {
    for(final sheetPart in sheetParts) {
      final test = await clientRef.collection('client_parts').where('code', isEqualTo: sheetPart.code).get();
      if(test.docs.isEmpty) {
        await clientRef.collection('client_parts').add(sheetPart.toMap());
      } else {
        await clientRef.collection('client_parts').doc(test.docs.first.id).update(sheetPart.toMap());
      }
    }
  }

  Future<void> createUserAccount({Company? company, Unity? unity, required UnityUser unityUser, required BuildContext context}) async {
    if(unityUser.userType == 'mechanical') {
      await clientRef.collection('units_users').doc(unityUser.uid).set({
        'active': true,
        'changed_password': false,
        'client_uid': userModel.clientRefPath,
        'cost_per_hour': unityUser.costPerHour,
        'name': unityUser.name,
        'type': 'mechanical',
        'user_uid': unityUser.uid,
      });
    } else if(unityUser.userType == 'requester') {
      await clientRef.collection('units_users').doc(unityUser.uid).set({
        'active': true,
        'changed_password': false,
        'client_uid': userModel.clientRefPath,
        'company': {
          'name': company!.name,
          'uid': company.uid,
          'unity_name': unity!.name,
          'unity_uid': unity.uid,
        },
        'name': unityUser.name,
        'type': 'requester',
        'user_uid': unityUser.uid,
      });
    } else if(unityUser.userType == 'approver') {
      await clientRef.collection('units_users').doc(unityUser.uid).set({
        'active': true,
        'changed_password': false,
        'client_uid': userModel.clientRefPath,
        'company': {
          'name': company!.name,
          'uid': company.uid,
          'unity_name': unity!.name,
          'unity_uid': unity.uid,
        },
        'name': unityUser.name,
        'type': 'approver',
        'user_uid': unityUser.uid,
      });
    } else if(unityUser.userType == 'admin' || unityUser.userType == 'aprovador') {
      await clientRef.collection('private_users').doc(unityUser.uid).set({
        'active': true,
        'changed_password': false,
        'client_uid': userModel.clientRefPath,
        'name': unityUser.name,
        'type': unityUser.userType,
        'user_uid': unityUser.uid,
      });
    }
  }

  Future<void> updateMechanicalState(String uid, bool state) async {
    await clientRef.collection('units_users').doc(uid).update({'active': state});
  }

  Future<void> updateMechanicalCostPerHour(String uid, double newCostPerHour) async {
    await clientRef.collection('units_users').doc(uid).update({'cost_per_hour': newCostPerHour});
  }

  Future<List<ListItem>> loadMechanicals() async {
    final mechanicalsQuery = await clientRef.collection('units_users').where('type', isEqualTo: 'mechanical').get();
    return mechanicalsQuery.docs.map((mechanicalDoc) => ListItem.fromMechanicalDoc(mechanicalDoc.data(), mechanicalDoc.id)).toList();
  }

  Future<Map<String, dynamic>> allocatedMechanical(String mechanicalUid, String serviceOrderUid) async {
    final now = Timestamp.now();
    final Map<String, dynamic> data = {
      'references.mechanical_uid': mechanicalUid,
      'event_dates.allocated': now,
      'stage': 1,
    };
    await clientRef.collection('service_orders').doc(serviceOrderUid).update(data);
    return data;
  }

  Future<void> unfreezeServiceOrder(String serviceOrderUid) async {
    await clientRef.collection('service_orders').doc(serviceOrderUid).update({'stage': 2});
  }

  Future<void> unfreezeWithDescount(String serviceOrderUid, double descount) async {
    await clientRef.collection('service_orders').doc(serviceOrderUid).update({
      'stage': 2,
      'descount': descount,
    });
  }

  Future<Map<String, dynamic>> approveOs(String serviceOrderUid) async {
    final now = Timestamp.now();
    final data = {
      'stage': 4,
      'event_dates.client_approved': now,
    };
    await clientRef.collection('service_orders').doc(serviceOrderUid).update(data);
    return data;
  }

  Future<void> changedPass(String clientRefUid) async {
    await firestore.doc('clients/$clientRefUid/private_users/${auth.currentUser!.uid}').update({
      'changed_password': true,
    });
  }

}