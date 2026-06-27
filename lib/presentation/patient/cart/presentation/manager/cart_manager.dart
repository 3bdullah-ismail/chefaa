class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<Map<String, dynamic>> cartItems = [];
  String? pharmacyId;

  void addToCart({
    required String pharmacyId,
    required String medicineId,
    required String name,
    required String dosage,
    required double price,
    int quantity = 1,
  }) {
    this.pharmacyId = pharmacyId;
    final index = cartItems.indexWhere((item) => item['medicineId'] == medicineId);
    if (index != -1) {
      cartItems[index]['quantity'] += quantity;
    } else {
      cartItems.add({
        "medicineId": medicineId,
        "name": name,
        "dosage": dosage,
        "price": price,
        "quantity": quantity,
      });
    }
  }
}
