import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_layout.dart';
import 'package:mozart_flutter_app/features/admin/sql_connection/managers/sql_cubit/sql_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';

class ChoiceScreenAfterSQLConnection extends StatefulWidget {
  ChoiceScreenAfterSQLConnection({
    required this.user,
    required this.password,
    required this.server,
    required this.database,
  });
  final String user;
  final String password;
  final String server;
  final String database;

  @override
  State<ChoiceScreenAfterSQLConnection> createState() =>
      _ChoiceScreenAfterSQLConnectionState();
}

class _ChoiceScreenAfterSQLConnectionState
    extends State<ChoiceScreenAfterSQLConnection> {
  String? _dropDownValue1 = 'once';
  DateTime? startTime;
  DateTime? endTime;
  int? _syncInterval;

  final TextEditingController _syncIntervalController = TextEditingController();

  Widget startTimePicker() {
    return ElevatedButton(
      onPressed: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            startTime = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              pickedTime.hour,
              pickedTime.minute,
            );
          });
        }
      },
      child: Text(
        startTime != null
            ? 'Start Time: ${startTime!.hour}:${startTime!.minute}'
            : 'Select Start Time',
      ),
    );
  }

  Widget endTimePicker() {
    return ElevatedButton(
      onPressed: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            endTime = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              pickedTime.hour,
              pickedTime.minute,
            );
          });
        }
      },
      child: Text(
        endTime != null
            ? 'End Time: ${endTime!.hour}:${endTime!.minute}'
            : 'Select End Time',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Schedule Synchronization',
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => SqlCubit(),
        child: BlocConsumer<SqlCubit, SqlState>(
          listener: (context, state) {
            if (state is SqlSuccessState) {
              CustomSnackBar.showMessage(
                context,
                message: 'تمت الحفظ بنجاح',
                messageColor: Colors.green,
              );
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomeLayout()),
                      (route) => false);
            }
          },
          builder: (context, state) {
            var sqlCubit = SqlCubit.get(context);

            return Directionality(
              textDirection: TextDirection.ltr,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      DropdownButton<String>(
                        hint: Text(
                          'Select Synchronization Method',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        value: _dropDownValue1,
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropDownValue1 = newValue;
                            startTime = null;
                            endTime = null;
                          });
                        },
                        items: ['now', 'once', 'periodic']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      if (_dropDownValue1 == 'once') ...[
                        startTimePicker(),
                      ] else if (_dropDownValue1 == 'periodic') ...[
                        startTimePicker(),
                        endTimePicker(),
                        SizedBox(height: 20.h),
                        TextFormField(
                          controller: _syncIntervalController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter Synchronization Interval',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _syncInterval = int.tryParse(value);
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter synchronization interval';
                            }
                            return null;
                          },
                        ),
                      ],
                      SizedBox(height: 20.h),
                      CustomButtonWidget(
                        onPressed: () {
                          sqlCubit.sqlFunction(
                            user: widget.user,
                            password: widget.password,
                            server: widget.server,
                            database: widget.database,
                            endTime: endTime,

                            startTime: startTime,
                            syncMethod: _dropDownValue1.toString(),
                            syncTime: _dropDownValue1 == 'now'
                                ? DateTime.now().toString()
                                : DateTime.now().toString(),
                            syncInterval: _syncInterval,
                            wantSync: true,
                          );
                          print(_dropDownValue1.toString());
                          print(startTime);
                          print(endTime);
                          print(_syncInterval);
                        },
                        borderRadius: 10.r,
                        text: AppLocalizations.of(context)!.save,
                        width: 335.w,
                        height: 49.h,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
