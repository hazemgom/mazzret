part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

/// Get Banners
class GetBannersLoadingState extends HomeState {}

class GetBannersSuccessState extends HomeState {}

class GetBannersErrorState extends HomeState {}
class CreateBannersErrorState extends HomeState {}
class CreateBannersSucessState extends HomeState {}
class DeleteBannersSucessState extends HomeState {}
class DeleteBannersErrorState extends HomeState {}

/// Get Specific Banners
class GetSpecificBannersLoadingState extends HomeState {}

class GetSpecificBannersSuccessState extends HomeState {}

class GetSpecificBannersErrorState extends HomeState {}

/// Change Slider Page
class ChangeSliderPage extends HomeState {}

/// Get Category
class GetCategoryLoadingState extends HomeState {}

class GetCategorySuccessState extends HomeState {}

class GetCategoryErrorState extends HomeState {}

/// Search Category
class SearchCategoryLoadingState extends HomeState {}
class SearchCategorySuccessState extends HomeState {}

/// Get All Categories
class GetAllCategoriesLoadingState extends HomeState {}

class GetAllCategoriesSuccessState extends HomeState {}

class GetAllCategoriesErrorState extends HomeState {}

/// Get Specific Categories
class GetSpecificCategoriesLoadingState extends HomeState {}

class GetSpecificCategoriesSuccessState extends HomeState {}

class GetSpecificCategoriesErrorState extends HomeState {}

/// Get Products In Category
class GetProductsInCategoryLoadingState extends HomeState {}

class GetProductsInCategorySuccessState extends HomeState {}

class GetProductsInCategoryErrorState extends HomeState {}

/// Get Product High by Sold
class GetProductHighNySoldLoadingState extends HomeState {}

class GetProductHighNySoldSuccessState extends HomeState {}

class GetProductHighNySoldErrorState extends HomeState {}

/// Get Specific Product
class GetSpecificProductLoadingState extends HomeState {}

class GetSpecificProductSuccessState extends HomeState {}

class GetSpecificProductErrorState extends HomeState {}

/// Search Product
class SearchProductLoadingState extends HomeState {}
class SearchProductSuccessState extends HomeState {}

/// Get All Products
class GetAllProductsLoadingState extends HomeState {}

class GetAllProductsSuccessState extends HomeState {}

class GetAllProductsErrorState extends HomeState {}

/// Add To Cart
class AddToCartLoadingState extends HomeState {}

class AddToCartSuccessState extends HomeState {}

class AddToCartErrorState extends HomeState {}

/// Add Review
class AddReviewLoadingState extends HomeState {}

class AddReviewSuccessState extends HomeState {}

class AddReviewErrorState extends HomeState {}

/// Add To Favorite
class AddToFavoriteLoadingState extends HomeState {}

class AddToFavoriteSuccessState extends HomeState {}

class AddToFavoriteErrorState extends HomeState {}

/// Upload Image To Admin
class UploadImageToAdminLoadingState extends HomeState {}

class UploadImageToAdminSuccessState extends HomeState {}

class UploadImageToAdminErrorState extends HomeState {}