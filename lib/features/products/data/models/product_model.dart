class ProductModel {
  final int id;
  final String name;
  final String brand;
  final double price;
  final double oldPrice;
  final int discount;
  final double rating;
  final int reviews;
  final String image;
  final String category;
  final bool isFeatured;

  const ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.rating,
    required this.reviews,
    required this.image,
    required this.category,
    required this.isFeatured,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      oldPrice: json['oldPrice'].toDouble(),
      discount: json['discount'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      image: json['image'],
      category: json['category'],
      isFeatured: json['isFeatured'],
    );
  }
}
