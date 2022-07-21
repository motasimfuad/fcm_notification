import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fcm_notification/core/constants/enums.dart';
import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:fcm_notification/core/widgets/k_card.dart';
import 'package:fcm_notification/core/widgets/k_radio_tile.dart';
import 'package:fcm_notification/core/widgets/k_snack_bar.dart';
import 'package:fcm_notification/core/widgets/k_textfield.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/k_fab.dart';
import '../bloc/notification_bloc.dart';

class CreateNotificationPage extends StatefulWidget {
  final String appId;
  const CreateNotificationPage({
    Key? key,
    required this.appId,
  }) : super(key: key);

  @override
  State<CreateNotificationPage> createState() => _CreateNotificationPageState();
}

class _CreateNotificationPageState extends State<CreateNotificationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _topicNameController = TextEditingController();
  final TextEditingController _deviceIdController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _imageLinkController = TextEditingController();
  final TextEditingController _dataKeyController = TextEditingController();
  final TextEditingController _dataValueController = TextEditingController();

  NotificationReceiverType _notificationReceiverType =
      NotificationReceiverType.all;
  NotificationType _notificationGroupType = NotificationType.notification;

  bool receiverTypeIsValid = true;
  bool notificationGroupTypeIsValid = true;

  validateReceiverType() {
    if ((_notificationReceiverType == NotificationReceiverType.all) &&
        _topicNameController.text.trim().isEmpty) {
      setState(() {
        receiverTypeIsValid = false;
      });
    } else if ((_notificationReceiverType == NotificationReceiverType.single) &&
        _deviceIdController.text.trim().isEmpty) {
      setState(() {
        receiverTypeIsValid = false;
      });
    } else {
      setState(() {
        receiverTypeIsValid = true;
      });
    }
  }

  validateNotificationGroupType() {
    if ((_notificationGroupType == NotificationType.notification) &&
        (_titleController.text.trim().isEmpty ||
            _bodyController.text.trim().isEmpty)) {
      setState(() {
        notificationGroupTypeIsValid = false;
      });
    } else if ((_notificationGroupType == NotificationType.dataMessage) &&
        (_dataKeyController.text.trim().isEmpty ||
            _dataValueController.text.trim().isEmpty)) {
      setState(() {
        notificationGroupTypeIsValid = false;
      });
    } else {
      setState(() {
        notificationGroupTypeIsValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //!

    _nameController.text = 'topic with data message';
    // _topicNameController.text = 'Test Topic';
    _deviceIdController.text = 'Test Device Id';
    _titleController.text = 'Test Title';
    _bodyController.text = 'Test Body';
    _dataKeyController.text = 'Test Data Key';
    _dataValueController.text = 'Test Data Value';
    // _imageLinkController.text =
    //     'https://blog.tryshiftcdn.com/uploads/2021/01/notifications@2x.jpg';

    //!
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: const KAppbar(
        title: 'Create Notification',
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if (state is NotificationCreatedState) {
            kSnackBar(
              context: context,
              type: AlertType.success,
              message: 'Notification created successfully!',
            );

            context
                .read<NotificationBloc>()
                .add(GetAppNotificationsEvent(appId: widget.appId));
            router.pop();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 10.h,
              bottom: 20.h,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  KTextField(
                    hintText: 'Notification Name *',
                    controller: _nameController,
                    autofocus: true,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Notification name is required!';
                      }
                      return null;
                    },
                  ),
                  KCard(
                    color: KColors.primary,
                    xPadding: 15.w,
                    // yPadding: 20.h,
                    hasBorder: receiverTypeIsValid == true ? false : true,
                    borderColor: Colors.red,
                    borderWidth: 1.w,
                    child: Column(
                      children: [
                        KRadioTile(
                          value: NotificationReceiverType.all,
                          groupValue: _notificationReceiverType,
                          title: 'All Users',
                          subtitle: 'Topic name required',
                          icon: Icons.alt_route_outlined,
                          onChanged: (value) {
                            _deviceIdController.clear();
                            setState(() {
                              _notificationReceiverType =
                                  value as NotificationReceiverType;
                            });
                          },
                        ),
                        KRadioTile(
                          value: NotificationReceiverType.single,
                          groupValue: _notificationReceiverType,
                          title: 'Single User',
                          subtitle: 'Device id required',
                          icon: Icons.turn_slight_right_sharp,
                          onChanged: (value) {
                            _topicNameController.clear();
                            setState(() {
                              _notificationReceiverType =
                                  value as NotificationReceiverType;
                            });
                          },
                        ),
                        SizedBox(height: 15.h),
                        _notificationReceiverType ==
                                NotificationReceiverType.all
                            ? KTextField(
                                hintText: 'Topic Name *',
                                controller: _topicNameController,
                                bottomPadding: 5.h,
                                bgColor: KColors.background,
                              )
                            : KTextField(
                                hintText: 'Device ID *',
                                controller: _deviceIdController,
                                bgColor: KColors.background,
                                bottomPadding: 5.h,
                              )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  KCard(
                    color: KColors.primary,
                    xPadding: 15.w,
                    hasBorder:
                        notificationGroupTypeIsValid == true ? false : true,
                    borderColor: Colors.red,
                    borderWidth: 1.w,
                    child: Column(
                      children: [
                        KRadioTile(
                          value: NotificationType.notification,
                          groupValue: _notificationGroupType,
                          title: 'Notification',
                          subtitle: 'Send a notification',
                          icon: Icons.notification_important_rounded,
                          onChanged: (value) {
                            _dataKeyController.clear();
                            _dataValueController.clear();
                            setState(() {
                              _notificationGroupType =
                                  value as NotificationType;
                            });
                          },
                        ),
                        KRadioTile(
                          value: NotificationType.dataMessage,
                          groupValue: _notificationGroupType,
                          title: 'Data Message',
                          subtitle: 'Send data message',
                          icon: Icons.message_rounded,
                          onChanged: (value) {
                            _titleController.clear();
                            _bodyController.clear();
                            _imageLinkController.clear();
                            setState(() {
                              _notificationGroupType =
                                  value as NotificationType;
                            });
                          },
                        ),
                        SizedBox(height: 15.h),
                        _notificationGroupType == NotificationType.notification
                            ? buildNotificationFields()
                            : buildDataMessageFields(),
                      ],
                    ),
                  ),
                  SizedBox(height: 70.h),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: KFab(
        label: 'CREATE',
        icon: Icons.notification_add_sharp,
        onPressed: () {
          bool? isValid = _formKey.currentState?.validate();
          validateReceiverType();
          validateNotificationGroupType();
          if (isValid == true &&
              receiverTypeIsValid == true &&
              notificationGroupTypeIsValid == true) {
            NotificationEntity notificationEntity = NotificationEntity(
              appId: widget.appId,
              id: const Uuid().v1(),
              name: _nameController.text.trim(),
              topicName: _topicNameController.text.trim(),
              deviceId: _deviceIdController.text.trim(),
              title: _titleController.text.trim(),
              body: _bodyController.text.trim(),
              dataKey: _dataKeyController.text.trim(),
              dataValue: _dataValueController.text.trim(),
              imageUrl: _imageLinkController.text.trim(),
              createdAt: DateTime.now(),
              receiverType: _notificationReceiverType,
              notificationType: _notificationGroupType,
            );

            context.read<NotificationBloc>().add(
                  CreateNotificationEvent(notification: notificationEntity),
                );
          } else {
            kSnackBar(
              context: context,
              type: AlertType.failed,
              message: 'Please fill all the required fields',
            );
          }
        },
      ),
    );
  }

  Column buildNotificationFields() {
    return Column(
      children: [
        KTextField(
          hintText: 'Notification Title *',
          controller: _titleController,
          bgColor: KColors.background,
          bottomPadding: 15.h,
        ),
        KTextField(
          hintText: 'Notification Body *',
          controller: _bodyController,
          bgColor: KColors.background,
          maxLines: 5,
          bottomPadding: 15.h,
        ),
        KTextField(
          hintText: 'Image link (optional)',
          controller: _imageLinkController,
          bgColor: KColors.background,
          bottomPadding: 10.h,
        ),
      ],
    );
  }

  Row buildDataMessageFields() {
    return Row(
      children: [
        Expanded(
          child: KTextField(
            hintText: 'Key *',
            controller: _dataKeyController,
            bgColor: KColors.background,
            bottomPadding: 5.h,
          ),
        ),
        Text(
          ' : ',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: KColors.background,
          ),
        ),
        Expanded(
          child: KTextField(
            hintText: 'Value *',
            controller: _dataValueController,
            bottomPadding: 5.h,
            bgColor: KColors.background,
          ),
        ),
      ],
    );
  }
}
