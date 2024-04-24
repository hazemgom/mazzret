import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/feedback/data/models/get_all_feedbacks_model.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/remote/dio_helper.dart';

part 'get_all_feedbacks_state.dart';

class GetAllFeedbacksCubit extends Cubit<GetAllFeedbacksState> {
  GetAllFeedbacksCubit() : super(GetAllFeedbacksInitialState());

  static GetAllFeedbacksCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  GetAllFeedBacksModel? getAllFeedBacksModel;

  /// Get All FeedBack
  Future<void> getAllFeedBackFunction() async {
    emit(GetAllFeedBackLoadingState());
    await dioHelper.getData(endPoint: 'api/v1/feedback').then((response) {
      getAllFeedBacksModel = GetAllFeedBacksModel.fromJson(response.data);
      if(getAllFeedBacksModel != null) {
        getAllFeedBacksModel!.data?.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      }
      emit(GetAllFeedBackSuccessState());
    }).catchError((error) {
      print('Error in Get All FeedBack in $error');
      emit(GetAllFeedBackErrorState());
    });
  }
}
