part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$api&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetails(Movie movie,
      {http.Client? client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movie.id}?api_key=$api&language=en-US";

    client ??= http.Client();

    var response = await client.get(Uri.parse(url));
    var data = json.decode(response.body);

    List genres = (data as Map<String, dynamic>)['genres'];
    String language = 'Unknown';

    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = 'Japanese';
        break;
      case 'id':
        language = 'Indonesian';
        break;
      case 'ko':
        language = 'Korean';
        break;
      case 'en':
        language = 'English';
        break;
    }

    return MovieDetail(movie,
        language: language,
        genres: genres
            .map((e) => (e as Map<String, dynamic>)['name'].toString())
            .toList());
  }

  static Future<List<Credit>> getCredits(int movieID) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieID/credits?api_key=$api";

    var client = http.Client();

    var response = await client.get(Uri.parse(url));
    var data = json.decode(response.body);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
            name: (e as Map<String, dynamic>)['name'],
            profilePath: (e as Map<String, dynamic>)['profile_path']))
        .take(8)
        .toList();
  }
}
