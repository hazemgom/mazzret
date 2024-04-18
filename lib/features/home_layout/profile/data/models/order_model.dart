// class OrderModel {
//   int? results;
//   PaginationResult? paginationResult;
//   List<Data>? data;
//
//   OrderModel({this.results, this.paginationResult, this.data});
//
//   OrderModel.fromJson(Map<String, dynamic> json) {
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
//   User? user;
//   List<CartItems>? cartItems;
//   int? taxPrice;
//   int? shippingPrice;
//   int? totalOrderPrice;
//   ShippingAddress? shippingAddress;
//   String? paymentMethod;
//   bool? isPaid;
//   bool? isDelivered;
//   User? branchId;
//   String? status;
//   String? accepteddAt;
//   String? paidAt;
//   String? deliveredAt;
//   String? createdAt;
//
//   Data(
//       {this.sId,
//         this.user,
//         this.cartItems,
//         this.taxPrice,
//         this.shippingPrice,
//         this.totalOrderPrice,
//         this.shippingAddress,
//         this.paymentMethod,
//         this.isPaid,
//         this.isDelivered,
//         this.branchId,
//         this.status,
//         this.accepteddAt,
//         this.paidAt,
//         this.deliveredAt,
//         this.createdAt,
//       });
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     if (json['cartItems'] != null) {
//       cartItems = <CartItems>[];
//       json['cartItems'].forEach((v) {
//         cartItems!.add(new CartItems.fromJson(v));
//       });
//     }
//     taxPrice = json['taxPrice'];
//     shippingPrice = json['shippingPrice'];
//     totalOrderPrice = json['totalOrderPrice'];
//     shippingAddress = json['shippingAddress'] != null
//         ? new ShippingAddress.fromJson(json['shippingAddress'])
//         : null;
//     paymentMethod = json['paymentMethod'];
//     isPaid = json['isPaid'];
//     isDelivered = json['isDelivered'];
//     branchId =
//     json['branchId'] != null ? new User.fromJson(json['branchId']) : null;
//     status = json['status'];
//     accepteddAt = json['accepteddAt'];
//     paidAt = json['paidAt'];
//     deliveredAt = json['deliveredAt'];
//     createdAt = json['createdAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.cartItems != null) {
//       data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
//     }
//     data['taxPrice'] = this.taxPrice;
//     data['shippingPrice'] = this.shippingPrice;
//     data['totalOrderPrice'] = this.totalOrderPrice;
//     if (this.shippingAddress != null) {
//       data['shippingAddress'] = this.shippingAddress!.toJson();
//     }
//     data['paymentMethod'] = this.paymentMethod;
//     data['isPaid'] = this.isPaid;
//     data['isDelivered'] = this.isDelivered;
//     if (this.branchId != null) {
//       data['branchId'] = this.branchId!.toJson();
//     }
//     data['status'] = this.status;
//     data['accepteddAt'] = this.accepteddAt;
//     data['paidAt'] = this.paidAt;
//     data['deliveredAt'] = this.deliveredAt;
//     data['createdAt'] = this.createdAt;
//     return data;
//   }
// }
//
// class User {
//   String? sId;
//   String? name;
//   String? email;
//   String? phone;
//   String? role;
//   double? lat;
//   double? lng;
//   String? address;
//
//   User(
//       {this.sId,
//         this.name,
//         this.email,
//         this.phone,
//         this.role,
//         this.lat,
//         this.lng,
//         this.address});
//
//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     role = json['role'];
//     lat = json['lat'];
//     lng = json['lng'];
//     address = json['address'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['role'] = this.role;
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     data['address'] = this.address;
//     return data;
//   }
// }
//
// class CartItems {
//   Product? product;
//   int? quantity;
//   int? price;
//   String? sId;
//
//   CartItems({this.product, this.quantity, this.price, this.sId});
//
//   CartItems.fromJson(Map<String, dynamic> json) {
//     product =
//     json['product'] != null ? new Product.fromJson(json['product']) : null;
//     quantity = json['quantity'];
//     price = json['price'];
//     sId = json['_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     data['quantity'] = this.quantity;
//     data['price'] = this.price;
//     data['_id'] = this.sId;
//     return data;
//   }
// }
//
// class Product {
//   String? sId;
//   String? title;
//   Category? category;
//   String? id;
//
//   Product({this.sId, this.title, this.category, this.id});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     category = json['category'] != null
//         ? new Category.fromJson(json['category'])
//         : null;
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['title'] = this.title;
//     if (this.category != null) {
//       data['category'] = this.category!.toJson();
//     }
//     data['id'] = this.id;
//     return data;
//   }
// }
//
// class Category {
//   String? name;
//
//   Category({this.name});
//
//   Category.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     return data;
//   }
// }
//
// class ShippingAddress {
//   String? details;
//   String? phone;
//   String? city;
//   String? postalCode;
//
//   ShippingAddress({this.details, this.phone, this.city, this.postalCode});
//
//   ShippingAddress.fromJson(Map<String, dynamic> json) {
//     details = json['details'];
//     phone = json['phone'];
//     city = json['city'];
//     postalCode = json['postalCode'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['details'] = this.details;
//     data['phone'] = this.phone;
//     data['city'] = this.city;
//     data['postalCode'] = this.postalCode;
//     return data;
//   }
// }

class OrderModel {
  bool? success;
  List<Data>? data;

  OrderModel({this.success, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
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
  int? orderNumber;
  User? user;
  List<CartItems>? cartItems;
  int? taxPrice;
  int? shippingPrice;
  int? totalOrderPrice;
  User? branchId;
  String? paymentMethod;
  bool? isPaid;
  bool? isDelivered;
  String? status;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
        this.orderNumber,
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
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderNumber = json['orderNumber'];
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
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['orderNumber'] = this.orderNumber;
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
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
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

class CartItems {
  Product? product;
  int? quantity;
  int? price;
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
  Category? category;
  String? id;

  Product({this.image, this.sId, this.title, this.category, this.id});

  Product.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    sId = json['_id'];
    title = json['title'];
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
