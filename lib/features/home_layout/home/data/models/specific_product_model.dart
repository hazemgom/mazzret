import 'package:flutter/foundation.dart';
import 'package:mozart_flutter_app/features/home_layout/home/data/models/banner_model.dart';

class SpecificProductModel {
  Data? data;

  SpecificProductModel({this.data});

  SpecificProductModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  Map<String, dynamic>? category;
  dynamic? ratingsQuantity;
  String? createdAt;
  String? updatedAt;
  dynamic? iV;
  dynamic? ratingsAverage;
  List<Reviews>? reviews;
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
        this.ratingsAverage,
        this.reviews,
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
    category = json['category'];
    ratingsQuantity = json['ratingsQuantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    ratingsAverage = json['ratingsAverage'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
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
    data['category'] = this.category;
    data['ratingsQuantity'] = this.ratingsQuantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['ratingsAverage'] = this.ratingsAverage;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
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

class Reviews {
  String? sId;
  String? title;
  dynamic? ratings;
  User? user;
  Product? product;
  String? createdAt;
  String? updatedAt;
  dynamic? iV;

  Reviews(
      {this.sId,
        this.title,
        this.ratings,
        this.user,
        this.product,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    ratings = json['ratings'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['ratings'] = this.ratings;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? phone;

  User({this.sId, this.name, this.email, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Product {
  Image? image;
  String? sId;
  String? title;
  List<Images>? images;
  Map<String, dynamic>? category;
  String? id;

  Product(
      {this.image, this.sId, this.title, this.images, this.category, this.id});

  Product.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    sId = json['_id'];
    title = json['title'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    category = json['category'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['category'] = this.category;
    data['id'] = this.id;
    return data;
  }
}
