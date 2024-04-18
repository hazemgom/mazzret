import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/get_image_from_user/data/models/get_all_images_from_user.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/remote/dio_helper.dart';

part 'get_all_images_from_users_state.dart';

class GetAllImagesFromUsersCubit extends Cubit<GetAllImagesFromUsersState> {
  GetAllImagesFromUsersCubit() : super(GetAllImagesFromUsersInitialState());

  static GetAllImagesFromUsersCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  GetAllImagesFromUserModel? getAllImagesFromUserModel;

  /// Get All Images From Users
  Future<void> getAllImagesFromUserFunction() async {
    emit(GetAllImagesFromUsersLoadingState());
    await dioHelper.getData(endPoint: 'api/v1/uploadImage').then((response) {
      getAllImagesFromUserModel =
          GetAllImagesFromUserModel.fromJson(response.data);
      if(getAllImagesFromUserModel != null) {
        getAllImagesFromUserModel!.data?.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      }
      emit(GetAllImagesFromUsersSuccessState());
    }).catchError((error) {
      print('Error in Get All Images From Users in $error');
      emit(GetAllImagesFromUsersErrorState());
    });
  }
}
