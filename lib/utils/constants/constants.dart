import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConstants {
  static const String baseImage = 'assets/images/';
  static const baseUrl = 'https://onlinestore-xors.onrender.com/';
  // static const baseUrl = 'http://192.168.1.11:8000/';
  // static const baseUrl = 'http://192.168.1.12:8000/';
  /// Authentication
  static const loginUrl = 'api/v1/auth/login';
  static const singUpUrl = 'api/v1/auth/signup';
  static const forgetPasswordUrl = 'api/v1/auth/forgotPassword';
  static const verifyOTPUrl = 'api/v1/auth/verifyResetCode';
  static const updatePasswordUrl = 'api/v1/auth/resetPassword';

  ///------------------------ User ------------------------//

  /// Home
  static const getBannerUrl = 'api/v1/banners';
  static const getSpecificBannerUrl = 'api/v1/banners/';
  // static const getCategoryUrl = 'api/category/Categories';
  static const getCategoryUrl = 'api/v1/categoeires';
  static const getSpecificCategoryUrl = 'api/v1/categoeires/';
  static const getProductsInCategoryUrl = 'api/v1/categoeires/';
  static const getProductUrl = 'api/v1/products';
  static const getSpecificProductUrl = 'api/v1/products/';
  static const addToCartUrl = 'api/v1/cart';
  static const addReviewUrl = 'api/v1/reviews';
  static const addFavoriteUrl = 'api/v1/wishlist';
  static const uploadImageToAdminUrl = 'api/v1/uploadImage/';

  /// Cart
  static const getAllUserCartUrl = 'api/v1/cart';
  static const deleteOneAndUpdateProductFromUserCartUrl = 'api/v1/cart/';
  static const getUserAddressesUrl = 'api/v1/addresses';
  static const addOrderUrl = 'api/v1/orders/';

  /// Order
  static const getAllBranchesUrl = 'api/v1/users';

  /// WishList
  static const getWishListUrl = 'api/v1/wishlist';
  static const removeFromWishListUrl = 'api/v1/wishlist/';

  /// Profile Data
  static const getProfileDataUrl = 'api/v1/users/getMe';
  static const getOrdersUrl = 'api/v1/orders/myOrders';
  static const getReviewsUrl = 'api/v1/reviews';
  static const deleteReviewsUrl = 'api/v1/reviews/';
  static const updateUserDataUrl = 'api/v1/users/updateMe';
  static const sendMessageToAdminUrl = 'api/v1/message/';
  static const sendFeedBackToAdminUrl = 'api/v1/feedback/';

  ///------------------------ Admin ------------------------//

  static const getAllUsersUrl = 'api/v1/users';
  static const createBannerUrl = 'api/v1/banners';
  static const deleteAllImagesInBannerUrl = 'api/v1/banners/';
  static const createCategoryUrl = 'api/v1/categoeires';
  static const updateAndDeleteCategoryUrl = 'api/v1/categoeires/';
  static const createProductUrl = 'api/v1/products';
  static const deleteProductUrl = 'api/v1/products/';
  static const getSpecificUserUrl = 'api/v1/users/';
  static const getAllOrdersUrl = 'api/v1/orders';


  static TextStyle getTextStyle({
    required FontWeight fontWeight,
    required double fontSize,
    required double letterSpacing,
    required double height,
    required Color color,
  }) {
    return GoogleFonts.cairo(
      fontWeight: fontWeight,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      height: height,
      color: color,
    );
  }

  static launchFacebookProfile({required String faceLink}) async {
    String facebookUrl = faceLink;

    if (await canLaunch(facebookUrl)) {
      await launch(facebookUrl);
    } else {
      throw 'Could not launch $facebookUrl';
    }
  }

  static openWhatsAppChat({required String num, required String urlLink}) async {
    String phoneNumber = num;
    String url = urlLink;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> openInstagram() async {
    const url = 'https://www.instagram.com'; // Instagram URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
