class ListItem {
  final String uid;
  final String name;
  final String type;
  bool? isActive;
  double? costPerHour;

  ListItem({required this.uid, required this.name, required this.type, this.isActive, this.costPerHour});

  factory ListItem.fromGenericDoc(Map<String, dynamic> genericMap, String genericUid, String type) {
    return ListItem(
      uid: genericUid,
      name: type == 'company' ? genericMap['name'].toString() : genericMap['description'].toString(),
      type: type,
    );
  }

  factory ListItem.fromMechanicalDoc(Map<String, dynamic> mechanicalMap, String mechanicalUid) {
    return ListItem(
      uid: mechanicalUid,
      name: mechanicalMap['name'].toString(),
      isActive: mechanicalMap['active'] as bool,
      costPerHour: double.parse(mechanicalMap['cost_per_hour'].toString()),
      type: 'mechanical',
    );
  }

}