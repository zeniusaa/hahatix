import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnInitialPage()) {
    // Handler for GoToSplashPage
    on<GoToSplashPage>((event, emit) {
      emit(OnSplashPage());
    });

    // Handler for GoToLoginPage
    on<GoToLoginPage>((event, emit) {
      emit(OnLoginPage());
    });

    // Handler for GoToMainPage
    on<GoToMainPage>((event, emit) {
      emit(OnMainPage());
    });
  }
}
