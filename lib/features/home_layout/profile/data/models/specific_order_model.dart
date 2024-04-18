class SpecificOrderModel {
  Data? data;

  SpecificOrderModel({this.data});

  SpecificOrderModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  List<CartItems>? cartItems;
  dynamic? taxPrice;
  dynamic? shippingPrice;
  dynamic? totalOrderPrice;
  User? branchId;
  String? paymentMethod;
  bool? isPaid;
  bool? isDelivered;
  String? status;
  dynamic? iV;
  String? accepteddAt;

  Data(
      {this.sId,
        this.user,
        this.cartItems,
        this.taxPrice,
        this.shippingPrice,
        this.totalOrderPrice,
        this.branchId,
        this.paymentMethod,
        this.isPaid,
        this.isDelivered,
        this.status,
        this.iV,
        this.accepteddAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    taxPrice = json['taxPrice'];
    shippingPrice = json['shippingPrice'];
    totalOrderPrice = json['totalOrderPrice'];
    branchId =
    json['branchId'] != null ? new User.fromJson(json['branchId']) : null;
    paymentMethod = json['paymentMethod'];
    isPaid = json['isPaid'];
    isDelivered = json['isDelivered'];
    status = json['status'];
    iV = json['__v'];
    accepteddAt = json['accepteddAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['taxPrice'] = this.taxPrice;
    data['shippingPrice'] = this.shippingPrice;
    data['totalOrderPrice'] = this.totalOrderPrice;
    if (this.branchId != null) {
      data['branchId'] = this.branchId!.toJson();
    }
    data['paymentMethod'] = this.paymentMethod;
    data['isPaid'] = this.isPaid;
    data['isDelivered'] = this.isDelivered;
    data['status'] = this.status;
    data['__v'] = this.iV;
    data['accepteddAt'] = this.accepteddAt;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? role;
  dynamic? lat;
  dynamic? lng;
  String? address;

  User(
      {this.sId,
        this.name,
        this.email,
        this.phone,
        this.role,
        this.lat,
        this.lng,
        this.address});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    return data;
  }
}

class CartItems {
  Product? product;
  dynamic? quantity;
  dynamic? price;
  String? sId;

  CartItems({this.product, this.quantity, this.price, this.sId});

  CartItems.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    price = json['price'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['_id'] = this.sId;
    return data;
  }
}

class Product {
  Image? image;
  String? sId;
  String? title;
  String? titleAr;
  Category? category;
  String? id;

  Product({this.image, this.sId, this.title, this.category, this.id});

  Product.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    sId = json['_id'];
    title = json['title'];
    titleAr = json['titleAr'];
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
    data['titleAr'] = this.titleAr;
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
  String? nameAr;

  Category({this.name, this.nameAr});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameAr = json['nameAr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    return data;
  }
}
