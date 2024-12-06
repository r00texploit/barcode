class CartItem {
  final String id;
  final String name;
  int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['barcode'] ?? '',
      name: map['products_name'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] is String)
          ? double.tryParse(map['price']) ?? 0.0
          : (map['price'] as double),
    );
  }
}
