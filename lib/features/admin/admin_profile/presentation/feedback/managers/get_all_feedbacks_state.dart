part of 'get_all_feedbacks_cubit.dart';

@immutable
abstract class GetAllFeedbacksState {}

class GetAllFeedbacksInitialState extends GetAllFeedbacksState {}

/// Get All FeedBack
class GetAllFeedBackLoadingState extends GetAllFeedbacksState {}

class GetAllFeedBackSuccessState extends GetAllFeedbacksState {}

class GetAllFeedBackErrorState extends GetAllFeedbacksState {}
