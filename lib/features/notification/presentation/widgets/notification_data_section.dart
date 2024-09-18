import 'dart:developer';

import 'package:fcm_notification/core/constants/constants.dart';
import 'package:fcm_notification/core/widgets/k_card.dart';
import 'package:fcm_notification/core/widgets/k_icon_button.dart';
import 'package:fcm_notification/core/widgets/k_textfield.dart';
import 'package:fcm_notification/features/notification/domain/entities/data_entity.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NotificationDataSection extends StatefulWidget {
  const NotificationDataSection({
    super.key,
    required this.initialData,
    required this.onDataChanged,
    this.isReadOnly = false,
  });

  final List<DataEntity> initialData;
  final Function(List<DataEntity>) onDataChanged;
  final bool isReadOnly;

  @override
  State<NotificationDataSection> createState() =>
      _NotificationDataSectionState();
}

class _NotificationDataSectionState extends State<NotificationDataSection> {
  final formKey = GlobalKey<FormState>();
  FocusNode? keyFocusNode = FocusNode();

  List<DataEntity> dataEntityList = [];
  bool isDataValid = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        dataEntityList = [...widget.initialData];
      });

      if (widget.initialData.isEmpty) {
        keyFocusNode?.requestFocus();
      }
    });
  }

  void _addData() {
    final newData = DataEntity(
      id: const Uuid().v4(),
      keyData: '',
      valueData: '',
    );

    setState(() {
      dataEntityList.add(newData);
    });

    _checkIfDataValid();
  }

  void _checkIfDataValid() {
    if (dataEntityList.isNotEmpty &&
        (dataEntityList.any((element) =>
            element.keyData.trim().isEmpty ||
            element.valueData.trim().isEmpty))) {
      setState(() {
        isDataValid = false;
      });
    } else {
      setState(() {
        isDataValid = true;
      });
    }

    widget.onDataChanged(dataEntityList
        .where((element) =>
            element.keyData.trim().isNotEmpty &&
            element.valueData.trim().isNotEmpty)
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: KCard(
        color: KColors.primary,
        xPadding: 15.w,
        yMargin: 20.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 12.h,
              ),
              child: (widget.isReadOnly)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Data',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: KColors.primary.shade300,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.data_array,
                                color: KColors.secondary,
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Optional Data',
                                      style: TextStyle(
                                        color: KColors.secondary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 3.5.h),
                                      child: Text(
                                        'Add optional data to your notification',
                                        style: TextStyle(
                                          fontSize: 12.5.sp,
                                          color: KColors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        KIconButton(
                          onPressed: isDataValid ? _addData : null,
                          icon: Icons.add,
                          bgColor:
                              isDataValid ? null : KColors.primary.shade400,
                          iconColor:
                              isDataValid ? KColors.secondary : KColors.primary,
                          size: 14.w,
                        ),
                      ],
                    ),
            ),
            ListView.builder(
              padding: dataEntityList.isNotEmpty
                  ? EdgeInsets.only(top: widget.isReadOnly ? 6.h : 12.h)
                  : EdgeInsets.zero,
              itemCount: dataEntityList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                DataEntity dataEntity = dataEntityList[index];
                bool isLast = index == dataEntityList.length - 1;

                return FocusScope(
                  onFocusChange: (hasFocus) {
                    log('Has focus $index: $hasFocus');
                  },
                  child: _DataItem(
                    isReadOnly: widget.isReadOnly,
                    keyFocusNode: !isLast ? null : keyFocusNode,
                    key: ValueKey(dataEntity.id),
                    dataEntity: dataEntity,
                    onDataChanged: (dataEntity) {
                      setState(() {
                        dataEntityList[index] = dataEntity;
                      });

                      _checkIfDataValid();
                    },
                    onDelete: (id) {
                      setState(() {
                        dataEntityList
                            .removeWhere((element) => element.id == id);
                      });

                      _checkIfDataValid();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DataItem extends StatefulWidget {
  const _DataItem({
    super.key,
    required this.dataEntity,
    required this.onDataChanged,
    required this.onDelete,
    required this.keyFocusNode,
    required this.isReadOnly,
  });

  final DataEntity dataEntity;
  final Function(DataEntity) onDataChanged;
  final Function(String) onDelete;
  final FocusNode? keyFocusNode;
  final bool isReadOnly;

  @override
  State<_DataItem> createState() => _DataItemState();
}

class _DataItemState extends State<_DataItem> {
  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    keyController.text = widget.dataEntity.keyData;
    valueController.text = widget.dataEntity.valueData;
    if (keyController.text.trim().isEmpty) {
      widget.keyFocusNode?.requestFocus();
    }
  }

  @override
  void dispose() {
    keyController.dispose();
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        key: ValueKey(widget.dataEntity.id),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: KTextField(
                    isReadOnly: widget.isReadOnly,
                    key: ValueKey(widget.dataEntity.id),
                    focusNode: widget.keyFocusNode,
                    hintText: 'Key',
                    controller: keyController,
                    bgColor: KColors.background,
                    bottomPadding: 0,
                    onChanged: (value) {
                      widget.onDataChanged(
                        DataEntity(
                          id: widget.dataEntity.id,
                          keyData: value,
                          valueData: widget.dataEntity.valueData,
                        ),
                      );
                    },
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
                    isReadOnly: widget.isReadOnly,
                    hintText: 'Value',
                    textInputAction: TextInputAction.done,
                    controller: valueController,
                    bottomPadding: 0,
                    bgColor: KColors.background,
                    onChanged: (value) {
                      widget.onDataChanged(
                        DataEntity(
                          id: widget.dataEntity.id,
                          keyData: widget.dataEntity.keyData,
                          valueData: value,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (!widget.isReadOnly)
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: KIconButton(
                iconColor: KColors.primaryLight,
                size: 12.w,
                onPressed: () {
                  widget.onDelete(widget.dataEntity.id);
                  setState(() {});
                },
                icon: Icons.close_rounded,
              ),
            ),
        ],
      ),
    );
  }
}
