import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/core/dio-helper.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/remote/dio_helper.dart';
import 'package:mozart_flutter_app/features/auth/data/models/user_model.dart';
import 'package:mozart_flutter_app/utils/constants/constants.dart';
import 'package:mozart_flutter_app/utils/location_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  UserModel userModel = UserModel();

  bool checkEmail(String val) {
    return val.contains('@gmail.com') ? true : false;
  }

  /// Login

  Future<void> loginFunction({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await dioHelper
        .postData(
            endPoint: AppConstants.loginUrl,
            body: checkEmail(email) == true
                ? {
                    'email': email,
                    'password': password,
                  }
                : {
                    'phone': email,
                    'password': password,
                  })
        .then((response) {
      userModel = UserModel.fromJson(response.data);

      print(response.data);
      MyCache.putString(key: CacheKeys.token, value: userModel.token!);
      MyCache.putString(key: CacheKeys.role, value: userModel.data!.role!);
      MyCache.putString(key: CacheKeys.fullName, value: userModel.data!.name!);
      MyCache.putString(key: CacheKeys.email, value: userModel.data!.email!);
      MyCache.putBoolean(key: CacheKeys.active, value: userModel.data!.active!);
      MyCache.putString(
          key: CacheKeys.userId, value: response.data['data']['userId']);
      print(MyCache.getString(key: CacheKeys.token));
      print(
          "************************************${MyCache.getString(key: CacheKeys.token)}");
      emit(LoginSuccessState());
    }).catchError((error) {
      print('Login error is $error');
      emit(LoginErrorState());
    });
  }

  ///otp
  void putData({
    required String email,
    required int otp,
  }) async {
    Dio dio = Dio();

    Map<String, dynamic> requestBody = {"email": email, "otp": otp};

    try {
      Response response = await dio.put(
        'https://onlinestore-xors.onrender.com/api/v1/auth/verifyAccount',
        data: requestBody,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // Handle response
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      emit(VerifyOTPSuccessState());
    } catch (e) {
      // Handle error
      print('Error: $e');
      emit(VerifyOTPErrorState());
    }
  }

  /// Signup
  Future<void> signUpFunction({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
    required String phone,
    required double lat,
    required double lng,
    required String address,
    required String role,
  }) async {
    emit(SignupLoadingState());
    await dioHelper.postData(
      endPoint: AppConstants.singUpUrl,
      body: {
        "name": name,
        "email": email,
        "password": password,
        "passwordConfirm": passwordConfirm,
        "phone": phone,
        // "street": streetName,
        // "apartment": apartment,
        // "zip": zipCode,
        // "city": city,
        // "country": country,
        "lat": lat,
        "lng": lng,
        "address": address,
        "role": role,
      },
    ).then((response) {
      emit(SignupSuccessState());
    }).catchError((error) {
      print('Sing Up error is $error');
      emit(SignupErrorState());
    });
  }

  void getPlaceAndPosition() {
    emit(GetPlaceAndPositionLoadingState());
    determinePosition().then((value) {
      print('success------');
      emit(GetPlaceAndPositionSuccessState());
    }).catchError((error) {
      print('error-------');
      emit(GetPlaceAndPositionErrorState());
    });
  }

  ///Forget Password
  Future<void> forgetPasswordFunction({required String emailOrPhone}) async {
    emit(ForgetPasswordLoadingState());
    await dioHelper
        .postData(
            endPoint: AppConstants.forgetPasswordUrl,
            body: checkEmail(emailOrPhone) == true
                ? {
                    'email': emailOrPhone,
                  }
                : {
                    'phone': emailOrPhone,
                  })
        .then(
      (response) {
        emit(ForgetPasswordSuccessState());
      },
    ).catchError((error) {
      print('Forget Password error is $error');
      emit(ForgetPasswordErrorState());
    });
  }

  /// Verify OTP
  Future<void> verifyOTPFunction({required String resetCode}) async {
    emit(VerifyOTPLoadingState());
    await dioHelper.postData(endPoint: AppConstants.verifyOTPUrl, body: {
      'resetCode': resetCode,
    }).then((response) {
      emit(VerifyOTPSuccessState());
    }).catchError((error) {
      print('Verify Code error is $error');
      emit(VerifyOTPErrorState());
    });
  }

  /// Update Password
  Future<void> updatePasswordFunction(
      {required String email, required String newPassword}) async {
    emit(UpdatePasswordLoadingState());
    await dioHelper
        .putData(
            endPoint: AppConstants.updatePasswordUrl,
            body: checkEmail(email) == true
                ? {
                    'email': email,
                    'newPassword': newPassword,
                  }
                : {
                    'phone': email,
                    'newPassword': newPassword,
                  })
        .then((response) {
      emit(UpdatePasswordSuccessState());
    }).catchError((error) {
      print('Update Password error is $error');
      emit(UpdatePasswordErrorState());
    });
  }

  ///otp
  DioHelper2? dioHelper2;

  Future<void> validateOtpCode({
    required String email,
    required String otp,
  }) async {
    try {
      emit(VerifyOTPLoadingState());
      final response = await DioHelper2.postData(
        url: 'https://onlinestore-xors.onrender.com/api/v1/auth/verifyAccount',
        data: {"email": email, "otp": otp},
      );
      print(response.data.toString());
      if (response.statusCode == 200) {
        print('otttttttttttp donnne');
        emit(VerifyOTPSuccessState());
      }
    } on Exception catch (e) {
      emit(VerifyOTPErrorState());
    }
  }
}
