import 'package:rdx_manu_web/models/company.dart';

class Unity {
  final String uid;
  String name;
  final String address;
  final String cnpj;
  final Company? company;
  
  Unity({this.uid = '', required this.name, required this.address, required this.cnpj, this.company});

  factory Unity.fromDocument(Map<String, dynamic> unityMap, String unityUid, Company? company) {
    return Unity(
      uid: unityUid,
      name: unityMap['name'].toString(),
      address: '0',
      cnpj: '',
      company: company,
    );
  }

}