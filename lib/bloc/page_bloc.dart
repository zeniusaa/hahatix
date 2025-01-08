import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hahatix/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnInitialPage()) {
    on<GoToSplashPage>((event, emit) {
      emit(OnSplashPage());
    });
    on<GoToLoginPage>((event, emit) {
      emit(OnLoginPage());
    });
    on<GoToMainPage>((event, emit) {
      emit(OnMainPage());
    });
    on<GoToRegistrasionPage>((event, emit) {
      emit(OnRegistrationPage(event.registrasionData));
    });
    on<GoToPreferencePage>((event, emit) {
      emit(OnPreferencePage(event.registrasionData));
    });
    on<GoToAccountConfirmationPage>((event, emit) {
      emit(OnAccountConfirmationPage(event.registrasionData));
    });
    on<GoToMovieDetailPage>((event, emit) {
      emit(OnMovieDetailPage(event.movie));
    });
    on<GoToSelectSchedulePage>((event, emit) {
      emit(OnSelectSchedulePage(event.movieDetail));
    });
    on<GoToSelectSeatPage>((event, emit) {
      emit(OnSelectSeatPage(event.ticket));
    });
    on<GoToCheckoutPage>((event, emit) {
      emit(OnCheckoutPage(event.ticket));
    });
    on<GoToSuccessPage>((event, emit) {
      emit(OnSuccessPage(event.ticket, event.transaction));
    });
    on<GoToTicketDetailPage>((event, emit) {
      emit(OnTicketDetailPage(event.ticket));
    });
    on<GoToProfilePage>((event, emit) {
      emit(OnProfilePage());
    });
    on<GoToTopUpPage>((event, emit) {
      emit(OnTopUpPage(event.pageEvent));
    });
    on<GoToSuccessTopUpPage>((event, emit) {
      emit(OnSuccessTopUpPage(event.transaction));
    });
  }
}
