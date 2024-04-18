class AddressesModel {
  String? status;
  int? results;
  List<Data>? data;

  AddressesModel({this.status, this.results, this.data});

  AddressesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? alias;
  String? details;
  String? phone;
  String? city;
  String? postalCode;
  String? sId;

  Data(
      {this.alias,
        this.details,
        this.phone,
        this.city,
        this.postalCode,
        this.sId});

  Data.fromJson(Map<String, dynamic> json) {
    alias = json['alias'];
    details = json['details'];
    phone = json['phone'];
    city = json['city'];
    postalCode = json['postalCode'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alias'] = this.alias;
    data['details'] = this.details;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['postalCode'] = this.postalCode;
    data['_id'] = this.sId;
    return data;
  }
}
