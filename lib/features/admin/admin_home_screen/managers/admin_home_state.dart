part of 'admin_home_cubit.dart';

@immutable
abstract class AdminHomeState {}

class AdminHomeInitialState extends AdminHomeState {}

/// ---------------------------------- Banner ---------------------------------- ///

/// Create Banner
class CreateBannerLoadingState extends AdminHomeState {}

class CreateBannerSuccessState extends AdminHomeState {}

class CreateBannerErrorState extends AdminHomeState {}

/// Delete All Images in Banner
class DeleteAllImagesInBannerLoadingState extends AdminHomeState {}

class DeleteAllImagesInBannerSuccessState extends AdminHomeState {}

class DeleteAllImagesInBannerErrorState extends AdminHomeState {}

/// Update Image in Banner
class UpdateImageInBannerLoadingState extends AdminHomeState {}

class UpdateImageInBannerSuccessState extends AdminHomeState {}

class UpdateImageInBannerErrorState extends AdminHomeState {}

/// Delete One Image In Banner
class DeleteOneImageInBannerLoadingState extends AdminHomeState {}

class DeleteOneImageInBannerSuccessState extends AdminHomeState {}

class DeleteOneImageInBannerErrorState extends AdminHomeState {}

/// ---------------------------------- Category ---------------------------------- ///
/// Create Category
class CreateCategoryLoadingState extends AdminHomeState {}

class CreateCategorySuccessState extends AdminHomeState {}

class CreateCategoryErrorState extends AdminHomeState {}

/// Update Image Of Category
class UpdateImagesOfCategoryLoadingState extends AdminHomeState {}

class UpdateImagesOfCategorySuccessState extends AdminHomeState {}

class UpdateImagesOfCategoryErrorState extends AdminHomeState {}

/// Update Image Of Category
class UpdateImageOfCategoryLoadingState extends AdminHomeState {}

class UpdateImageOfCategorySuccessState extends AdminHomeState {}

class UpdateImageOfCategoryErrorState extends AdminHomeState {}

/// Delete Category
class DeleteCategoryLoadingState extends AdminHomeState {}

class DeleteCategorySuccessState extends AdminHomeState {}

class DeleteCategoryErrorState extends AdminHomeState {}

/// ---------------------------------- Product ---------------------------------- ///
class CreateProductLoadingState extends AdminHomeState {}

class CreateProductSuccessState extends AdminHomeState {}

class CreateProductErrorState extends AdminHomeState {}

/// Edit Specific Product
class EditSpecificProductLoadingState extends AdminHomeState {}

class EditSpecificProductSuccessState extends AdminHomeState {}

class EditSpecificProductErrorState extends AdminHomeState {}

/// Delete One Product
class DeleteOneProductLoadingState extends AdminHomeState {}

class DeleteOneProductSuccessState extends AdminHomeState {}

class DeleteOneProductErrorState extends AdminHomeState {}