part of 'wishlist_cubit.dart';

@immutable
abstract class WishlistState {}

class WishlistInitialState extends WishlistState {}

/// Get WishList
class GetWishListLoadingState extends WishlistState {}

class GetWishListSuccessState extends WishlistState {}

class GetWishListErrorState extends WishlistState {}

/// Remove From WishList
class RemoveFromWishListLoadingState extends WishlistState {}

class RemoveFromWishListSuccessState extends WishlistState {}

class RemoveFromWishListErrorState extends WishlistState {}
