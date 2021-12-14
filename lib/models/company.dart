class Company {

  final String uid;
  final String name;
  final String socialReason;
  final String cnpj;
  
  Company({this.uid = '', required this.name, required this.socialReason, required this.cnpj});

  factory Company.fromDocument(Map<String, dynamic> companyMap, String companyUid) {
    return Company(
      uid: companyUid,
      name: companyMap['name'].toString(),
      cnpj: '',
      socialReason: '',
    );
  }

}