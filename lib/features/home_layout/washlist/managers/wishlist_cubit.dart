import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/remote/dio_helper.dart';
import 'package:mozart_flutter_app/features/home_layout/washlist/data/models/wishlist_model.dart';
import 'package:mozart_flutter_app/utils/constants/constants.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitialState());

  static WishlistCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  WishListModel? wishListModel;

  /// Get List WishList
  Future<void> getWishListFunction() async {
    emit(GetWishListLoadingState());
    await dioHelper
        .getData(endPoint: AppConstants.getWishListUrl)
        .then((response) {
      wishListModel = WishListModel.fromJson(response.data);
      emit(GetWishListSuccessState());
    }).catchError((error) {
      print('Get wishlist is ${error}');
      emit(GetWishListErrorState());
    });
  }

  /// Remove From WishList
  Future<void> removeFromWishList({required String productId}) async {
    emit(RemoveFromWishListLoadingState());
    await dioHelper
        .deleteData(
            endPoint:
                '${AppConstants.removeFromWishListUrl}$productId')
        .then((response) {
      emit(RemoveFromWishListSuccessState());
    }).catchError((error) {
      print('Error in Remove From WishList is $error');
      emit(RemoveFromWishListErrorState());
    });
  }
}
