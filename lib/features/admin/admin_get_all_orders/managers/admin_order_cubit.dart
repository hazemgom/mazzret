import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/data/models/all_orders_in_model.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/data/models/specifci_order_model.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/remote/dio_helper.dart';
import 'package:mozart_flutter_app/utils/constants/constants.dart';

part 'admin_order_state.dart';

class AdminOrderCubit extends Cubit<AdminOrderState> {
  AdminOrderCubit() : super(AdminOrderInitialState());

  static AdminOrderCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  GetListOfOrdersInAdminAndInManager? getListOfOrdersInAdminAndInManager;
  SpecificOrderModel? specificOrderModel;

  /// Get All Orders In Admin
  Future<void> getAllOrdersInAdminFunction({required String role}) async {
    emit(GetAllOrdersInAdminLoadingState());
    await dioHelper
        .getData(endPoint: '${AppConstants.getAllOrdersUrl}?role=$role')
        .then((response) {
      getListOfOrdersInAdminAndInManager =
          GetListOfOrdersInAdminAndInManager.fromJson(response.data);
      emit(GetAllOrdersInAdminSuccessState());
    }).catchError((error) {
      print('Error in get all orders in Admin is $error');
      emit(GetAllOrdersInAdminErrorState());
    });
  }

  /// Get All Orders In Admin
  Future<void> getSpecificOrderInAdminFunction({
    required String orderId,
  }) async {
    emit(GetSpecificOrderInAdminLoadingState());
    await dioHelper
        .getData(endPoint: 'api/v1/orders/$orderId')
        .then((response) {
      specificOrderModel = SpecificOrderModel.fromJson(response.data);
      emit(GetSpecificOrderInAdminSuccessState());
    }).catchError((error) {
      print('Error in get Specific order in Admin is $error');
      emit(GetSpecificOrderInAdminErrorState());
    });
  }

  /// Get All Orders In Branch (User-Normal)
  Future<void> getAllOrdersInBranchUserNormalFunction({
    required String role,
  }) async {
    emit(GetAllOrdersInBranchUserNormalLoadingState());
    await dioHelper
        .getData(
            endPoint:
                'api/v1/orders/branch?role=$role&branchId=${MyCache.getString(key: CacheKeys.userId)}')
        .then((response) {
      getListOfOrdersInAdminAndInManager =
          GetListOfOrdersInAdminAndInManager.fromJson(response.data);
      emit(GetAllOrdersInBranchUserNormalSuccessState());
    }).catchError((error) {
      print('Error in get All Orders In Branch (User-Normal) is $error');
      emit(GetAllOrdersInBranchUserNormalErrorState());
    });
  }

  /// Get All Orders In Manager
  Future<void> getAllOrdersInManagerFunction({required String branchId}) async {
    emit(GetAllOrdersInManagerLoadingState());
    await dioHelper
        .getData(endPoint: '${AppConstants.getAllOrdersUrl}?branchId=$branchId')
        .then((response) {
      getListOfOrdersInAdminAndInManager =
          GetListOfOrdersInAdminAndInManager.fromJson(response.data);
      emit(GetAllOrdersInManagerSuccessState());
    }).catchError((error) {
      print('Error in get all orders in Manager is $error');
      emit(GetAllOrdersInManagerErrorState());
    });
  }

  Future<void> makeConfirmOrder({required String orderId}) async {
    emit(MakeConfirmOrderLoadingLoadingState());
    await dioHelper
        .putData(endPoint: 'api/v1/orders/$orderId/changeOrderStatus')
        .then((value) {
      emit(MakeConfirmOrderLoadingSuccessState());
    }).catchError((error) {
      emit(MakeConfirmOrderLoadingErrorState());
    });
  }

  /// Change Status Order To Paid
  Future<void> changeStatusOrderToPaidFunction(
      {required String orderId}) async {
    emit(ChangeStatusOrderToPaidLoadingState());
    await dioHelper
        .putData(endPoint: 'api/v1/orders/$orderId/pay')
        .then((response) {
      emit(ChangeStatusOrderToPaidSuccessState());
    }).catchError((error) {
      print('Error in Change Status Order To Paid is $error');
      emit(ChangeStatusOrderToPaidErrorState());
    });
  }

  /// Change Status Order To Delivery
  Future<void> changeStatusOrderToDeliveryFunction(
      {required String orderId}) async {
    emit(ChangeStatusOrderToDeliveryLoadingState());
    await dioHelper
        .putData(endPoint: 'api/v1/orders/$orderId/deliver')
        .then((response) {
      emit(ChangeStatusOrderToDeliverySuccessState());
    }).catchError((error) {
      print('Error in Change Status Order To Delivery is $error');
      emit(ChangeStatusOrderToDeliveryErrorState());
    });
  }
}
