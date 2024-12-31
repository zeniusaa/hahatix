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
}
