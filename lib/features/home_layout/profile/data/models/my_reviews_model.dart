// class MyReviewsModel {
//   dynamic? results;
//   PaginationResult? paginationResult;
//   List<Data>? data;
//
//   MyReviewsModel({this.results, this.paginationResult, this.data});
//
//   MyReviewsModel.fromJson(Map<String, dynamic> json) {
//     results = json['results'];
//     paginationResult = json['paginationResult'] != null
//         ? new PaginationResult.fromJson(json['paginationResult'])
//         : null;
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['results'] = this.results;
//     if (this.paginationResult != null) {
//       data['paginationResult'] = this.paginationResult!.toJson();
//     }
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class PaginationResult {
//   dynamic? currentPage;
//   dynamic? limit;
//   dynamic? numberOfPages;
//
//   PaginationResult({this.currentPage, this.limit, this.numberOfPages});
//
//   PaginationResult.fromJson(Map<String, dynamic> json) {
//     currentPage = json['currentPage'];
//     limit = json['limit'];
//     numberOfPages = json['numberOfPages'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['currentPage'] = this.currentPage;
//     data['limit'] = this.limit;
//     data['numberOfPages'] = this.numberOfPages;
//     return data;
//   }
// }
//
// class Data {
//   String? sId;
//   String? title;
//   String? imageCover;
//   dynamic? ratings;
//   User? user;
//   Product? product;
//   String? createdAt;
//   String? updatedAt;
//
//   Data(
//       {this.sId,
//         this.title,
//         this.imageCover,
//         this.ratings,
//         this.user,
//         this.product,
//         this.createdAt,
//         this.updatedAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     imageCover = json['imageCover'];
//     ratings = json['ratings'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     product =
//     json['product'] != null ? new Product.fromJson(json['product']) : null;
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['title'] = this.title;
//     data['imageCover'] = this.imageCover;
//     data['ratings'] = this.ratings;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }
//
// class User {
//   String? sId;
//   String? name;
//
//   User({this.sId, this.name});
//
//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     return data;
//   }
// }
//
// class Product {
//   String? sId;
//   String? title;
//   String? imageCover;
//   Null? category;
//   String? id;
//
//   Product({this.sId, this.title, this.imageCover, this.category, this.id});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     imageCover = json['imageCover'];
//     category = json['category'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['title'] = this.title;
//     data['imageCover'] = this.imageCover;
//     data['category'] = this.category;
//     data['id'] = this.id;
//     return data;
//   }
// }

import 'package:mozart_flutter_app/features/home_layout/home/data/models/banner_model.dart';

class MyReviewsModel {
  dynamic? results;
  PaginationResult? paginationResult;
  List<Data>? data;

  MyReviewsModel({this.results, this.paginationResult, this.data});

  MyReviewsModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['paginationResult'] != null
        ? new PaginationResult.fromJson(json['paginationResult'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.paginationResult != null) {
      data['paginationResult'] = this.paginationResult!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaginationResult {
  dynamic? currentPage;
  dynamic? limit;
  dynamic? numberOfPages;

  PaginationResult({this.currentPage, this.limit, this.numberOfPages});

  PaginationResult.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    limit = json['limit'];
    numberOfPages = json['numberOfPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['limit'] = this.limit;
    data['numberOfPages'] = this.numberOfPages;
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? ratings;
  User? user;
  Product? product;
  String? createdAt;
  String? updatedAt;
  dynamic? iV;

  Data(
      {this.sId,
        this.title,
        this.ratings,
        this.user,
        this.product,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
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
  Category? category;
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
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
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
    if (this.category != null) {
      data['category'] = this.category!.toJson();
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

class Category {
  String? name;

  Category({this.name});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

