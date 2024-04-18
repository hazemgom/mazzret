class GetAllFeedBacksModel {
  bool? success;
  List<Data>? data;

  GetAllFeedBacksModel({this.success, this.data});

  GetAllFeedBacksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? feedback;
  User? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.feedback,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    feedback = json['feedback'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['feedback'] = this.feedback;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
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
  String? password;
  String? role;
  bool? active;
  List<String>? wishlist;
  double? lat;
  double? lng;
  String? address;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? passwordResetCode;
  String? passwordResetExpires;
  bool? passwordResetVerified;

  User(
      {this.sId,
        this.name,
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
        this.iV,
        this.passwordResetCode,
        this.passwordResetExpires,
        this.passwordResetVerified});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
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
    iV = json['__v'];
    passwordResetCode = json['passwordResetCode'];
    passwordResetExpires = json['passwordResetExpires'];
    passwordResetVerified = json['passwordResetVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['role'] = this.role;
    data['active'] = this.active;
    data['wishlist'] = this.wishlist;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['passwordResetCode'] = this.passwordResetCode;
    data['passwordResetExpires'] = this.passwordResetExpires;
    data['passwordResetVerified'] = this.passwordResetVerified;
    return data;
  }
}
