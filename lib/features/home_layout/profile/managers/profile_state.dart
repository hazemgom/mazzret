part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

/// Get Profile Data
class GetProfileDataLoadingState extends ProfileState {}

class GetProfileDataSuccessState extends ProfileState {}

class GetProfileDataErrorState extends ProfileState {}

/// Get Orders
class GetOrdersLoadingState extends ProfileState {}

class GetOrdersSuccessState extends ProfileState {}

class GetOrdersErrorState extends ProfileState {}

/// Get Specific Order
class GetSpecificOrderLoadingState extends ProfileState {}

class GetSpecificOrderSuccessState extends ProfileState {}

class GetSpecificOrderErrorState extends ProfileState {}

/// Get All Reviews
class GetAllReviewsLoadingState extends ProfileState {}

class GetAllReviewsSuccessState extends ProfileState {}

class GetAllReviewsErrorState extends ProfileState {}

/// Update User Data
class UpdateUserDataLoadingState extends ProfileState {}

class UpdateUserDataSuccessState extends ProfileState {}

class UpdateUserDataErrorState extends ProfileState {}

/// Send Message To Admin
class SendMessageToAdminLoadingState extends ProfileState {}

class SendMessageToAdminSuccessState extends ProfileState {}

class SendMessageToAdminErrorState extends ProfileState {}

/// Send FeedBack To Admin
class SendFeedBackToAdminLoadingState extends ProfileState {}

class SendFeedBackToAdminSuccessState extends ProfileState {}

class SendFeedBackToAdminErrorState extends ProfileState {}
