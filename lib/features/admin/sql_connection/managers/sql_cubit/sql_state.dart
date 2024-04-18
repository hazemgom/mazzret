part of 'sql_cubit.dart';

@immutable
abstract class SqlState {}

class SqlInitialState extends SqlState {}

class SqlLoadingState extends SqlState {}

class SqlSuccessState extends SqlState {}

class SqlErrorState extends SqlState {}
