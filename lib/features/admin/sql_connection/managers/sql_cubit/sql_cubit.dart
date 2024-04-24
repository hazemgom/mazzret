import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:mozart_flutter_app/features/admin/sql_connection/data/data_provider/remote/dio_helper.dart';
import 'package:mozart_flutter_app/features/admin/sql_connection/utils/constants/constants.dart';

part 'sql_state.dart';

class SqlCubit extends Cubit<SqlState> {
  SqlCubit() : super(SqlInitialState());

  static SqlCubit get(context) => BlocProvider.of(context);

  SqlDioHelper sqlDioHelper = SqlDioHelper();

  /// Sql Function
  Future<void> sqlFunction({
    String? user,
    String? password,
    String? server,
    String? database,
    required String syncMethod,
    String? syncTime,
    DateTime? startTime,
    DateTime? endTime,
    int? syncInterval,
    required bool wantSync,
  }) async {
    emit(SqlLoadingState());
    try {
      final dio = Dio();
      final data = {
        "user": user ?? "sa",
        "password": password ?? "sql2001",
        "server": server ?? "DESKTOP-NDRHRIF",
        "database": database ?? "OnlineStore",
        "syncMethod": syncMethod,
        "wantSync": true,
      };

      if (syncMethod == 'once') {

        data['syncTime'] = syncTime ?? DateFormat('h:mm a').format(DateTime.now());
      } else if (syncMethod == 'periodic') {

        data['startTime'] = DateFormat('h:mm a').format(startTime!);
        data['endTime'] = DateFormat('h:mm a').format(endTime!);
        data['syncInterval'] = syncInterval ?? 1;
      }

      final response = await dio.post(
        'https://onlinestore-xors.onrender.com/api/v1/configureAndSync/configure-sync',
        data: data,
      );

      if (response.statusCode == 200) {
        print(response.data);
        emit(SqlSuccessState());
      } else {
        print('A network error occurred');
        emit(SqlErrorState());
      }
    } catch (error) {
      print(error);
      emit(SqlErrorState());
    }
  }




}
