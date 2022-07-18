import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/application/domain/usecases/get_all_apps_usecase.dart';

import '../../../../core/usecases/usecase.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final GetAllAppsUsecase getAllApps;

  ApplicationBloc({
    required this.getAllApps,
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
    });
  }
}
