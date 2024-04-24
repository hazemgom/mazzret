part of 'admin_order_cubit.dart';

@immutable
abstract class AdminOrderState {}

class AdminOrderInitialState extends AdminOrderState {}

/// Get All Orders In Admin
class GetAllOrdersInAdminLoadingState extends AdminOrderState {}

class GetAllOrdersInAdminSuccessState extends AdminOrderState {}

class GetAllOrdersInAdminErrorState extends AdminOrderState {}

/// Get Specific Orders In Admin
class GetSpecificOrderInAdminLoadingState extends AdminOrderState {}

class GetSpecificOrderInAdminSuccessState extends AdminOrderState {}

class GetSpecificOrderInAdminErrorState extends AdminOrderState {}

/// Get All Orders In Branch (User-Normal)
class GetAllOrdersInBranchUserNormalLoadingState extends AdminOrderState {}

class GetAllOrdersInBranchUserNormalSuccessState extends AdminOrderState {}

class GetAllOrdersInBranchUserNormalErrorState extends AdminOrderState {}

/// Get All Orders In Manager
class GetAllOrdersInManagerLoadingState extends AdminOrderState {}

class GetAllOrdersInManagerSuccessState extends AdminOrderState {}

class GetAllOrdersInManagerErrorState extends AdminOrderState {}

/// Make Confirm Order
class MakeConfirmOrderLoadingLoadingState extends AdminOrderState {}

class MakeConfirmOrderLoadingSuccessState extends AdminOrderState {}

class MakeConfirmOrderLoadingErrorState extends AdminOrderState {}

/// Change Status Order To Paid
class ChangeStatusOrderToPaidLoadingState extends AdminOrderState {}

class ChangeStatusOrderToPaidSuccessState extends AdminOrderState {}

class ChangeStatusOrderToPaidErrorState extends AdminOrderState {}

/// Change Status Order To Delivery
class ChangeStatusOrderToDeliveryLoadingState extends AdminOrderState {}

class ChangeStatusOrderToDeliverySuccessState extends AdminOrderState {}

class ChangeStatusOrderToDeliveryErrorState extends AdminOrderState {}
