part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

final class FetchMovies extends MovieEvent {
  final int page;

  const FetchMovies(this.page);

  @override
  List<Object> get props => [page];
}
