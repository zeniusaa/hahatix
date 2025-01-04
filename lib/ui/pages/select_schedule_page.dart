part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  late List<DateTime> dates;
  late DateTime selectedDate;
  late int selectedTime;
  Theater? selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // Background color
            Container(color: accentColor1),
            SafeArea(
                child: Container(
              color: Colors.white,
            )),
            ListView(
              children: <Widget>[
                // Back Button
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: EdgeInsets.all(1),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<PageBloc>()
                              .add(GoToMovieDetailPage(widget.movieDetail));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                // Choose Date Section
                _buildChooseDateSection(),

                // Choose Time Section
                generateTimeTable(),

                // Next Button Section
                SizedBox(height: 10),
                _buildNextButton(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Choose Date Section Widget
  Widget _buildChooseDateSection() {
    return Container(
      margin: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Date",
            style: blackTextFont.copyWith(fontSize: 20),
          ),
          SizedBox(height: 16),
          Container(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.only(
                    left: (index == 0) ? defaultMargin : 0,
                    right: (index < dates.length - 1) ? 16 : defaultMargin),
                child: DateCard(
                  dates[index],
                  isSelected: selectedDate == dates[index],
                  onTap: () {
                    setState(() {
                      selectedDate = dates[index];
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Next Button Widget
  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (_, userState) => FloatingActionButton(
          elevation: 0,
          backgroundColor: (isValid) ? mainColor : Color(0xFFE4E4E4),
          child: Icon(
            Icons.arrow_forward,
            color: isValid ? Colors.white : Color(0xFFBEBEBE),
          ),
          onPressed: () {
            if (isValid) {
              context.read<PageBloc>().add(GoToSelectSeatPage(Ticket(
                    movieDetail: widget.movieDetail,
                    theater: selectedTheater!,
                    time: DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime,
                    ),
                    bookingCode: randomAlphaNumeric(12).hashCode.toString(),
                    seats: [],
                    name: (userState as UserLoaded).user.name ?? 'Guest',
                    totalPrice: 0,
                  )));
            }
          },
        ),
      ),
    );
  }

  // Time Table Generation Widget
  Column generateTimeTable() {
    List<int> schedule = List.generate(5, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheaters) {
      widgets.add(Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
        child: Text(
          theater.name,
          style: blackTextFont.copyWith(fontSize: 20),
        ),
      ));

      widgets.add(
        Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 20),
          child: ListView.builder(
            itemCount: schedule.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => Container(
              margin: EdgeInsets.only(
                  left: (index == 0) ? defaultMargin : 0,
                  right: (index < schedule.length - 1) ? 16 : defaultMargin),
              child: SelectableBox(
                text: "${schedule[index]}:00",
                height: 50,
                isSelected: selectedTheater == theater &&
                    selectedTime == schedule[index],
                isEnabled: schedule[index] > DateTime.now().hour ||
                    selectedDate.day != DateTime.now().day,
                onTap: () {
                  setState(() {
                    selectedTheater = theater;
                    selectedTime = schedule[index];
                    isValid = true;
                  });
                },
                textStyle: blackTextFont.copyWith(
                  color: (schedule[index] > DateTime.now().hour ||
                          selectedDate.day != DateTime.now().day)
                      ? Colors.black
                      : Color(0xFFE4E4E4),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
