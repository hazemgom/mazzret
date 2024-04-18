part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

/// Login
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}

/// Signup

class SignupLoadingState extends AuthState {}

class SignupSuccessState extends AuthState {}

class SignupErrorState extends AuthState {}

/// Get Place And Position
class GetPlaceAndPositionLoadingState extends AuthState {}

class GetPlaceAndPositionSuccessState extends AuthState {}

class GetPlaceAndPositionErrorState extends AuthState {}

/// Forget Password
class ForgetPasswordLoadingState extends AuthState {}

class ForgetPasswordSuccessState extends AuthState {}

class ForgetPasswordErrorState extends AuthState {}

/// Verify OTP
class VerifyOTPLoadingState extends AuthState {}

class VerifyOTPSuccessState extends AuthState {}

class VerifyOTPErrorState extends AuthState {}

/// Update Password
class UpdatePasswordLoadingState extends AuthState {}

class UpdatePasswordSuccessState extends AuthState {}

class UpdatePasswordErrorState extends AuthState {}
