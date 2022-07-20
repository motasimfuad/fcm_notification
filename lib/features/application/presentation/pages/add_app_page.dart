import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import 'package:fcm_notification/core/constants/colors.dart';
import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:fcm_notification/core/widgets/k_card.dart';
import 'package:fcm_notification/core/widgets/k_image_container.dart';
import 'package:fcm_notification/core/widgets/k_snack_bar.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/application/presentation/bloc/application_bloc.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/k_fab.dart';
import '../../../../core/widgets/k_textfield.dart';

class AddAppPage extends StatefulWidget {
  String? id;
  AddAppPage({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<AddAppPage> createState() => _AddAppPageState();
}

class _AddAppPageState extends State<AddAppPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _iconName;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _serverKeyController = TextEditingController();

  AppEntity? _stateApp;

  bool? hasImage = true;

  @override
  void initState() {
    if (widget.id != null) {
      context.read<ApplicationBloc>().add(GetAppEvent(widget.id!));
    }
    super.initState();
  }

  @override
  void dispose() {
    // widget.id = null;
    // _nameController.dispose();
    // _serverKeyController.dispose();
    // _iconName = null;
    // _stateApp = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: KAppbar(
          title: (widget.id != null) ? "Edit Application" : 'New Application'),
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: BlocConsumer<ApplicationBloc, ApplicationState>(
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
              if (state is AppUpdatedState) {
                kSnackBar(
                  context: context,
                  message: 'App updated successfully',
                  type: AlertType.success,
                );

                context.read<ApplicationBloc>().add(GetAllAppsEvent());
                router.goNamed(AppRouter.homePage);
              }
            },
            builder: (context, state) {
              if (widget.id != null) {
                if (state is AppLoaded) {
                  _stateApp = state.app;

                  _nameController.text = _stateApp?.name ?? '';
                  _serverKeyController.text = _stateApp?.serverKey ?? '';
                  _iconName = _stateApp?.iconName;
                }
              }
              if (state is AppIconAddedState) {
                _iconName = state.iconName;
              }

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    KCard(
                      color: KColors.primary,
                      hasBorder: hasImage == true ? false : true,
                      borderColor: Colors.red,
                      borderWidth: 1.w,
                      onTap: () {
                        context.read<ApplicationBloc>().add(AddAppIconEvent());
                      },
                      height: 120.w,
                      width: 120.w,
                      child: _iconName != null
                          ? KImageContainer(
                              imageUrl: _iconName,
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
                      hintText: 'Application Name *',
                      controller: _nameController,
                      validator: (value) {
                        if (_nameController.text.trim().isEmpty) {
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
                        if (_serverKeyController.text.trim().isEmpty) {
                          return 'Server Key is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: KFab(
        label: (widget.id != null) ? 'UPDATE' : 'SAVE',
        icon: Icons.data_saver_on_rounded,
        onPressed: () async {
          var isValid = _formKey.currentState!.validate();
          setState(() {
            hasImage = (_iconName == null) ? false : true;
          });
          if (isValid && hasImage == true) {
            if (widget.id != null) {
              // update app
              AppEntity updateAppEntity = AppEntity(
                id: _stateApp!.id,
                name: _nameController.text,
                serverKey: _serverKeyController.text,
                iconName: _iconName,
                createdAt: _stateApp!.createdAt,
                notifications: _stateApp!.notifications,
              );
              context
                  .read<ApplicationBloc>()
                  .add(UpdateAppEvent(updateAppEntity));
            } else {
              // create app
              AppEntity createAppEntity = AppEntity(
                id: const Uuid().v1(),
                name: _nameController.text,
                serverKey: _serverKeyController.text,
                iconName: _iconName,
                createdAt: DateTime.now(),
              );
              context
                  .read<ApplicationBloc>()
                  .add(CreateAppEvent(createAppEntity));
            }
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
