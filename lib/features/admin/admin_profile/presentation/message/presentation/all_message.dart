import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/message/managers/get_all_messages_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';

import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

import 'widget/custom_get_message.dart';

class AllMessage extends StatelessWidget {
  AllMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate(String dateTimeString) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat.yMMMMd().format(dateTime);
    }

    String formattedTime(String dateTimeString) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat.jm().format(dateTime);
    }

    return BlocBuilder<GetAllMessagesCubit, GetAllMessagesState>(
      builder: (context, state) {
        var getAllMessagesFromUsersCubit = GetAllMessagesCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Text(
              AppLocalizations.of(context)!.message,
              style: AppFonts.titleScreen.copyWith(height: 0),
            ),
            centerTitle: true,
          ),
          body: getAllMessagesFromUsersCubit.getAllMessagesModel == null
              ? const Center(
                  child: CustomLoading(),
                )
              : getAllMessagesFromUsersCubit.getAllMessagesModel!.data!.isEmpty
                  ? Center(
                      child: Text(
                        'No messages yet',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w600,
                          fontSize: 22.sp,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 20.h),
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: getAllMessagesFromUsersCubit
                                  .getAllMessagesModel!.data!.length,
                              itemBuilder: (context, index) {
                                var item = getAllMessagesFromUsersCubit
                                    .getAllMessagesModel!.data![index];

                                return CustomGetMessage(
                                  name: item.name!,
                                  message: item.messageContent!,
                                  createdIn: formattedDate(item.createdAt!),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
