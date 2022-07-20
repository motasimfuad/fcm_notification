import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/application/domain/usecases/create_app_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/delete_app_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/get_all_apps_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/update_app_usecase.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_app_usecase.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final GetAllAppsUsecase getAllApps;
  final GetAppUsecase getApp;
  final DeleteAppUsecase deleteApp;
  final CreateAppUsecase createApp;
  final UpdateAppUsecase updateApp;
  ApplicationBloc({
    required this.getAllApps,
    required this.getApp,
    required this.deleteApp,
    required this.createApp,
    required this.updateApp,
  }) : super(ApplicationInitial()) {
    on<ApplicationEvent>((event, emit) async {
      print("state: ${state.toString()}");
      // Get all apps
      if (event is GetAllAppsEvent) {
        emit(AppListLoading());
        final result = await getAllApps(NoParams());
        result.fold(
          (l) => emit(AppListLoadingFailed(message: l.toString())),
          (r) => emit(AppListLoaded(apps: r)),
        );
      }

      // Get app
      if (event is GetAppEvent) {
        emit(AppLoading());
        final result = await getApp(Params(id: event.appId));
        result.fold(
          (l) => emit(AppLoadingFailed(message: l.toString())),
          (r) => emit(AppLoaded(app: r)),
        );
      }

      // Delete app
      if (event is DeleteAppEvent) {
        final result = await deleteApp(Params(id: event.appId));
        result.fold(
          (l) => emit(AppDeletingFailed(message: l.toString())),
          (r) => emit(AppDeleted()),
        );
      }

      // Add app icon
      if (event is AddAppIconEvent) {
        emit(AppIconLoading());
        try {
          final image = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            imageQuality: 100,
          );
          if (image == null) {
            emit(const AppIconAddedState(
              iconName: null,
            ));
            return;
          } else {
            Directory appDocumentsDirectory =
                await getApplicationDocumentsDirectory();

            final iconFile = File(
                '${appDocumentsDirectory.path}/${image.path.split('/').last}');

            var newIconFile =
                await iconFile.writeAsBytes(await image.readAsBytes());

            emit(AppIconAddedState(
              iconName: newIconFile.path,
            ));
          }
        } on PlatformException catch (e) {
          emit(AppIconAddingFailed(message: 'Failed to add icon ${e.message}'));
        }
      }

      // Create app
      if (event is CreateAppEvent) {
        emit(AppLoading());
        final result = await createApp(Params(app: event.appEntity));
        result.fold(
          (l) => emit(AppCreatingFailed(message: l.toString())),
          (r) => emit(AppCreatedState()),
        );
      }

      // Update app
      if (event is UpdateAppEvent) {
        emit(AppLoading());
        final result = await updateApp(Params(app: event.appEntity));
        result.fold(
          (l) => emit(AppUpdatingFailed(message: l.toString())),
          (r) => emit(AppUpdatedState()),
        );
      }
    });
  }
}
