import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/managers/get_all_users_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/widgets/custom_get_user.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';

class GetAllUser extends StatefulWidget {
  const GetAllUser({Key? key}) : super(key: key);

  @override
  State<GetAllUser> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<GetAllUser>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(_handleTabChange);
    context.read<GetAllUsersCubit>().getAllUsersFunction(role: 'admin');
    context.read<GetAllUsersCubit>().getAllUsersFunction(role: 'manager');
    super.initState();
  }

  void _handleTabChange() {
    setState(() {
      _currentTabIndex = _tabController!.index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyCache.getString(key: CacheKeys.role) == 'manager'
          ? Container()
          : Visibility(
              visible: _currentTabIndex != 0,
              child: FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.addNewUser,
                    arguments: _currentTabIndex == 1
                        ? 'admin'
                        : _currentTabIndex == 2
                            ? 'manager'
                            : '',
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
      body: Column(
        children: [
          TabBar(
            indicatorColor: AppColors.primaryColor,
            controller: _tabController,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: Colors.black.withOpacity(0.8),
            labelStyle: GoogleFonts.cairo(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.cairo(
              fontWeight: FontWeight.w500,
            ),
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.user,
              ),
              Tab(
                text: AppLocalizations.of(context)!.admin,
              ),
              Tab(
                text: AppLocalizations.of(context)!.manager,
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  children: [
                    SizedBox(height: 50.h),
                    Text(
                      AppLocalizations.of(context)!
                          .choosethetypeofcustomertodisplay,
                      style: GoogleFonts.cairo(
                        height: 1.h,
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 40.w, right: 40.w, bottom: 20.h, top: 100.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.userNormalRoute);
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8.r),
                          color: AppColors.primaryColor,
                          child: Container(
                            width: double.infinity,
                            height: 100.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grey.withOpacity(0.01),
                                  offset: const Offset(1, 1),
                                  blurRadius: 10.r,
                                  spreadRadius: 0.1.r,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.userNormal,
                                  style: GoogleFonts.cairo(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    height: 1.h,
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 40.w, right: 40.w, top: 20.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.userWholesaleRoute);
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8.r),
                          color: AppColors.primaryColor,
                          child: Container(
                            width: double.infinity,
                            height: 100.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grey.withOpacity(0.01),
                                  offset: const Offset(1, 1),
                                  blurRadius: 10.r,
                                  spreadRadius: 0.1.r,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.userWholesale,
                                  style: GoogleFonts.cairo(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    height: 1.h,
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                BlocConsumer<GetAllUsersCubit, GetAllUsersState>(
                  listener: (context, state) {
                    if (state is AddNewManagerOrAdminSuccessState) {
                      var allManagersCubit = GetAllUsersCubit.get(context);
                      allManagersCubit.getAllUsersFunction(role: 'admin');
                    }
                    if (state is DeleteOneAdminOrManagerSuccessState) {
                      var allManagersCubit = GetAllUsersCubit.get(context);
                      allManagersCubit.getAllUsersFunction(role: 'admin');
                    }
                    if (state is UpdateSpecificUserSuccessState) {
                      var allManagersCubit = GetAllUsersCubit.get(context);
                      allManagersCubit.getAllUsersFunction(role: 'admin');
                    }
                  },
                  builder: (context, state) {
                    var allAdminsCubit = GetAllUsersCubit.get(context);

                    return RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: () {
                        return allAdminsCubit.getAllUsersFunction(
                            role: 'admin');
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Expanded(
                            child: state is GetAllAdminsLoadingState
                                ? const Center(
                                    child: CustomLoading(),
                                  )
                                : allAdminsCubit.adminUsersModel == null ||
                                        allAdminsCubit
                                            .adminUsersModel!.data!.isEmpty
                                    ? const Center(
                                        child: CustomLoading(),
                                      )
                                    : ListView.builder(
                                        itemCount: allAdminsCubit
                                            .adminUsersModel!.data!.length,
                                        itemBuilder: (context, index) {
                                          var admin = allAdminsCubit
                                              .adminUsersModel!.data![index];

                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RouteName.detailsUser);
                                            },
                                            child: CustomGetUser(
                                              name: admin.name!,
                                              phone: admin.phone!,
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  RouteName.detailsUser,
                                                  arguments: allAdminsCubit
                                                      .adminUsersModel!
                                                      .data![index]
                                                      .sId,
                                                );
                                              },
                                            ),
                                          );
                                        }),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                BlocConsumer<GetAllUsersCubit, GetAllUsersState>(
                  listener: (context, state) {
                    if (state is AddNewManagerOrAdminSuccessState) {
                      var allManagersCubit = GetAllUsersCubit.get(context);
                      allManagersCubit.getAllUsersFunction(role: 'manager');
                    }
                    if (state is DeleteOneAdminOrManagerSuccessState) {
                      var allManagersCubit = GetAllUsersCubit.get(context);
                      allManagersCubit.getAllUsersFunction(role: 'manager');
                    }
                  },
                  builder: (context, state) {
                    var allManagersCubit = GetAllUsersCubit.get(context);
                    // allManagersCubit.getAllUsersFunction(role: 'manager');
                    return RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: () {
                        return allManagersCubit.getAllUsersFunction(
                            role: 'manager');
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Expanded(
                            child: state is GetAllManagersLoadingState ||
                                    allManagersCubit.managerUsersModel == null
                                ? const Center(
                                    child: CustomLoading(),
                                  )
                                : allManagersCubit
                                        .managerUsersModel!.data!.isEmpty
                                    ? Text('Empty')
                                    : ListView.builder(
                                        itemCount: allManagersCubit
                                            .managerUsersModel!.data!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RouteName.detailsUser);
                                            },
                                            child: CustomGetUser(
                                              name: allManagersCubit
                                                  .managerUsersModel!
                                                  .data![index]
                                                  .name!,
                                              phone: allManagersCubit
                                                  .managerUsersModel!
                                                  .data![index]
                                                  .phone!,
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  RouteName.detailsUser,
                                                  arguments: allManagersCubit
                                                      .managerUsersModel!
                                                      .data![index]
                                                      .sId,
                                                );
                                              },
                                            ),
                                          );
                                        }),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
