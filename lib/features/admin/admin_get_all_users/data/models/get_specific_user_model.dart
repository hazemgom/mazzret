class SpecificUserModel {
  Data? data;

  SpecificUserModel({this.data});

  SpecificUserModel.fromJson(Map<String, dynamic> json) {
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
  String? slug;
  String? email;
  String? phone;
  String? password;
  String? role;
  bool? active;
  bool? enablePermission;
  double? lat;
  double? lng;
  String? address;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.name,
        this.slug,
        this.email,
        this.phone,
        this.password,
        this.role,
        this.active,
        this.enablePermission,
        this.lat,
        this.lng,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    email = json['email'];
    phone = json['phone'];
    enablePermission = json['enablePermission'];
    password = json['password'];
    role = json['role'];
    active = json['active'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['enablePermission'] = this.enablePermission;
    data['role'] = this.role;
    data['active'] = this.active;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
