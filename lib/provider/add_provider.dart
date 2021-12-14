import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rdx_manu_web/constants/instances.dart';
import 'package:rdx_manu_web/models/company.dart';
import 'package:rdx_manu_web/models/sheet_equipment.dart';
import 'package:rdx_manu_web/models/user_model.dart';

class AddProvider {

  late UserModel userModel;

  DocumentReference get clientRef => firestore.collection('clients').doc(userModel.clientRefPath);
  CollectionReference get unitsUsersRef => clientRef.collection('units_users');
  CollectionReference get clientEquipmentsRef => clientRef.collection('client_equipments');

  Future<void> addBusiness({required String fantasyName, required String socialReason, required String cnpj}) async {
    final Map<String, dynamic> data = {
      'name': fantasyName,
      'company_name': socialReason,
      'cnpj': cnpj,
    };

    await firestore.collection('clients/${userModel.clientRefPath}/companies').add(data);
  }

  Future<void> addUnity({required String name, required String address, required String cnpj, required Company company}) async {
    final Map<String, dynamic> data = {
      'name': name,
      'address': address,
      'cnpj': cnpj,
    };

    await firestore.collection('clients/${userModel.clientRefPath}/companies/${company.uid}/units').add(data);
  }

  

  Future<void> storeEquipments(List<SheetEquipment> sheetEquipments) async {
    for(final sheetEquipment in sheetEquipments) {
      await clientEquipmentsRef.add({
        'code': sheetEquipment.code,
        'description': sheetEquipment.description,
        'brand': sheetEquipment.brand,
        'group': sheetEquipment.group,
        'capacity': sheetEquipment.capacity,
      });
    }
  }

}