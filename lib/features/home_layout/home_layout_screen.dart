import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/cart_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/category/presentation/category_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/presentation/home_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/profile_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/custom_container_profile.dart';
import 'package:mozart_flutter_app/features/home_layout/washlist/presentation/washlist_screen.dart';
import 'package:mozart_flutter_app/provider/provider.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_back_for_app.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_no_internet.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/header_drawer.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../utils/connectivity.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  int currentIndex = 0;
  ConnectivityChecker? _connectivityChecker;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectivityChecker = ConnectivityChecker();
    _checkConnectivity();
    _connectivityChecker!.connectivityStream.listen((result) {
      setState(() {
        _isConnected = (result != ConnectivityResult.none);
      });
    });
  }

  Future<void> _checkConnectivity() async {
    bool isConnected = await _connectivityChecker!.isConnected();
    setState(() {
      _isConnected = isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);

    List<Widget> pages = [
      HomeScreen(),
      const CategoryScreen(),
      CartScreen(),
      const WashListScreen(),
      ProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () async {
        showAdaptiveDialog(
          context: context,
          builder: (context) => CustomBackForAppBar(
            text: AppLocalizations.of(context)!.doyouwanttoexit,
            onPressed: () {
              SystemNavigator.pop();
            },
            text2: AppLocalizations.of(context)!.exit,
          ),
        );
        return false;
      },
      child: _isConnected ? Scaffold(
        endDrawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HeaderDrawer(),
                const SizedBox(height: 20),
                CustomContainerProfile(
                  icon: SvgPicture.asset(AppAssets.programmerIcon,
                      width: 26.w, color: Colors.grey.shade600),
                  text: AppLocalizations.of(context)!.programmer,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RouteName.programmerRoute);
                  },
                ),
                CustomContainerProfile(
                  icon: SvgPicture.asset(AppAssets.signoutIcon),
                  text: AppLocalizations.of(context)!.signout,
                  onTap: () {
                    Navigator.pop(context);
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) => CustomBackForAppBar(
                        text: AppLocalizations.of(context)!.doyouwanttologout,
                        onPressed: () {
                          MyCache.removeFromShared(key: CacheKeys.token);
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            RouteName.loginRoute,
                          );
                        },
                        text2: AppLocalizations.of(context)!.exit,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: currentIndex == 2
            ? null
            : AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.primaryColor,
                title: Text(
                  AppLocalizations.of(context)!.mozart,
                  style: AppFonts.banadoraText,
                ),
                centerTitle: true,
              ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          showSelectedLabels: true,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedItemColor: AppColors.primaryColor,
          selectedLabelStyle: GoogleFonts.cairo(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.homeIcon,
                height: 25.h,
                color:
                    currentIndex == 0 ? AppColors.primaryColor : Colors.black,
              ),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.categoryIcon,
                height: 25.h,
                color:
                    currentIndex == 1 ? AppColors.primaryColor : Colors.black,
              ),
              label: AppLocalizations.of(context)!.categories,
            ),
            BottomNavigationBarItem(
              icon: BlocConsumer<UserCartCubit, UserCartState>(
                listener: (context, state) async {
                  if (state is AddToCartSuccessState) {
                    await UserCartCubit.get(context).getAllUserCartFunction();
                  }
                },
                builder: (context, state) {
                  var cartCubit = UserCartCubit.get(context);

                  return Badge.count(
                    count: cartCubit.userCartModel == null ||
                            cartCubit.userCartModel!.data!.cartItems == null
                        ? 0
                        : cartCubit.userCartModel!.data!.cartItems!.length,
                    child: SvgPicture.asset(
                      AppAssets.cartIcon,
                      height: 25.h,
                      color: currentIndex == 2
                          ? AppColors.primaryColor
                          : Colors.black,
                    ),
                  );
                },
              ),
              label: AppLocalizations.of(context)!.cart,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.favoriteIcon2,
                height: 25.h,
                color:
                    currentIndex == 3 ? AppColors.primaryColor : Colors.black,
              ),
              label: AppLocalizations.of(context)!.wishList,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.profileIcon,
                height: 25.h,
                color:
                    currentIndex == 4 ? AppColors.primaryColor : Colors.black,
              ),
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
      ) : const Scaffold(
        body: CustomNoInternet(),
      ),
    );
  }
}
