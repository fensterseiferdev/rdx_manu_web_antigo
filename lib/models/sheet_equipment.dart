class SheetEquipment {

  String uid;
  String code;
  String description;
  String brand;
  String group;
  String capacity;

  SheetEquipment({this.uid = '', this.code = '', this.description = '', this.brand = '', this.group = '', this.capacity = ''});

  factory SheetEquipment.fromSheet(Map<String, dynamic> equipmentMap) {
    return SheetEquipment(
      code: equipmentMap['CODIGO'].toString(),
      description: equipmentMap['DESCRICAO'].toString(),
      brand: equipmentMap['MARCA'].toString(),
      group: equipmentMap['GRUPO'].toString(),
      capacity: equipmentMap['CAPACIDADE'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'capacity': capacity,
      'code': code,
      'description': description,
      'group': group,
    };
  }

}