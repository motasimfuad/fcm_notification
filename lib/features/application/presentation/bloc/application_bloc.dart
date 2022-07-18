import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/application/domain/usecases/create_app_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/delete_app_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/get_all_apps_usecase.dart';
import 'package:fcm_notification/features/application/domain/usecases/update_app_usecase.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
          print('step 1');
          final image = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            imageQuality: 100,
          );
          print('step 2');
          if (image == null) {
            print('step null');
            emit(const AppIconAddedState(
              iconFile: null,
              convertedIcon: null,
            ));
            return;
          } else {
            print('step 3');
            var tempImage = File(image.path);
            print('step 4');
            final convertedIcon = await tempImage.readAsBytes();
            print('step 5');
            emit(AppIconAddedState(
              iconFile: tempImage,
              convertedIcon: convertedIcon,
            ));
          }
        } on PlatformException catch (e) {
          print('step exception');
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
    });
  }
}
