
class OsPart {
  final String description;
  final String code;
  final String necessity;
  final double price;
  final int quantity;

  OsPart({
    required this.description,
    required this.code,
    required this.necessity,
    required this.price,
    required this.quantity,
  });

  factory OsPart.fromDocument(Map<String, dynamic> osPartDoc) {
    return OsPart(
      description: osPartDoc['description'].toString(),
      code: osPartDoc['code'].toString(),
      necessity: osPartDoc['need'].toString(),
      price: double.parse(osPartDoc['value'].toString()),
      quantity: int.parse(osPartDoc['quantity'].toString()),
    );
  }
}
