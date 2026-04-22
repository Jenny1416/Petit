class HomeProduct {
  final int id;
  final String name;
  final String brand;
  final int price;
  final int oldPrice;
  final int discount;
  final double rating;
  final int reviews;
  final String image;
  final String category;
  final bool isFeatured;

  const HomeProduct({
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

  factory HomeProduct.fromJson(Map<String, dynamic> json) {
    return HomeProduct(
      id: json['id'] as int,
      name: json['name'] as String,
      brand: json['brand'] as String,
      price: json['price'] as int,
      oldPrice: json['oldPrice'] as int,
      discount: json['discount'] as int,
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'] as int,
      image: json['image'] as String,
      category: json['category'] as String,
      isFeatured: json['isFeatured'] as bool,
    );
  }
}