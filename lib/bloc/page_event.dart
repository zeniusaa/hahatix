part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToRegistrasionPage extends PageEvent {
  final RegistrasionData registrasionData;

  GoToRegistrasionPage(this.registrasionData);

  @override
  List<Object> get props => [];
}

class GoToPreferencePage extends PageEvent {
  final RegistrasionData registrasionData;

  GoToPreferencePage(this.registrasionData);
  
  @override
  List<Object> get props => [];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrasionData registrasionData;

  GoToAccountConfirmationPage(this.registrasionData);
  
  @override
  List<Object> get props => [];
}