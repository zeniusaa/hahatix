part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage());
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: accentColor1),
            SafeArea(child: Container(color: Colors.white)),
            ListView(
              children: <Widget>[
                _buildMovieDetailHeader(context),
                FutureBuilder(
                  future: MovieServices.getDetails(movie),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      MovieDetail? movieDetail = snapshot.data;

                      return Column(
                        children: <Widget>[
                          _buildMovieInfo(movie, movieDetail!),
                          _buildCastAndCrewSection(movie.id),
                          _buildStorylineSection(movie),
                          _buildContinueButton(context, movieDetail),
                        ],
                      );
                    } else {
                      return Center(
                        child: SpinKitFadingCircle(color: accentColor3),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieDetailHeader(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 270,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  imagesBaseUrl + "w1280" + movie.backdropPath ??
                      movie.posterPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 271,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, 1),
              end: Alignment(0, 0.06),
              colors: [Colors.white, Colors.white.withOpacity(0)],
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: defaultMargin,
          child: GestureDetector(
            onTap: () {
              context.read<PageBloc>().add(GoToMainPage());
            },
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black.withOpacity(0.04),
              ),
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieInfo(Movie movie, MovieDetail movieDetail) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
          child: Text(
            movie.title,
            textAlign: TextAlign.center,
            style: blackTextFont.copyWith(fontSize: 24),
          ),
        ),
        Text(
          movieDetail.genresAndLanguage,
          style: greyTextFont.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 6),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: whiteTextFont.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // RatingStars(
            //   voteAverage: movie.voteAverage,
            // ),
            // SizedBox(height: 24),
          ],
        ),
      ],
    );
  }

  Widget _buildCastAndCrewSection(int movieId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: defaultMargin, bottom: 12),
          child:
              Text("Cast & Crew", style: blackTextFont.copyWith(fontSize: 14)),
        ),
        FutureBuilder(
          future: MovieServices.getCredits(movieId),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              List<Credit>? credits = snapshot.data;
              return SizedBox(
                height: 115,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: credits?.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                      left: index == 0 ? defaultMargin : 0,
                      right: index == credits!.length - 1 ? defaultMargin : 16,
                    ),
                    child: CreditCard(credits[index]),
                  ),
                ),
              );
            } else {
              return Center(
                child: SpinKitFadingCircle(color: accentColor1),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildStorylineSection(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 24, defaultMargin, 8),
          child: Text("Storyline", style: blackTextFont),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 30),
          child: Text(
            movie.overview,
            style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context, MovieDetail movieDetail) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Continue to Book",
            style: whiteTextFont.copyWith(fontSize: 16),
          ),
          onPressed: () {
            context.read<PageBloc>().add(GoToSelectSchedulePage(movieDetail));
          },
        ));
  }
}
