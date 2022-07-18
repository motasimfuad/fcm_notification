import 'dart:io';
import 'dart:typed_data';

import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/constants/strings.dart';
import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:fcm_notification/core/widgets/k_card.dart';
import 'package:fcm_notification/core/widgets/k_image_container.dart';
import 'package:fcm_notification/core/widgets/k_textfield.dart';
import 'package:fcm_notification/features/application/data/models/app_model.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

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

  late Box<AppEntity> appBox;

  @override
  void initState() {
    appBox = Hive.box<AppEntity>(Strings.appBox);
    super.initState();
  }

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
                  print("App box - ${appBox.values}");
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
        onPressed: () async {
          //! for testing
          var image = await _image?.readAsBytes();
          var appEntity = AppEntity(
            id: const Uuid().v1(),
            name: _nameController.text,
            serverKey: _serverKeyController.text,
            icon: image ?? Uint8List(0),
            createdAt: DateTime.now(),
          );
          var appModel = AppModel(
            id: appEntity.id,
            name: appEntity.name,
            serverKey: appEntity.serverKey,
            icon: appEntity.icon,
            createdAt: appEntity.createdAt,
          );
          var added = await appBox.add(appModel);

          // print('added $added');

          // await appBox.delete(appModel.id);
          print('save');
        },
      ),
    );
  }
}
