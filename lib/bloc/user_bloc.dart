import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hahatix/models/models.dart';
import 'package:hahatix/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    // Handler for LoadUser
    on<LoadUser>((event, emit) async {
      try {
        User user = await UserServices.getUser(event.id);
        emit(UserLoaded(user));
      } catch (e) {
        emit(UserInitial());
      }
    });

    // Handler for SignOut
    on<SignOut>((event, emit) {
      emit(UserInitial());
    });
    on<SignOut>((event, emit) {
      emit(UserInitial());
    });
    
  }
}
