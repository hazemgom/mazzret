import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';

class CustomTimeInBottomSheet extends StatefulWidget {
  CustomTimeInBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomTimeInBottomSheet> createState() => _CustomTimeInBottomSheetState();
}
class _CustomTimeInBottomSheetState extends State<CustomTimeInBottomSheet> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.transparent
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [

          hourMinute12H(),
        ],
      ),
    );
  }
  Widget hourMinute12H() {
    return TimePickerSpinner(
      highlightedTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.primaryColor),
      normalTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
      spacing: 1,
      is24HourMode: false,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}