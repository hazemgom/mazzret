import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/managers/admin_order_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/presentation/screens/get_oder_from_user.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/screens/get_all_user.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/admin_home_screen.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/profile_screen.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/custom_container_profile.dart';
import 'package:mozart_flutter_app/utils/connectivity.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_back_for_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_no_internet.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/header_drawer.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class AdminHomeLayout extends StatefulWidget {
  const AdminHomeLayout({Key? key}) : super(key: key);

  @override
  State<AdminHomeLayout> createState() => _AdminHomeLayoutState();
}

class _AdminHomeLayoutState extends State<AdminHomeLayout> {
  int currentIndex = 0;
  ConnectivityChecker? _connectivityChecker;
  bool _isConnected = false;

  @override
  void initState() {
    ProfileCubit.get(context).getProfileData();
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
    List<Widget> pages = [
      const AdminHomeScreen(),
      const GetAllUser(),
      const GetOrderFromUser(),
      AdminProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showAdaptiveDialog(
          context: context,
          builder: (context) =>
              CustomBackForAppBar(
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
                  icon: Icon(Icons.signal_cellular_connected_no_internet_0_bar_outlined),
                  text: 'SQL-Connection',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RouteName.sqlConnection);
                  },
                ),
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
                      builder: (context) =>
                          CustomBackForAppBar(
                            text: AppLocalizations.of(context)!
                                .doyouwanttologout,
                            onPressed: () {
                              MyCache.removeFromShared(key: CacheKeys.token);
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
        appBar: AppBar(
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
                AppAssets.usersIcon,
                height: 25.h,
                color:
                currentIndex == 1 ? AppColors.primaryColor : Colors.black,
              ),
              label: AppLocalizations.of(context)!.users,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                      AppAssets.order2Icon,
                      height: 25.h,
                      color: currentIndex == 2
                          ? AppColors.primaryColor
                          : Colors.black,
                    ),
              label: AppLocalizations.of(context)!.orders,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.profileIcon,
                height: 25.h,
                color:
                currentIndex == 3 ? AppColors.primaryColor : Colors.black,
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
