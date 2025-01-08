part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;
  final String gendreId;

  BrowseButton(this.genre, this.gendreId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MovieBloc>().add(FetchMovies(gendreId));
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 4),
            width: 75,
            height: 75,
            decoration: BoxDecoration(
                color: Color(0xFFEEF1F8),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: SizedBox(
                  height: 36,
                  child: Image(image: AssetImage(getImageFromGenre(genre)))),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            genre,
            style: blackTextFont.copyWith(fontSize: 13),
          )
        ],
      ),
    );
  }

  String getImageFromGenre(String genre) {
    switch (genre) {
      case "Horror":
        return "assets/ic_horror.png";
      case "Music":
        return "assets/ic_music.png";
      case "Action":
        return "assets/ic_action.png";
      case "Drama":
        return "assets/ic_drama.png";
      case "War":
        return "assets/ic_war.png";
      case "Crime":
        return "assets/ic_crime.png";
      default:
        return "";
    }
  }
}
