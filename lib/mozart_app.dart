import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/managers/admin_order_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/managers/get_all_users_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/managers/admin_home_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/get_image_from_user/managers/get_all_images_from_users_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/feedback/managers/get_all_feedbacks_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/message/managers/get_all_messages_cubit.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/auth/managers/auth_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/washlist/managers/wishlist_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/make_marker_in_any_place_and_get_lar_lng.dart';
import 'package:mozart_flutter_app/provider/provider.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MozartApp extends StatelessWidget {
  const MozartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(),
            ),

            /// User
            BlocProvider(
              create: (context) => HomeCubit()
                ..getBanners()
                ..getCategory()

                ..getCategoryList()
                ..getProductInHighSold()
                ..getAllProductsFunction(),
            ),
            BlocProvider(
                create: (context) => UserCartCubit()
                  ..getAllUserCartFunction()
                  ..getAllUsersFunction(role: 'manager')
                // ..getUserAddresses(),
                ),
            BlocProvider(
              create: (context) => WishlistCubit()..getWishListFunction(),
            ),
            BlocProvider(
              create: (context) => ProfileCubit()
                ..getProfileData()
                ..getOrdersFunction()
                ..getAllReviews(),
            ),

            /// Admin
            BlocProvider(
              create: (context) =>
                  GetAllUsersCubit()..getAllUsersFunction(role: 'manager'),
            ),
            BlocProvider(
              create: (context) => AdminHomeCubit(),
            ),
            BlocProvider(
              create: (context) => AdminOrderCubit(),
            ),
            BlocProvider(
              create: (context) =>
                  GetAllImagesFromUsersCubit()..getAllImagesFromUserFunction(),
            ),
            BlocProvider(
              create: (context) =>
                  GetAllMessagesCubit()..getAllMessagesFromUserFunction(),
            ),
            BlocProvider(
              create: (context) =>
                  GetAllFeedbacksCubit()..getAllFeedBackFunction(),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            locale: MyCache.getString(key: CacheKeys.lang) == null ||
                    MyCache.getString(key: CacheKeys.lang) == ''
                ? Locale('ar')
                : Locale(MyCache.getString(key: CacheKeys.lang) ?? 'ar'),
            debugShowCheckedModeBanner: false,
            title: 'Mozart Application',
            // home: SplashScreen(),
            theme: ThemeData(
                // colorScheme: ColorScheme.fromSwatch(
                //   accentColor: AppColors.primaryColor.withOpacity(0.4),
                // ),
                ),
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: RouteName.splashRoute,
            // home: LocationDetailsScreen(),
          ),
        );
      },
    );
  }
}
