part of 'pages.dart';

File? imageFileToUpload;

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Header
        Container(
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, state) {
              if (state is UserLoaded) {
                if (imageFileToUpload != null) {
                  uploadImage(imageFileToUpload!).then((downloadURL) {
                    imageFileToUpload = null;
                    context
                        .read<UserBloc>()
                        .add(UpdateData(profilePicture: downloadURL));
                  });
                }
                final user = state.user;
                return Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF5F558B),
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          SpinKitFadingCircle(
                            color: accentColor2,
                            size: 50,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                // Jika profilePicture kosong atau null, tampilkan gambar default
                                image: (user.profilePicture?.isEmpty ?? true
                                    ? const AssetImage("assets/user_pic.png")
                                    : NetworkImage(
                                        user.profilePicture!)) as ImageProvider<
                                    Object>,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    // Informasi User
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              50 -
                              12 -
                              16,
                          child: Text(
                            user.name ?? "Guest",
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
                          ).format(user.balance ?? 0),
                          style: yellowNumberFont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else {
                // Jika state masih loading
                return SpinKitFadingCircle(
                  color: accentColor2,
                  size: 50,
                );
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Now Playing",
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                List<Movie> movies = movieState.movies.sublist(0, 10);

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.all(5),
                    child: Text(movies[index].title),
                  ),
                );
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
                // return Text("No Movies");
              }
            },
          ),
        )
      ],
    );
  }
}
