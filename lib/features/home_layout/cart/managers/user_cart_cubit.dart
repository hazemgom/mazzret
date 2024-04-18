import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/remote/dio_helper.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/data/models/address.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/data/models/addresses_model.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/data/models/get_all_branches.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/data/models/user_cart_model.dart';
import 'package:mozart_flutter_app/utils/constants/constants.dart';

part 'user_cart_state.dart';

class UserCartCubit extends Cubit<UserCartState> {
  UserCartCubit() : super(UserCartInitialState());

  static UserCartCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

String? newPosition;
  UserCartModel? userCartModel;
  AddressesModel? addressesModel;
  GetAllBranches? getAllBranches;
  AddressDataModel addressDataModel = AddressDataModel();

  /// Get All User Cart
  Future<void> getAllUserCartFunction() async {
    emit(GetAllUserCartLoadingState());
    await dioHelper
        .getData(endPoint: AppConstants.getAllUserCartUrl)
        .then((response) {
      userCartModel = UserCartModel.fromJson(response.data);
      emit(GetAllUserCartSuccessState());
    }).catchError((error) {
      print('Get All User Cart error in $error');
      emit(GetAllUserCartErrorState());
    });
  }

  /// Update User Cart
  Future<void> updateUserCartFunction(
      {required String productId, required int quantity}) async {
    emit(UpdateUserCartLoadingState());
    await dioHelper.putData(
        endPoint:
            '${AppConstants.deleteOneAndUpdateProductFromUserCartUrl}$productId',
        body: {
          "quantity": quantity,
        }).then((value) {
      emit(UpdateUserCartSuccessState());
    }).catchError((error) {
      print('Error in update user cart is $error');
      emit(UpdateUserCartErrorState());
    });
  }

  /// Delete One Product From Cart
  Future<void> deleteOnProductFromCart({required String cartId}) async {
    emit(DeleteOneProductFromCartLoadingState());
    print('After Load');
    await dioHelper
        .deleteData(
            endPoint:
                '${AppConstants.deleteOneAndUpdateProductFromUserCartUrl}$cartId')
        .then((response) {
      emit(DeleteOneProductFromCartSuccessState());
    }).catchError((error) {
      print('Delete error in one product is $error');
      emit(DeleteOneProductFromCartErrorState());
    });
  }

  /// Delete One Product From Cart
  Future<void> deleteAllProductsFromCart() async {
    emit(DeleteAllProductsFromCartLoadingState());
    await dioHelper
        .deleteData(endPoint: AppConstants.getAllUserCartUrl)
        .then((response) {
      emit(DeleteAllProductsFromCartSuccessState());
    }).catchError((error) {
      print('Delete error in one product is $error');
      emit(DeleteAllProductsFromCartErrorState());
    });
  }

  // /// Get User Addresses
  // Future<void> getUserAddresses() async {
  //   emit(GetAllUserCartLoadingState());
  //   await dioHelper
  //       .getData(endPoint: AppConstants.getUserAddressesUrl)
  //       .then((response) {
  //     addressesModel = AddressesModel.fromJson(response.data);
  //     emit(GetUserAddressesSuccessState());
  //   }).catchError((error) {
  //     print('Error in get user addresses in $error');
  //     emit(GetUserAddressesErrorState());
  //   });
  // }

  /// Get All Branches
  Future<void> getAllUsersFunction({required String role}) async {
    emit(GetAllBranchesLoadingState());
    await dioHelper
        .getData(endPoint: '${AppConstants.getAllBranchesUrl}?role=$role')
        .then((response) {
      getAllBranches = GetAllBranches.fromJson(response.data);
      emit(GetAllBranchesSuccessState());
    }).catchError((error) {
      print('Error in get All Users is $error');
      emit(GetAllBranchesErrorState());
    });
  }

  Future<void> addOrderFunction(
      {required String cartId, required String branchId}) async {
    emit(AddOrderLoadingState());
    await dioHelper
        .postData(endPoint: '${AppConstants.addOrderUrl}$cartId', body: {
      'branchId': branchId,
    }).then((response) {
      emit(AddOrderSuccessState());
    }).catchError((error) {
      print('Add Order error in $error');
      emit(AddOrderErrorState());
    });
  }

  // Future<void> getMyOrdersFunction()
}
