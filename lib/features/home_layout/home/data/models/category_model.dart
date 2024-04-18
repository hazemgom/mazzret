// class CategoryModel {
//   int? results;
//   PaginationResult? paginationResult;
//   List<Data>? data;
//
//   CategoryModel({this.results, this.paginationResult, this.data});
//
//   CategoryModel.fromJson(Map<String, dynamic> json) {
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
//   int? currentPage;
//   int? limit;
//   int? numberOfPages;
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
//   String? name;
//   String? slug;
//   String? image;
//   String? createdAt;
//   String? updatedAt;
//
//   Data(
//       {this.sId,
//         this.name,
//         this.slug,
//         this.image,
//         this.createdAt,
//         this.updatedAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     slug = json['slug'];
//     image = json['image'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['image'] = this.image;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }

class CategoryModel {
  int? results;
  PaginationResult? paginationResult;
  List<CategoryData>? data;

  CategoryModel({this.results, this.paginationResult, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['paginationResult'] != null
        ? new PaginationResult.fromJson(json['paginationResult'])
        : null;
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryData.fromJson(v));
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
  int? currentPage;
  int? limit;
  int? numberOfPages;

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

class CategoryData {
  Image? image;
  String? sId;
  String? name;
  String? nameAr;
  String? slug;
  String? createdAt;
  String? updatedAt;

  CategoryData(
      {this.image,
        this.sId,
        this.name,
        this.nameAr,
        this.slug,
        this.createdAt,
        this.updatedAt});

  CategoryData.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    slug = json['slug'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    data['slug'] = this.slug;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
