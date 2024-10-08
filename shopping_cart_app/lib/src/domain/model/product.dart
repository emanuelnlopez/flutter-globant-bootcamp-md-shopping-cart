class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rate;
  final int count;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.count,
  });

  factory Product.fromDynamic(dynamic map) => Product(
    id: map['id'], 
    title: map['title'], 
    price: (map['price'] as num).toDouble(), 
    description: map['description'], 
    category: map['category'], 
    image: map['image'], 
    rate: (map['rating']['rate'] as num).toDouble(), 
    count: map['rating']['count']
  );

  static List<Product> fromDynamicList(dynamic list) {
    final result  = <Product>[];

    if (list != null) {
      for (dynamic map in list) {
        result.add(Product.fromDynamic(map));
      }
    }

    return result;
  }
}