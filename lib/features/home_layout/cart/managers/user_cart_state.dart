part of 'user_cart_cubit.dart';

@immutable
abstract class UserCartState {}

class UserCartInitialState extends UserCartState {}

/// Get All User Cart
class GetAllUserCartLoadingState extends UserCartState {}

class GetAllUserCartSuccessState extends UserCartState {}

class GetAllUserCartErrorState extends UserCartState {}

/// Update User Cart
class UpdateUserCartLoadingState extends UserCartState {}

class UpdateUserCartSuccessState extends UserCartState {}

class UpdateUserCartErrorState extends UserCartState {}

/// Delete One Product From Cart
class DeleteOneProductFromCartLoadingState extends UserCartState {}

class DeleteOneProductFromCartSuccessState extends UserCartState {}

class DeleteOneProductFromCartErrorState extends UserCartState {}

/// Delete All Products From Cart
class DeleteAllProductsFromCartLoadingState extends UserCartState {}

class DeleteAllProductsFromCartSuccessState extends UserCartState {}

class DeleteAllProductsFromCartErrorState extends UserCartState {}

/// Get All Branches
class GetAllBranchesLoadingState extends UserCartState {}

class GetAllBranchesSuccessState extends UserCartState {}

class GetAllBranchesErrorState extends UserCartState {}

/// Add Order
class AddOrderLoadingState extends UserCartState {}

class AddOrderSuccessState extends UserCartState {}

class AddOrderErrorState extends UserCartState {}
