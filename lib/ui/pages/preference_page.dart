part of 'pages.dart';


class PreferencePage extends StatefulWidget {
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime"
  ];
  final List<String> languages = [
    "Indonesia",
    "English",
    "Japanese",
    "Korean",
  ];

  final RegistrasionData registrationData;

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = [];
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.registrationData.password = "";

        context
            .read<PageBloc>()
            .add(GoToRegistrasionPage(widget.registrationData));
        return true;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 56,
                    margin: EdgeInsets.only(top: 20, bottom: 4),
                    child: GestureDetector(
                        onTap: () {
                          widget.registrationData.password = "";

                          context.read<PageBloc>().add(
                             GoToRegistrasionPage(widget.registrationData));
                        },
                        child: Icon(Icons.arrow_back)),
                  ),
                  Text(
                    "Select Your Four\nFavorite Genres",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateGenreWidgets(context),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Movie Language\nYou Prefer?",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLangWidgets(context),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: mainColor,
                        foregroundColor: Colors.white,
                        child: Icon(Icons.arrow_forward),
                        onPressed: () {
                          if (selectedGenres.length != 4) {
                            Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: "Please select 4 genres",
                            )..show(context);
                          } else {
                            widget.registrationData.selectedGenres =
                                selectedGenres;
                            widget.registrationData.selectedLang =
                                selectedLanguage;

                            context.read<PageBloc>().add(
                                GoToAccountConfirmationPage(
                                    widget.registrationData));
                          }
                        }),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

   List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.genres
        .map((e) => SelectableBox(
              text: e, // Pastikan memberikan argumen 'text' yang diperlukan
              width: width,
              isSelected: selectedGenres.contains(e),
              onTap: () {
                onSelectGenre(e);
              },
              textStyle: blackTextFont.copyWith(fontSize: 16), // Menambahkan textStyle
            ))
        .toList();
  }

  List<Widget> generateLangWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.languages
        .map((e) => SelectableBox(
              text: e, // Pastikan memberikan argumen 'text' yang diperlukan
              width: width,
              isSelected: selectedLanguage == e,
              onTap: () {
                setState(() {
                  selectedLanguage = e;
                });
              },
              textStyle: blackTextFont.copyWith(fontSize: 16), // Menambahkan textStyle
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}