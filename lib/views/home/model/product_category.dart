class ProductCategory {
  final String name;
  final String image;

  ProductCategory({required this.name, required this.image});

  ProductCategory.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image = json['image'];
}
