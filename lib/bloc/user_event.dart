part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  final String id;

  LoadUser(this.id);

  @override
  List<Object> get props => [id];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateData extends UserEvent {
  final String? name;
  final String? profilePicture;

  UpdateData({this.name, this.profilePicture});

  @override
  List<Object?> get props => [name, profilePicture];
}

class TopUp extends UserEvent {
  final int amount;

  TopUp(this.amount);

  @override
  List<Object> get props => [amount];
}

class Purchase extends UserEvent {
  final int amount;

  Purchase(this.amount);

  @override
  List<Object> get props => [amount];
}
