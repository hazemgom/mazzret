// class UserModel {
//   Data? data;
//   String? token;
//
//   UserModel({this.data, this.token});
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     token = json['token'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['token'] = this.token;
//     return data;
//   }
// }
//
// class Data {
//   String? userId;
//   String? name;
//   String? email;
//   String? role;
//   List<Addresses>? addresses;
//
//   Data({this.userId, this.name, this.email, this.role, this.addresses});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     name = json['name'];
//     email = json['email'];
//     role = json['role'];
//     if (json['addresses'] != null) {
//       addresses = <Addresses>[];
//       json['addresses'].forEach((v) {
//         addresses!.add(new Addresses.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['role'] = this.role;
//     if (this.addresses != null) {
//       data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Addresses {
//   String? alias;
//   String? details;
//   String? phone;
//   String? city;
//   String? postalCode;
//   String? sId;
//
//   Addresses(
//       {this.alias,
//         this.details,
//         this.phone,
//         this.city,
//         this.postalCode,
//         this.sId});
//
//   Addresses.fromJson(Map<String, dynamic> json) {
//     alias = json['alias'];
//     details = json['details'];
//     phone = json['phone'];
//     city = json['city'];
//     postalCode = json['postalCode'];
//     sId = json['_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['alias'] = this.alias;
//     data['details'] = this.details;
//     data['phone'] = this.phone;
//     data['city'] = this.city;
//     data['postalCode'] = this.postalCode;
//     data['_id'] = this.sId;
//     return data;
//   }
// }

class UserModel {
  Data? data;
  String? token;

  UserModel({this.data, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  String? userId;
  String? name;
  String? email;
  String? role;
  double? lat;
  double? lng;
  bool? active;

  Data({
    this.userId,
    this.name,
    this.email,
    this.role,
    this.lat,
    this.lng,
    this.active,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    lat = json['lat'];
    lng = json['lng'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['active'] = this.active;
    return data;
  }
}
