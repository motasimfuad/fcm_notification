import 'package:fcm_notification/core/constants/constants.dart';
import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:fcm_notification/core/widgets/k_card.dart';
import 'package:fcm_notification/core/widgets/k_image_container.dart';
import 'package:fcm_notification/core/widgets/k_radio_tile.dart';
import 'package:fcm_notification/core/widgets/k_snack_bar.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/application/presentation/bloc/application_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/k_fab.dart';
import '../../../../core/widgets/k_textfield.dart';

class AddAppPage extends StatefulWidget {
  final String? id;
  const AddAppPage({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<AddAppPage> createState() => _AddAppPageState();
}

class _AddAppPageState extends State<AddAppPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isUpdating = false;
  FcmApiType fcmApiType = FcmApiType.v1;

  String? _iconName;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _serverKeyController = TextEditingController();
  AppEntity? _stateApp;

  bool? hasImage = true;

  @override
  void initState() {
    isUpdating = widget.id != null;

    if (widget.id != null) {
      context.read<ApplicationBloc>().add(GetAppEvent(widget.id!));
    }
    super.initState();
  }

  void _changeApiType(FcmApiType type) {
    setState(() {
      fcmApiType = type;
      if (!isUpdating) {
        _serverKeyController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar:
          KAppbar(title: (isUpdating) ? "Edit Application" : 'New Application'),
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
              if (isUpdating) {
                if (state is AppLoaded) {
                  _stateApp = state.app;

                  _nameController.text = _stateApp?.name ?? '';
                  _serverKeyController.text = _stateApp?.serverKey ?? '';
                  _iconName = _stateApp?.iconName;
                  fcmApiType = _stateApp?.apiType ?? FcmApiType.legacy;
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
                    KCard(
                      color: KColors.primary,
                      xPadding: 15.w,
                      borderColor: Colors.red,
                      borderWidth: 1.w,
                      child: Column(
                        children: [
                          if (!isUpdating ||
                              (isUpdating && fcmApiType == FcmApiType.v1))
                            KRadioTile(
                              value: FcmApiType.v1,
                              groupValue: fcmApiType,
                              title: 'V1 API',
                              subtitle: 'Firebase Cloud Messaging API (V1)',
                              icon: Icons.security_outlined,
                              onChanged: <FcmApiType>(val) =>
                                  _changeApiType(val),
                            ),
                          if (!isUpdating ||
                              (isUpdating && fcmApiType == FcmApiType.legacy))
                            KRadioTile(
                              value: FcmApiType.legacy,
                              groupValue: fcmApiType,
                              title: 'Legacy API (Deprecated)',
                              subtitle: 'Cloud Messaging API (Legacy)',
                              icon: Icons.shield_moon_rounded,
                              onChanged: <FcmApiType>(val) =>
                                  _changeApiType(val),
                            ),
                          SizedBox(height: 15.h),
                          KTextField(
                            bottomPadding: 5.h,
                            controller: _serverKeyController,
                            bgColor: KColors.background,
                            hintText: fcmApiType == FcmApiType.v1
                                ? Strings.fcmTypeV1Hint
                                : Strings.fcmTypeLegacyHint,
                            maxLines: 9,
                            textInputAction: TextInputAction.send,
                            validator: (value) {
                              if (_serverKeyController.text.trim().isEmpty) {
                                return 'Key is required';
                              }
                              if (fcmApiType == FcmApiType.v1 &&
                                  !_serverKeyController.text.trim().isJson) {
                                return 'Please add a valid JSON service account key';
                              }
                              return null;
                            },
                          ),
                          if (!isUpdating)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: RichText(
                                text: TextSpan(
                                  text: "You",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: KColors.primaryLight,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: " can't change ",
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w500,
                                        color: KColors.danger,
                                      ),
                                    ),
                                    TextSpan(text: 'the API type later.'),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: KFab(
        label: (isUpdating) ? 'UPDATE' : 'SAVE',
        icon: Icons.data_saver_on_rounded,
        onPressed: () async {
          var isValid = _formKey.currentState!.validate();
          setState(() {
            hasImage = (_iconName == null) ? false : true;
          });
          if (isValid && hasImage == true) {
            if (isUpdating) {
              // update app
              AppEntity updateAppEntity = AppEntity(
                id: _stateApp!.id,
                name: _nameController.text,
                serverKey: _serverKeyController.text,
                iconName: _iconName,
                createdAt: _stateApp!.createdAt,
                notifications: _stateApp!.notifications,
                apiType: fcmApiType,
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
                apiType: fcmApiType,
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
