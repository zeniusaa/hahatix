part of 'pages.dart';

File? imageFileToUpload;

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // Note: Header
        _buildHeader(context),

        // Note: Now Playing
        _buildSectionTitle("Now Playing"),
        _buildNowPlaying(),

        // Note: Browse Movie
        _buildSectionTitle("Browse Movie"),
        _buildBrowseMovie(),

        // Note: Coming Soon
        _buildSectionTitle("Coming Soon"),
        _buildComingSoon(),

        // Note: Get Lucky Day
        _buildSectionTitle("Get Lucky Day"),
        _buildPromoSection(),

        SizedBox(height: 100),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: accentColor1,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
      child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
        if (userState is UserLoaded) {
          if (imageFileToUpload != null) {
            uploadImage(imageFileToUpload!).then((downloadURL) {
              imageFileToUpload = null;
              context
                  .read<UserBloc>()
                  .add(UpdateData(profilePicture: downloadURL));
            });
          }

          return Row(
            children: <Widget>[
              _buildProfilePicture(
                  userState.user.profilePicture ?? "", context),
              SizedBox(width: 16),
              _buildUserInfo(userState.user, context),
            ],
          );
        } else {
          return SpinKitFadingCircle(
            color: accentColor2,
            size: 50,
          );
        }
      }),
    );
  }

  Widget _buildProfilePicture(String profilePicture, BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            context.read<PageBloc>().add(GoToProfilePage());
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFF5F558B), width: 1),
            ),
            child: Stack(
              children: <Widget>[
                SpinKitFadingCircle(color: accentColor2, size: 50),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: profilePicture.isEmpty
                          ? AssetImage("assets/user_pic.png")
                          : NetworkImage(profilePicture),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(User user, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width - 2 * defaultMargin - 78,
          child: Text(
            user.name ?? 'No Name',
            style: whiteTextFont.copyWith(fontSize: 18),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
        ),
        Text(
          NumberFormat.currency(
            locale: "id_ID",
            decimalDigits: 0,
            symbol: "IDR ",
          ).format(user.balance),
          style: yellowNumberFont.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
      child: Text(
        title,
        style: blackTextFont.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNowPlaying() {
    return SizedBox(
      height: 140,
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (_, movieState) {
          if (movieState is MovieLoaded) {
            List<Movie> movies = movieState.movies.sublist(0, 10);

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.only(
                  left: (index == 0) ? defaultMargin : 0,
                  right: (index == movies.length - 1) ? defaultMargin : 16,
                ),
                child: MovieCard(
                  movies[index],
                  onTap: (BuildContext context) {
                    context
                        .read<PageBloc>()
                        .add(GoToMovieDetailPage(movies[index]));
                  },
                ),
              ),
            );
          } else {
            return SpinKitFadingCircle(color: mainColor, size: 50);
          }
        },
      ),
    );
  }

  Widget _buildBrowseMovie() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, userState) {
        if (userState is UserLoaded) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: userState.user.selectedGenres
                  .map((genre) => BrowseButton(genre))
                  .toList(),
            ),
          );
        } else {
          return SpinKitFadingCircle(color: mainColor, size: 50);
        }
      },
    );
  }

  Widget _buildComingSoon() {
    return SizedBox(
      height: 160,
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (_, movieState) {
          if (movieState is MovieLoaded) {
            List<Movie> movies = movieState.movies.sublist(10);

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.only(
                  left: (index == 0) ? defaultMargin : 0,
                  right: (index == movies.length - 1) ? defaultMargin : 16,
                ),
                child: ComingSoonCard(
                  movies[index],
                  onTap: () {},
                ),
              ),
            );
          } else {
            return SpinKitFadingCircle(color: mainColor, size: 50);
          }
        },
      ),
    );
  }

  Widget _buildPromoSection() {
    return Column(
      children: dummyPromo.map((promo) {
        return Padding(
          padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child: PromoCard(promo),
        );
      }).toList(),
    );
  }
}
