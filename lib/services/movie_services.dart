part of 'services.dart';

class MovieServices {
  String? gendreId = null;
  static Future<List<Movie>> getMovies(gendreId) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$api&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&with_genres=$gendreId";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetails(Movie? movie,
      {int? movieID, http.Client? client}) async {
    // Jika movieID null, gunakan movie.id.
    String url =
        "https://api.themoviedb.org/3/movie/${movieID ?? movie?.id}?api_key=$api&language=en-US"; // Perhatikan penggunaan movie?.id yang aman jika movie null.

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

    return movieID != null
        ? MovieDetail(Movie.fromJson(data),
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList())
        : MovieDetail(
            movie ??
                Movie.fromJson(
                    data), // Jika movie null, buat movie baru dari data
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
