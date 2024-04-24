import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/remote/dio_helper.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/data/models/my_reviews_model.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/data/models/order_model.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/data/models/profile_model.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/data/models/specific_order_model.dart';
import 'package:mozart_flutter_app/utils/constants/constants.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  ProfileDataModel? profileDataModel;
  OrderModel? orderModel;
  MyReviewsModel? myReviewsModel;
  SpecificOrderModel? specificOrderModel;

  /// Get All Profile Data
  Future<void> getProfileData() async {
    emit(GetProfileDataLoadingState());
    await dioHelper
        .getData(endPoint: AppConstants.getProfileDataUrl)
        .then((response) {
      profileDataModel = ProfileDataModel.fromJson(response.data);
      emit(GetProfileDataSuccessState());
    }).catchError((error) {
      print('Get profile error in $error');
      emit(GetProfileDataErrorState());
    });
  }

  // void sortOrdersByDate() {
  //   if (orderModel != null && orderModel!.data != null) {
  //     orderModel!.data!.sort((a, b) {
  //       final DateTime dateA = DateTime.parse(a.!);
  //       final DateTime dateB = DateTime.parse(b.shippingAddress!.postalCode!);
  //       return dateB.compareTo(dateA);
  //     });
  //   }
  // }

  /// Get Orders
  Future<void> getOrdersFunction() async {
    emit(GetOrdersLoadingState());
    await dioHelper
        .getData(endPoint: AppConstants.getOrdersUrl)
        .then((response) {
      orderModel = OrderModel.fromJson(response.data);
      // if(orderModel != null) {
      //   orderModel!.data?.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      // }
      emit(GetOrdersSuccessState());
    }).catchError((error) {
      print('Get Orders error is $error');
      emit(GetOrdersErrorState());
    });
  }

  Future<void> getSpecificOrderFunction({required String orderId}) async {
    emit(GetSpecificOrderLoadingState());
    await dioHelper
        .getData(endPoint: '${AppConstants.addOrderUrl}$orderId')
        .then((response) {
          print(response.data);
      specificOrderModel = SpecificOrderModel.fromJson(response.data);
      emit(GetSpecificOrderSuccessState());
    }).catchError((error) {
      print('Error in get specific order in $error');
      emit(GetSpecificOrderErrorState());
    });
  }

  /// Get All Reviews
  Future<void> getAllReviews() async {
    emit(GetAllReviewsLoadingState());
    print('imad');
    try {
      final response = await dioHelper.getData(endPoint: AppConstants.getReviewsUrl);
      print(response.data);
      myReviewsModel = MyReviewsModel.fromJson(response.data);

      if (myReviewsModel != null) {
        myReviewsModel!.data!.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      }

      emit(GetAllReviewsSuccessState());
    } catch (error) {
      print('Get Reviews error is $error');
      emit(GetAllReviewsErrorState());
    }
  }

  /// Update User Date
  Future<void> updateUserData({
    required String name,
    required String email,
    required String phone,
    required String street,
    required String apartment,
    required String zip,
  }) async {
    emit(UpdateUserDataLoadingState());
    await dioHelper.putData(endPoint: AppConstants.updateUserDataUrl, body: {
      "name": name,
      "email": email,
      "phone": phone,
      // "street": street,
      // "apartment": apartment,
      // "zip": zip
    }).then((value) {
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      print('Error in Update user data in $error');
      emit(UpdateUserDataErrorState());
    });
  }

  /// Send Message To Admin
  Future<void> sendMessageToAdminFunction({
    required String name,
    required String messageContent,
  }) async {
    emit(SendMessageToAdminLoadingState());
    await dioHelper.postData(
        endPoint:
            '${AppConstants.sendMessageToAdminUrl}${MyCache.getString(key: CacheKeys.userId)}',
        body: {
          'name': name,
          'messageContent': messageContent,
        }).then((response) {
      emit(SendMessageToAdminSuccessState());
    }).catchError((error) {
      print('Error in Send Message to Admin is $error');
      emit(SendMessageToAdminErrorState());
    });
  }

  /// Send FeedBack To Admin
  Future<void> sendFeedBackToAdminFunction({required String feedback}) async {
    emit(SendFeedBackToAdminLoadingState());
    await dioHelper.postData(
        endPoint:
            // 'api/v1/feedback/654692c4095332f341dbb0e7',
            '${AppConstants.sendFeedBackToAdminUrl}${MyCache.getString(key: CacheKeys.userId)}',
        // '${AppConstants.sendFeedBackToAdminUrl}654692c4095332f341dbb0e7',
        body: {
          'feedback': feedback,
        }).then((response) {
      emit(SendFeedBackToAdminSuccessState());
    }).catchError((error) {
      print('Error in Send FeedBack to Admin is $error');
      emit(SendFeedBackToAdminErrorState());
    });
  }
}
