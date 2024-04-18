class ProfileDataModel {
  Data? data;

  ProfileDataModel({this.data});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? role;
  bool? active;
  List<String>? wishlist;
  String? createdAt;
  String? updatedAt;
  dynamic lat;
  dynamic lng;
  String? address;


  Data(
      {this.sId,
        this.name,
        this.email,
        this.phone,
        this.password,
        this.role,
        this.lat,
        this.lng,
        this.address,
        this.active,
        this.wishlist,
        this.createdAt,
        this.updatedAt,
        });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    role = json['role'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    active = json['active'];
    wishlist = json['wishlist'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['role'] = this.role;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['active'] = this.active;
    data['wishlist'] = this.wishlist;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

