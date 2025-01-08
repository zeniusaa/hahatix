part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

final class FetchMovies extends MovieEvent {
  final String gendreId;

  const FetchMovies(this.gendreId);

  @override
  List<Object> get props => [gendreId];
}
