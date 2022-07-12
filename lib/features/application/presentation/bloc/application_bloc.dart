import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationInitial()) {
    on<ApplicationEvent>((event, emit) {});
  }
}
