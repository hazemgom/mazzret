// class BannerModel {
//   int? results;
//   PaginationResult? paginationResult;
//   List<Data>? data;
//
//   BannerModel({this.results, this.paginationResult, this.data});
//
//   BannerModel.fromJson(Map<String, dynamic> json) {
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
//   List<String>? images;
//   String? createdAt;
//   String? updatedAt;
//
//   Data({this.sId, this.images, this.createdAt, this.updatedAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     images = json['images'].cast<String>();
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['images'] = this.images;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }

class BannerModel {
  int? results;
  PaginationResult? paginationResult;
  Data? data;

  BannerModel({this.results, this.paginationResult, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['paginationResult'] != null
        ? new PaginationResult.fromJson(json['paginationResult'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.paginationResult != null) {
      data['paginationResult'] = this.paginationResult!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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

class Data {
  String? sId;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;

  Data({this.sId, this.images, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Images {
  String? url;
  String? imageId;
  String? sId;

  Images({this.url, this.imageId, this.sId});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    imageId = json['imageId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['imageId'] = this.imageId;
    data['_id'] = this.sId;
    return data;
  }
}


// class BannerModel {
//   int? results;
//   PaginationResult? paginationResult;
//   Data? data;
//
//   BannerModel({this.results, this.paginationResult, this.data});
//
//   BannerModel.fromJson(Map<String, dynamic> json) {
//     results = json['results'];
//     paginationResult = json['paginationResult'] != null
//         ? new PaginationResult.fromJson(json['paginationResult'])
//         : null;
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['results'] = this.results;
//     if (this.paginationResult != null) {
//       data['paginationResult'] = this.paginationResult!.toJson();
//     }
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
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
//   String? id;
//   List<Images>? images;
//
//   Data({this.id, this.images});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Images {
//   String? url;
//   String? imageId;
//
//   Images({this.url, this.imageId});
//
//   Images.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     imageId = json['imageId'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['imageId'] = this.imageId;
//     return data;
//   }
// }



// class BannerModel {
//   int? results;
//   PaginationResult? paginationResult;
//   Data? data;
//
//   BannerModel({this.results, this.paginationResult, this.data});
//
//   BannerModel.fromJson(Map<String, dynamic> json) {
//     results = json['results'];
//     paginationResult = json['paginationResult'] != null
//         ? new PaginationResult.fromJson(json['paginationResult'])
//         : null;
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['results'] = this.results;
//     if (this.paginationResult != null) {
//       data['paginationResult'] = this.paginationResult!.toJson();
//     }
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
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
//   List<Images>? images;
//   String? createdAt;
//   String? updatedAt;
//
//   Data({this.sId, this.images, this.createdAt, this.updatedAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Images {
//   String? url;
//   String? imageId;
//
//   Images({this.url, this.imageId});
//
//   Images.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     imageId = json['imageId'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['imageId'] = this.imageId;
//     return data;
//   }
// }
