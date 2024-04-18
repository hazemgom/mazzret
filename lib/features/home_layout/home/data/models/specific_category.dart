class SpecificCategoryModel {
  Data? data;

  SpecificCategoryModel({this.data});

  SpecificCategoryModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? nameAr;
  String? slug;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.image,
        this.sId,
        this.name,
        this.nameAr,
        this.slug,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    sId = json['_id'];
    name = json['name'];
    nameAr = json['nameAr'];
    slug = json['slug'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
    data['__v'] = this.iV;
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
