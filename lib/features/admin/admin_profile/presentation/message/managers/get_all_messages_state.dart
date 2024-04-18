part of 'get_all_messages_cubit.dart';

@immutable
abstract class GetAllMessagesState {}

class GetAllMessagesInitialState extends GetAllMessagesState {}

/// Get All Messages From Users
class GetAllMessagesFromUsersLoadingState extends GetAllMessagesState {}

class GetAllMessagesFromUsersSuccessState extends GetAllMessagesState {}

class GetAllMessagesFromUsersErrorState extends GetAllMessagesState {}
