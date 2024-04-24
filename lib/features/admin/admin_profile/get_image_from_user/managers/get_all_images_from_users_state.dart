part of 'get_all_images_from_users_cubit.dart';

@immutable
abstract class GetAllImagesFromUsersState {}

class GetAllImagesFromUsersInitialState extends GetAllImagesFromUsersState {}

/// Get All Images From Users
class GetAllImagesFromUsersLoadingState extends GetAllImagesFromUsersState {}

class GetAllImagesFromUsersSuccessState extends GetAllImagesFromUsersState {}

class GetAllImagesFromUsersErrorState extends GetAllImagesFromUsersState {}
