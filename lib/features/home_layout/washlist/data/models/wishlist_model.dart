import 'package:mozart_flutter_app/features/home_layout/home/data/models/banner_model.dart';

class WishListModel {
  String? status;
  dynamic? results;
  List<Data>? data;

  WishListModel({this.status, this.results, this.data});

  WishListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Image? image;
  String? sId;
  String? title;
  String? titleAr;
  String? slug;
  String? description;
  String? descriptionAr;
  dynamic? quantity;
  dynamic? sold;
  dynamic? priceNormal;
  dynamic? priceWholesale;
  List<Images>? images;
  Category? category;
  dynamic? ratingsQuantity;
  String? createdAt;
  String? updatedAt;
  dynamic? iV;
  String? id;

  Data(
      {this.image,
        this.sId,
        this.title,
        this.titleAr,
        this.slug,
        this.description,
        this.descriptionAr,
        this.quantity,
        this.sold,
        this.priceNormal,
        this.priceWholesale,
        this.images,
        this.category,
        this.ratingsQuantity,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    sId = json['_id'];
    title = json['title'];
    titleAr = json['titleAr'];
    slug = json['slug'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    quantity = json['quantity'];
    sold = json['sold'];
    priceNormal = json['priceNormal'];
    priceWholesale = json['priceWholesale'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    ratingsQuantity = json['ratingsQuantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['titleAr'] = this.titleAr;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['descriptionAr'] = this.descriptionAr;
    data['quantity'] = this.quantity;
    data['sold'] = this.sold;
    data['priceNormal'] = this.priceNormal;
    data['priceWholesale'] = this.priceWholesale;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['ratingsQuantity'] = this.ratingsQuantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}

class Image {
  String? url;
  String? imageId;

  Image({this.url, this.imageId});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    imageId = json['imageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['imageId'] = this.imageId;
    return data;
  }
}

class Category {
  String? name;
  String? nameAr;

  Category({this.name, this.nameAr});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameAr = json['nameAr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    return data;
  }
}
