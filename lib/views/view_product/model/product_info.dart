class ProductInfo {
  String name;
  String description;
  String price;
  String weight;
  String category;
  String image;

  ProductInfo({
    required this.name,
    required this.description,
    required this.price,
    required this.weight,
    required this.category,
    required this.image,
  });

  ProductInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        price = json['price'],
        weight = json['weight'],
        category = json['category'],
        image = json['image'];
}
