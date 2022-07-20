import 'package:fcm_notification/dependency_injection.dart';
import 'package:fcm_notification/features/application/presentation/bloc/application_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/notification/presentation/bloc/notification_bloc.dart';

class AllProviders extends StatelessWidget {
  final Widget child;
  const AllProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ApplicationBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<NotificationBloc>(),
        ),
      ],
      child: child,
    );
  }
}
