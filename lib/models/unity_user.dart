class UnityUser {
  final String uid;
  final String name;
  final String email;
  final String pass;
  final String userType;
  double? costPerHour;
  bool isActive;

  UnityUser({required this.uid, required this.name, this.email = '', this.pass = '', required this.userType, this.costPerHour, required this.isActive});

  factory UnityUser.fromDocument(Map<String, dynamic> unityUserMap, String unityUserUId) {
    return UnityUser(
      uid: unityUserUId,
      name: unityUserMap['name'].toString(),
      userType: unityUserMap['type'].toString(),
      isActive: unityUserMap['active'] as bool,
    );
  }

}