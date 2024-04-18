class AllUsersModel {
  int? results;
  PaginationResult? paginationResult;
  List<Data>? data;

  AllUsersModel({this.results, this.paginationResult, this.data});

  AllUsersModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? slug;
  String? email;
  String? phone;
  String? password;
  String? role;
  bool? active;
  List<String>? wishlist;
  double? lat;
  double? lng;
  String? address;
  String? createdAt;
  String? updatedAt;
  String? passwordResetCode;
  String? passwordResetExpires;
  bool? passwordResetVerified;

  Data(
      {this.sId,
        this.name,
        this.slug,
        this.email,
        this.phone,
        this.password,
        this.role,
        this.active,
        this.wishlist,
        this.lat,
        this.lng,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.passwordResetCode,
        this.passwordResetExpires,
        this.passwordResetVerified});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    role = json['role'];
    active = json['active'];
    wishlist = json['wishlist'].cast<String>();
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    passwordResetCode = json['passwordResetCode'];
    passwordResetExpires = json['passwordResetExpires'];
    passwordResetVerified = json['passwordResetVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['role'] = this.role;
    data['active'] = this.active ?? '';
    data['wishlist'] = this.wishlist ?? [];
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['passwordResetCode'] = this.passwordResetCode;
    data['passwordResetExpires'] = this.passwordResetExpires;
    data['passwordResetVerified'] = this.passwordResetVerified;
    return data;
  }
}
