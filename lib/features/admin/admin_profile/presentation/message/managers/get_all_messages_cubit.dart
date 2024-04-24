import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/message/data/models/all_messages_model.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/remote/dio_helper.dart';

part 'get_all_messages_state.dart';

class GetAllMessagesCubit extends Cubit<GetAllMessagesState> {
  GetAllMessagesCubit() : super(GetAllMessagesInitialState());

  static GetAllMessagesCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  GetAllMessagesModel? getAllMessagesModel;

  /// Get All Messages From Users
  Future<void> getAllMessagesFromUserFunction() async {
    emit(GetAllMessagesFromUsersLoadingState());
    await dioHelper.getData(endPoint: 'api/v1/message').then((response) {
      getAllMessagesModel = GetAllMessagesModel.fromJson(response.data);
      if(getAllMessagesModel != null) {
        getAllMessagesModel!.data?.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      }
      emit(GetAllMessagesFromUsersSuccessState());
    }).catchError((error) {
      print('Error in Get All Messages From Users in $error');
      emit(GetAllMessagesFromUsersErrorState());
    });
  }
}
