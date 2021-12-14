class ManualInclusion {
  final String description;
  final double price;
  final int quantity;

  ManualInclusion({required this.description, required this.price, required this.quantity,});

  factory ManualInclusion.fromDocument(Map<String, dynamic> manualInclusionDoc) {
    return ManualInclusion(
      description: manualInclusionDoc['description'].toString(),
      price: double.parse(manualInclusionDoc['value'].toString()),
      quantity: int.parse(manualInclusionDoc['quantity'].toString()),
    );
  }

}
