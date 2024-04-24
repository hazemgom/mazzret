import 'package:flutter/material.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/data/models/all_orders_in_model.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/presentation/screens/details_order_from_user.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/presentation/screens/edit_to_order_data.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/presentation/screens/get_all_orders_in_user_normal.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/data/models/get_all_users_model.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/screens/add_new_user.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/screens/admin_edit_user.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/screens/details_user.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/presentation/screens/get_all_orders_in_user_wholesale.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/screens/get_all_user.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/screens/map_to_search_in_edit_user.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/screens/user_normal_screen.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/screens/user_wholesale_screen.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_layout.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/admin_home_screen.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/bannner/add_new_banner.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/bannner/admin_edit_banner.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/category/create_category.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/category/details_category.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/category/edit_category.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/category/get_all_categories.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/product/create_product.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/product/edite_to_product.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/product/get_all_product.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/get_image_from_user/presentation/get_image_from_user.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/coupons/presentation/add_coupons.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/coupons/presentation/coupons_screen.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/coupons/presentation/details_coupons_screen.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/feedback/presentation/feedback_screen.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/message/presentation/all_message.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/reviews/presentation/get_review.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/user_address/presentation/add_adress_of_branch.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/user_address/presentation/get_all_adress.dart';
import 'package:mozart_flutter_app/features/admin/sql_connection/presentation/choice_screen.dart';
import 'package:mozart_flutter_app/features/admin/sql_connection/presentation/sql_connection_screen.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/check_phone_or_email.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/forget_password_by_phone.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/login_screen.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/new_password_screen.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/register_screen.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:mozart_flutter_app/features/check_languge/presentation/check_language_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/add_adress_to%20confirm_order.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/all_addresses_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/all_my_addresses.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/cart_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/location_in_map.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/previous_adress.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/select_another_location.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/to_upload_image_admin_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/category/presentation/category_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/follow_order.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/presentation/get_categories_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/presentation/get_products_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/presentation/home_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/presentation/details_product.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/presentation/products_in_category_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/home_layout_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/all_address_in_profile.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/connect_with_us.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/get_specific_order.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/message_connect_with_us.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/my_account.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/my_order.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/my_reviews.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/profile_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/programmer_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/washlist/presentation/washlist_screen.dart';
import 'package:mozart_flutter_app/features/splash/splash_screen.dart';
import 'package:mozart_flutter_app/map_search.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashRoute:
        return PageTransition(
          child: SplashScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.loginRoute:
        return PageTransition(
          child: SignInScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.checkPhoneOrEmailRoute:
        return PageTransition(
          child: CheckPhoneOrEmail(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.forgetPasswordByEmailRoute:
        // final email = settings.arguments as String;

        return PageTransition(
          child: ForgetPasswordScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.forgetPasswordByPhoneRoute:
        // final phone = settings.arguments as String;

        return PageTransition(
          child: ForgetPasswordByPhoneScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.resetPasswordRoute:
        final email = settings.arguments as String;

        return PageTransition(
          child: ResetPasswordScreen(email: email),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.newPasswordRoute:
        final email = settings.arguments as String;

        return PageTransition(
          child: NewPasswordScreen(
            email: email,
          ),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.registerRoute:
        return PageTransition(
          child: RegisterScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.checkLanguageRoute:
        return PageTransition(
          child: CheckLangugeScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.homeLayoutRoute:
        return PageTransition(
          child: HomeLayoutScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.userNormalRoute:
        return PageTransition(
          child: UserNormalScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.userWholesaleRoute:
        return PageTransition(
          child: UserWholesaleScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.homeRoute:
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getMyReviewsRoute:
        return PageTransition(
          child: MyReviews(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.detailsProductRoute:
        return PageTransition(
          child: DetailsProduct(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.cartRoute:
        return PageTransition(
          child: CartScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.addAdressToConfirmOrderRoute:
        return PageTransition(
          child: AddAdressToConfirmOrder(
            amount: '',
          ),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.allMyAddressesRoute:
        return PageTransition(
          child: AllMyAddressesScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.previousAdressRoute:
        // final totalPrice = settings.arguments as dynamic;
        final String? address = settings.arguments as String?;
        final String? amount = settings.arguments as String?;

        return PageTransition(
          child: PreviousAdress(
            // totalPrice: totalPrice,
            address: '',
            amount: '',

          ),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.categoryRoute:
        return PageTransition(
          child: CategoryScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getCategoriesRoute:
        return PageTransition(
          child: GetCategoriesScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getAllProductsRoute:
        return PageTransition(
          child: GetProductsScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.profileRoute:
        return PageTransition(
          child: ProfileScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.connectWithUsRoute:
        return PageTransition(
          child: ConnectWithUs(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.messageConnectWithUsRoute:
        return PageTransition(
          child: MessageConnectWhithUs(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.myAccountRoute:
        return PageTransition(
          child: MyAccount(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.myOrderRoute:
        return PageTransition(
          child: MyOrderScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.allAddressesRoute:
        return PageTransition(
          child: AllAddressesScreen(
            address: '',
            amount: '',
          ),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.washlistRoute:
        return PageTransition(
          child: WashListScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.allAddressesInProfileRoute:
        return PageTransition(
          child: AllAddressesInProfileScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.programmerRoute:
        return PageTransition(
          child: ProgrammerScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.uploadScreenRoute:
        final productId = settings.arguments as String;

        return PageTransition(
          child: UploadImageToAdminScreen(productId: productId),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.productsInCategoryScreenRoute:
        final map = settings.arguments as Map;
        // final categoryId = settings.arguments as String;

        return PageTransition(
          child: ProductsInCategoryScreen(
            map: map,
          ),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.followOrderRoute:
        return PageTransition(
          child: FollowOrder(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getSpecificOrderRoute:
        final orderId = settings.arguments as String;

        return PageTransition(
          child: GetSpecificOrder(
            orderId: orderId,
          ),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.locationInMap:
        final data = settings.arguments as Map;

        return PageTransition(
          child: LocationInMap(data: data),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );

      /// Admin
      case RouteName.adminHomeLayoutRoute:
        return PageTransition(
          child: AdminHomeLayout(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.adminHome:
        return PageTransition(
          child: AdminHomeScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getAllProduct:
        return PageTransition(
          child: AdminGetAllProduct(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.admindetaisproduct:
        return PageTransition(
          child: DetailsProduct(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.createProduct:
        final data = settings.arguments as Map;

        return PageTransition(
          child: CreateProduct(
            data: data,
          ),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getAllUser:
        return PageTransition(
          child: GetAllUser(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.detailsUser:
        // Data allUsersModel = settings.arguments as Data;
        String id = settings.arguments as String;
        return PageTransition(
          child: DetailsUser(
            // allUsersModel: allUsersModel,
            id: id,
          ),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.adminGetAllCategories:
        return PageTransition(
          child: AdminGetAllCategories(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.addNewUser:
        final type = settings.arguments as String;

        return PageTransition(
          child: AddNewUser(type: type),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.addNewBanner:
        return PageTransition(
          child: AdminAddNewBanner(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.editBannerRoute:
        final bannerId = settings.arguments as String;

        return PageTransition(
          child: AdminEditBanner(
            bannerId: bannerId,
          ),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.adminCategory:
        return PageTransition(
          child: AdminCreateCategory(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.adminAddNewCategory:
        return PageTransition(
          child: AdminCreateCategory(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.mapToSearchRoute:
        return PageTransition(
          child: AdminMapToSearch(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.mapToSearchRouteInEditUser:
        final Map<String, dynamic> map =
            settings.arguments as Map<String, dynamic>;

        return PageTransition(
          child: AdminMapToSearchInEditUser(map: map),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.mapToSelectAnotherLocationRoute:
        final Map<String, dynamic> map =
            settings.arguments as Map<String, dynamic>;

        return PageTransition(
          child: MapToSelectAnotherLocation(map: map,),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.userNormalOrdersRoute:
        return PageTransition(
          child: GetAllOrdersInUserNormalInManager(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.userNormalOrdersRouteAdmin:
        return PageTransition(
          child: GetAllOrdersInUserNormalInAdmin(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.userWholesaleOrdersRoute:
        return PageTransition(
          child: GetAllOrdersInUserWholesaleInManager(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.userWholesaleOrdersRouteAdmin:
        return PageTransition(
          child: GetAllOrdersInUserWholesaleInAdmin(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.editeToOrderData:
        String orderId = settings.arguments as String;

        return PageTransition(
          child: EditToOrderData(orderId: orderId),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.editCategoryRoute:
        final categoryId = settings.arguments as String;

        return PageTransition(
          child: AdminEditCategory(categoryId: categoryId,
          name: '',
            image: '',
            nameAr: '',
          ),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.editUserRoute:
        final Map<String, dynamic> map =
            settings.arguments as Map<String, dynamic>;

        return PageTransition(
          child: AdminEditUser(map: map),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.detailsOrder:
        final orderId = settings.arguments as String;

        return PageTransition(
          child: DetailsOrderFromUser(orderId: orderId),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.editToProduct:
        final productId = settings.arguments as String;

        return PageTransition(
          child: EditToProduct(
              productId: productId,
              title: 'title',
              titleAr: 'titleAr',
              description: 'description',
              descriptionAr: 'descriptionAr',
              quantity: 'quantity',
              priceNormal: 'priceNormal',
              priceWholesale: 'priceWholesale'),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getReview:
        return PageTransition(
          child: GetReviewScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getAllAdress:
        return PageTransition(
          child: AdminGetAllAddress(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.addAddressOfBranch:
        return PageTransition(
          child: AddAdressOfBranch(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.detailsCoupons:
        return PageTransition(
          child: DetailsCouponsScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.addCoupons:
        return PageTransition(
          child: AddCoupons(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getCoupons:
        return PageTransition(
          child: CouponsScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getMessage:
        return PageTransition(
          child: AllMessage(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getImageFromUser:
        return PageTransition(
          child: GetImageFromUser(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.getFeedback:
        return PageTransition(
          child: FeedBackScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.sqlConnection:
        return PageTransition(
          child: SqlConnectionScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      case RouteName.choiceScreenAfterSQLConnection:
        return PageTransition(
          child: ChoiceScreenAfterSQLConnection(
            user: 'user',
            password: 'password',
            server: 'server',
            database: 'database',
          ),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 250),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            '',
          ),
        ),
        body: const Center(
          child: Text(
            '',
          ),
        ),
      ),
    );
  }
}

class RouteName {
  /// User
  static const String splashRoute = 'splash-screen';
  static const String checkPhoneOrEmailRoute = 'checkPhoneOrEmailRoute';
  static const String uploadScreenRoute = 'uploadScreenRoute';
  static const String getSpecificOrderRoute = 'getSpecificOrderRoute';
  static const String programmerRoute = 'programmerRoute';
  static const String editCategoryRoute = 'editCategoryRoute';
  static const String loginRoute = 'login-screen';
  static const String forgetPasswordByEmailRoute =
      'forgetPassword-by-email-screen';
  static const String forgetPasswordByPhoneRoute =
      'forgetPassword-by-phone-screen';
  static const String resetPasswordRoute = 'resetPassword-screen';
  static const String newPasswordRoute = 'newPassword-screen';
  static const String registerRoute = 'register-screen';
  static const String productsInCategoryScreenRoute =
      'prodcustInCategoryScreen';
  static const String checkLanguageRoute = 'checkLanguage-screen';
  static const String homeLayoutRoute = 'homeLayout-screen';
  static const String homeRoute = 'home-screen';
  static const String detailsProductRoute = 'detailsProduct-screen';
  static const String cartRoute = 'cart-screen';
  static const String allAddressesRoute = 'all-address-screen';
  static const String allAddressesInProfileRoute =
      'all-address-in-profile-screen';
  static const String addAdressToConfirmOrderRoute =
      'addAdressToConfirmOrder-screen';
  static const String previousAdressRoute = 'previousAdress-screen';
  static const String categoryRoute = 'category-screen';
  static const String profileRoute = 'profile-screen';
  static const String connectWithUsRoute = 'connectWithUs-screen';
  static const String editProfileRoute = 'editProfile-screen';
  static const String allMyAddressesRoute = 'allMyAddressesRoute';
  static const String locationInMap = 'locationInMap';
  static const String messageConnectWithUsRoute = 'messageConnectWithUs-screen';
  static const String myAccountRoute = 'myAccount-screen';
  static const String myOrderRoute = 'myOrder-screen';
  static const String washlistRoute = 'washlist-screen';
  static const String followOrderRoute = 'followOrder-screen';
  static const String getCategoriesRoute = 'getCategories-screen';
  static const String getMyReviewsRoute = 'getMyReviews-screen';
  static const String getAllProductsRoute = 'getProducts-screen';
  static const String mapToSelectAnotherLocationRoute =
      'mapToSelectAnotherLocationRoute';

  /// Amin
  static const String adminHomeLayoutRoute = 'adminHomeLayoutRoute';
  static const String adminHome = 'adminHome-screen';
  static const String detailsCategoryRoute = 'detailsCategoryRoute';
  static const String editBannerRoute = 'editBannerRoute';
  static const String adminGetAllCategories = 'adminGetAllCategories';
  static const String userNormalRoute = 'userNormalRoute';
  static const String userWholesaleRoute = 'userWholesaleRoute';
  static const String createProduct = 'createProduct-screen';
  static const String getAllProduct = 'getAllProduct-screen';
  static const String admindetaisproduct = 'getAllProduct-screen';
  static const String getAllUser = 'getAllUser-screen';
  static const String detailsUser = 'detailsUser-screen';
  static const String addNewUser = 'addNewUser-screen';
  static const String addNewBanner = 'addNewBanner-screen';
  static const String adminCategory = 'adminCategory-screen';
  static const String adminAddNewCategory = 'adminAddNewCategory-screen';
  static const String getReview = 'getReview-screen';
  static const String getAllAdress = 'getAllAdress-screen';
  static const String addAddressOfBranch = 'addAddressOfBranch-screen';
  static const String detailsCoupons = 'coupons-screen';
  static const String addCoupons = 'addCoupons-screen';
  static const String getCoupons = 'getCoupons-screen';
  static const String getMessage = 'getMessage-screen';
  static const String getImageFromUser = 'getImageFromUser-screen';
  static const String getFeedback = 'getFeedback-screen';
  static const String mapToSearchRoute = 'mapToSearchRoute';
  static const String detailsOrder = 'detailsOrder';
  static const String userNormalOrdersRoute = 'userNormalOrdersRoute';
  static const String userNormalOrdersRouteAdmin = 'userNormalOrdersRouteAdmin';
  static const String userWholesaleOrdersRoute = 'userWholesaleOrdersRoute';
  static const String userWholesaleOrdersRouteAdmin =
      'userWholesaleOrdersRouteAdmin';
  static const String editeToOrderData = 'editeToOrderData';
  static const String mapToSearchRouteInEditUser = 'mapToSearchRouteInEditUser';
  static const String editUserRoute = 'editUserRoute';
  static const String editToProduct = 'editToProduct';

  /// Connection
  static const String sqlConnection = 'sqlConnection';
  static const String choiceScreenAfterSQLConnection =
      'choiceScreenAfterSQLConnection';
}
