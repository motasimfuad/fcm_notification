import 'dart:io';
import 'dart:typed_data';

import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:fcm_notification/core/widgets/k_card.dart';
import 'package:fcm_notification/core/widgets/k_image_container.dart';
import 'package:fcm_notification/core/widgets/k_snack_bar.dart';
import 'package:fcm_notification/core/widgets/k_textfield.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/application/presentation/bloc/application_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/k_fab.dart';

class AddAppPage extends StatefulWidget {
  const AddAppPage({Key? key}) : super(key: key);

  @override
  State<AddAppPage> createState() => _AddAppPageState();
}

class _AddAppPageState extends State<AddAppPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _image;

  Uint8List? convertedIcon;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _serverKeyController = TextEditingController();

  bool? hasImage = true;

  @override
  void initState() {
    super.initState();
  }

  // convertImageFile(File? imageFile) async {
  //   if (imageFile == null) {
  //     return;
  //   } else {
  //     convertedIcon = await imageFile.readAsBytes();
  //     print('convertedIcon: $convertedIcon');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: const KAppbar(title: 'New Application'),
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                BlocConsumer<ApplicationBloc, ApplicationState>(
                  listener: (context, state) {
                    if (state is AppCreatedState) {
                      kSnackBar(
                        context: context,
                        message: 'App created successfully',
                        type: AlertType.success,
                      );

                      context.read<ApplicationBloc>().add(GetAllAppsEvent());
                      router.goNamed(AppRouter.homePage);
                    }
                  },
                  builder: (context, state) {
                    if (state is AppIconAddedState) {
                      _image = state.iconFile;
                      convertedIcon = state.convertedIcon;
                    }

                    return KCard(
                      color: KColors.primary,
                      hasBorder: hasImage == true ? false : true,
                      borderColor: Colors.red,
                      borderWidth: 1.w,
                      onTap: () {
                        context.read<ApplicationBloc>().add(AddAppIconEvent());
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
                    );
                  },
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
                  hintText: 'Application Name *',
                  controller: _nameController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Application name is required';
                    }
                    return null;
                  },
                ),
                KTextField(
                  controller: _serverKeyController,
                  hintText: 'Server Key *',
                  maxLines: 7,
                  textInputAction: TextInputAction.send,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Server Key is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: KFab(
        label: 'SAVE',
        icon: Icons.data_saver_on_rounded,
        onPressed: () async {
          var isValid = _formKey.currentState!.validate();
          setState(() {
            hasImage = (_image == null) ? false : true;
          });
          if (isValid) {
            var appEntity = AppEntity(
              id: const Uuid().v1(),
              name: _nameController.text,
              serverKey: _serverKeyController.text,
              icon: convertedIcon,
              createdAt: DateTime.now(),
            );
            context.read<ApplicationBloc>().add(CreateAppEvent(appEntity));
          } else {
            kSnackBar(
              context: context,
              message: 'Please fill all the required fields!',
              type: AlertType.failed,
            );
          }
        },
      ),
    );
  }
}
