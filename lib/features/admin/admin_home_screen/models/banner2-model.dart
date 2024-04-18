class Banner2Model {
  final String imageUrl;
  final String imageId;
  final String id;
  final String title;
  final String titleAr;
  final String slug;
  final String description;
  final String descriptionAr;
  final int quantity;
  final int sold;
  final int priceNormal;
  final int priceWholesale;
  final List<dynamic> colors;
  final List<dynamic> images;
  final String categoryName;
  final String categoryNameAr;
  final List<dynamic> subcategories;
  final int ratingsQuantity;
  final String createdAt;
  final String updatedAt;

  Banner2Model({
    required this.imageUrl,
    required this.imageId,
    required this.id,
    required this.title,
    required this.titleAr,
    required this.slug,
    required this.description,
    required this.descriptionAr,
    required this.quantity,
    required this.sold,
    required this.priceNormal,
    required this.priceWholesale,
    required this.colors,
    required this.images,
    required this.categoryName,
    required this.categoryNameAr,
    required this.subcategories,
    required this.ratingsQuantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Banner2Model.fromJson(Map<String, dynamic> json) {
    return Banner2Model(
      imageUrl: json['image']['url'],
      imageId: json['image']['imageId'],
      id: json['_id'],
      title: json['title'],
      titleAr: json['titleAr'],
      slug: json['slug'],
      description: json['description'],
      descriptionAr: json['descriptionAr'],
      quantity: json['quantity'],
      sold: json['sold'],
      priceNormal: json['priceNormal'],
      priceWholesale: json['priceWholesale'],
      colors: json['colors'],
      images: json['images'],
      categoryName: '',
      categoryNameAr: '',
      subcategories: json['subcategories'],
      ratingsQuantity: json['ratingsQuantity'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}


