import 'package:fcm_notification/core/widgets/k_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreateNotificationPage extends StatelessWidget {
  const CreateNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: KAppbar(
        title: 'Create Notification',
      ),
      body: Center(
        child: Text('Create Notification'),
      ),
    );
  }
}
