import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/data/models/get_all_users_model.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/data/models/get_specific_user_model.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/remote/dio_helper.dart';
import 'package:mozart_flutter_app/utils/constants/constants.dart';

part 'get_all_users_state.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersState> {
  GetAllUsersCubit() : super(GetAllUsersInitialState());

  static GetAllUsersCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  AllUsersModel? managerUsersModel;
  AllUsersModel? adminUsersModel;
  SpecificUserModel? specificUserModel;

  /// ---------------------------------- User ---------------------------------- ///
  /// ---------------------------------- Admin ---------------------------------- ///
  /// ---------------------------------- Manager ---------------------------------- ///
  /// Add New Manager or Admin
  Future<void> addNewManagerOrAdminFunction({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirm,
    required String role,
    required String lat,
    required String lng,
    required String address,
    // required bool enablePermission,
  }) async {
    emit(AddNewManagerOrAdminLoadingState());
    await dioHelper.postData(endPoint: AppConstants.getAllUsersUrl, body: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'passwordConfirm': passwordConfirm,
      'role': role,
      'lat': lat,
      'lng': lng,
      'address': address,
      // 'enablePermission': enablePermission,
    }).then((response) {
      emit(AddNewManagerOrAdminSuccessState());
    }).catchError((error) {
      print('Error in add new role in system is $error');
      emit(AddNewManagerOrAdminErrorState());
    });
  }

  /// Delete One Amin Or Manager
  Future<void> deleteOneAdminOrManager({required String id}) async {
    emit(DeleteOneAdminOrManagerLoadingState());
    await dioHelper.deleteData(endPoint: 'api/v1/users/$id').then((value) {
      emit(DeleteOneAdminOrManagerSuccessState());
    }).catchError((error) {
      print('Error in Delete One Amin Or Manager is $error');
      emit(DeleteOneAdminOrManagerErrorState());
    });
  }

  /// Get All Users
  Future<void> getAllUsersFunction({required String role}) async {
    emit(GetAllUsersLoadingState());
    await dioHelper
        .getData(endPoint: '${AppConstants.getAllUsersUrl}?role=$role')
        .then((response) {
      if (role == 'admin') {
        adminUsersModel = AllUsersModel.fromJson(response.data);
        if (adminUsersModel != null) {
          adminUsersModel!.data
              ?.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        }
      } else {
        if (adminUsersModel != null) {
          adminUsersModel!.data
              ?.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        }
        managerUsersModel = AllUsersModel.fromJson(response.data);
      }
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      print('Error in get all users in $error');
      emit(GetAllUsersErrorState());
    });
  }

  /// Get Specific User Or Admin Or Manager
  Future<void> getSpecificUserOrAdminOrManagerFunction(
      {required String id}) async {
    emit(GetSpecificUserLoadingState());
    await dioHelper
        .getData(endPoint: '${AppConstants.getSpecificUserUrl}$id')
        .then((response) {
      specificUserModel = SpecificUserModel.fromJson(response.data);
      emit(GetSpecificUserSuccessState());
    }).catchError((error) {
      print('Error in get specific user in $error');
      emit(GetSpecificUserErrorState());
    });
  }

  /// Update Specific User Or Admin Or Manager
  Future<void> updateSpecificUserOrAdminOrManagerFunction({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String lat,
    required String lng,
    required String address,
    // required bool enablePermission,
  }) async {
    emit(UpdateSpecificUserLoadingState());
    await dioHelper
        .putData(endPoint: '${AppConstants.getSpecificUserUrl}$id', body: {
      "name": name,
      "email": email,
      "phone": phone,
      "lat": lat,
      "lng": lng,
      "address": address,
      // "enablePermission": enablePermission,
    }).then((response) {
      // userData = Data.fromJson(response.data);
      emit(UpdateSpecificUserSuccessState());
    }).catchError((error) {
      print('Error in update specific user in $error');
      emit(UpdateSpecificUserErrorState());
    });
  }

  /// Delete Category
  Future<void> deleteUserFunction({
    required String id,
  }) async {
    emit(DeleteSpecificUserLoadingState());
    await dioHelper
        .deleteData(
      endPoint: '${AppConstants.getSpecificUserUrl}$id',
    )
        .then((response) {
      emit(DeleteSpecificUserSuccessState());
    }).catchError((error) {
      print('Error in delete user is $error');
      emit(DeleteSpecificUserErrorState());
    });
  }

  /// Delete Review  api/v1/reviews/
  Future<void> deleteReview({required String reviewId}) async {
    emit(DeleteOneReviewLoadingState());
    await dioHelper
        .deleteData(
      endPoint: '${AppConstants.deleteReviewsUrl}$reviewId',
    )
        .then((value) {
      emit(DeleteOneReviewSuccessState());
    }).catchError((error) {
      print('Error in delete one review is $error');
      emit(DeleteOneReviewErrorState());
    });
  }

  /// Make User Activate
  Future<void> makeUserActivate({required String userId}) async {
    emit(MakeUserActivateLoadingState());
    await dioHelper.postData(endPoint: 'api/v1/users/activate', body: {
      'userId': userId,
    }).then((value) {
      emit(MakeUserActivateSuccessState());
    }).catchError((error) {
      print(error);
      emit(MakeUserActivateErrorState());
    });
  }
}
