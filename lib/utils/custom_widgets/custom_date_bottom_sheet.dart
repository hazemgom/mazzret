import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateBottomSheet extends StatefulWidget {
  final DateTime minimumDate;
  final DateTime maximumDate;

  const DateBottomSheet({
    super.key,
    required this.minimumDate,
    required this.maximumDate,
  });

  @override
  State<DateBottomSheet> createState() => _DateBottomSheetState();
}

class _DateBottomSheetState extends State<DateBottomSheet> {
  DateTime? dateTime;

  @override
  void initState() {
    dateTime = widget.minimumDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Done",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              initialDateTime: dateTime,
              mode: CupertinoDatePickerMode.date,
              minimumDate: widget.minimumDate,
              maximumDate: widget.maximumDate,
              onDateTimeChanged: (date) {
                setState(() {
                  dateTime = date;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}