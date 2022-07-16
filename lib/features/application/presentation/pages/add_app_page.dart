import 'dart:io';

import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:fcm_notification/core/widgets/k_card.dart';
import 'package:fcm_notification/core/widgets/k_image_container.dart';
import 'package:fcm_notification/core/widgets/k_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/k_fab.dart';

class AddAppPage extends StatefulWidget {
  const AddAppPage({Key? key}) : super(key: key);

  @override
  State<AddAppPage> createState() => _AddAppPageState();
}

class _AddAppPageState extends State<AddAppPage> {
  File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _serverKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: const KAppbar(title: 'New Application'),
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              KCard(
                color: KColors.primary,
                onTap: () {
                  print('tap');
                },
                height: 120.w,
                width: 120.w,
                child: _image != null
                    ? KImageContainer(
                        imageFile: _image,
                        imageType: ImageType.file,
                      )
                    : Icon(
                        Icons.add_photo_alternate_rounded,
                        color: KColors.primary.shade300,
                      ),
              ),
              SizedBox(height: 10.h),
              Text(
                'App Icon',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: KColors.primary.shade300,
                ),
              ),
              SizedBox(height: 30.h),
              KTextField(
                hintText: 'Application Name',
                controller: _nameController,
              ),
              SizedBox(height: 25.h),
              KTextField(
                controller: _serverKeyController,
                hintText: 'Server Key',
                maxLines: 7,
                textInputAction: TextInputAction.send,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: KFab(
        label: 'SAVE',
        icon: Icons.data_saver_on_rounded,
        onPressed: () {
          print('save');
        },
      ),
    );
  }
}
