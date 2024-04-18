part of 'get_all_users_cubit.dart';

@immutable
abstract class GetAllUsersState {}

class GetAllUsersInitialState extends GetAllUsersState {}

/// ---------------------------------- User ---------------------------------- ///

/// Add New Admin Or Manager
class AddNewManagerOrAdminLoadingState extends GetAllUsersState {}

class AddNewManagerOrAdminSuccessState extends GetAllUsersState {}

class AddNewManagerOrAdminErrorState extends GetAllUsersState {}

/// Delete One Admin Or Manager
class DeleteOneAdminOrManagerLoadingState extends GetAllUsersState {}

class DeleteOneAdminOrManagerSuccessState extends GetAllUsersState {}

class DeleteOneAdminOrManagerErrorState extends GetAllUsersState {}

/// Get All Users
class GetAllUsersLoadingState extends GetAllUsersState {}

class GetAllUsersSuccessState extends GetAllUsersState {}

class GetAllUsersErrorState extends GetAllUsersState {}

/// Get Specific User
class GetSpecificUserLoadingState extends GetAllUsersState {}

class GetSpecificUserSuccessState extends GetAllUsersState {}

class GetSpecificUserErrorState extends GetAllUsersState {}

/// Update Specific User
class UpdateSpecificUserLoadingState extends GetAllUsersState {}

class UpdateSpecificUserSuccessState extends GetAllUsersState {}

class UpdateSpecificUserErrorState extends GetAllUsersState {}

/// Delete Specific User
class DeleteSpecificUserLoadingState extends GetAllUsersState {}

class DeleteSpecificUserSuccessState extends GetAllUsersState {}

class DeleteSpecificUserErrorState extends GetAllUsersState {}

/// ---------------------------------- Admin ---------------------------------- ///

/// Get All Admins
class GetAllAdminsLoadingState extends GetAllUsersState {}

class GetAllAdminsSuccessState extends GetAllUsersState {}

class GetAllAdminsErrorState extends GetAllUsersState {}

/// ---------------------------------- Manager ---------------------------------- ///

/// Get All Managers
class GetAllManagersLoadingState extends GetAllUsersState {}

class GetAllManagersSuccessState extends GetAllUsersState {}

class GetAllManagersErrorState extends GetAllUsersState {}

/// Delete One Review
class DeleteOneReviewLoadingState extends GetAllUsersState {}

class DeleteOneReviewSuccessState extends GetAllUsersState {}

class DeleteOneReviewErrorState extends GetAllUsersState {}

/// Make User Activate
class MakeUserActivateLoadingState extends GetAllUsersState {}

class MakeUserActivateSuccessState extends GetAllUsersState {}

class MakeUserActivateErrorState extends GetAllUsersState {}
