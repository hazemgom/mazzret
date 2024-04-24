// class UserCartModel {
//   String? status;
//   int? numOfCartItems;
//   Data? data;
//
//   UserCartModel({this.status, this.numOfCartItems, this.data});
//
//   UserCartModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     numOfCartItems = json['numOfCartItems'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['numOfCartItems'] = this.numOfCartItems;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? sId;
//   List<CartItems>? cartItems;
//   String? user;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   int? totalCartPrice;
//
//   Data(
//       {this.sId,
//         this.cartItems,
//         this.user,
//         this.createdAt,
//         this.updatedAt,
//         this.iV,
//         this.totalCartPrice});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     if (json['cartItems'] != null) {
//       cartItems = <CartItems>[];
//       json['cartItems'].forEach((v) {
//         cartItems!.add(new CartItems.fromJson(v));
//       });
//     }
//     user = json['user'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     totalCartPrice = json['totalCartPrice'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     if (this.cartItems != null) {
//       data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
//     }
//     data['user'] = this.user;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['totalCartPrice'] = this.totalCartPrice;
//     return data;
//   }
// }
//
// class CartItems {
//   String? sId;
//   int? quantity;
//   int? price;
//   Product? product;
//
//   CartItems({this.sId, this.quantity, this.price, this.product});
//
//   CartItems.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     quantity = json['quantity'];
//     price = json['price'];
//     product =
//     json['product'] != null ? new Product.fromJson(json['product']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['quantity'] = this.quantity;
//     data['price'] = this.price;
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     return data;
//   }
// }
//
// class Product {
//   String? sId;
//   String? title;
//   String? description;
//   int? price;
//   String? image;
//
//   Product({this.sId, this.title, this.description, this.price, this.image});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     description = json['description'];
//     price = json['price'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     data['image'] = this.image;
//     return data;
//   }
// }
class UserCartModel {
  String? status;
  int? numOfCartItems;
  Data? data;

  UserCartModel({this.status, this.numOfCartItems, this.data});

  UserCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    numOfCartItems = json['numOfCartItems'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['numOfCartItems'] = this.numOfCartItems;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  List<CartItems>? cartItems;
  User? user;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? totalCartPrice;

  Data(
      {this.sId,
        this.cartItems,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.totalCartPrice});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['totalCartPrice'] = this.totalCartPrice;
    return data;
  }
}

class CartItems {
  String? sId;
  int? quantity;
  int? price;
  Product? product;

  CartItems({this.sId, this.quantity, this.price, this.product});

  CartItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quantity = json['quantity'];
    price = json['price'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? sId;
  String? title;
  String? titleAr;
  String? description;
  String? descriptionAr;
  String? image;

  Product(
      {this.sId,
        this.title,
        this.titleAr,
        this.description,
        this.descriptionAr,
        this.image});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    titleAr = json['titleAr'];
    description = json['description'];
    descriptionAr = json['descriptionAr'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['titleAr'] = this.titleAr;
    data['description'] = this.description;
    data['descriptionAr'] = this.descriptionAr;
    data['image'] = this.image;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? role;
  double? lat;
  double? lng;
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

