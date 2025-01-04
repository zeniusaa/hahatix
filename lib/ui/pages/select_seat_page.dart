part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  SelectSeatPage(this.ticket, {Key? key}) : super(key: key);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .read<PageBloc>()
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: accentColor1),
            SafeArea(child: Container(color: Colors.white)),
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _buildHeader(context),
                    _buildCinemaScreen(),
                    generateSeats(),
                    const SizedBox(height: 30),
                    _buildNextButton(context),
                    const SizedBox(height: 50),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20, left: defaultMargin),
          padding: const EdgeInsets.all(1),
          child: GestureDetector(
            onTap: () {
              context
                  .read<PageBloc>()
                  .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: defaultMargin),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 16),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  widget.ticket.movieDetail.title,
                  style: blackTextFont.copyWith(fontSize: 20),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(imagesBaseUrl +
                        'w154' +
                        widget.ticket.movieDetail.posterPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCinemaScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: 450,
      height: 150,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/screen.png")),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor:
            selectedSeats.isNotEmpty ? mainColor : const Color(0xFFE4E4E4),
        child: Icon(
          Icons.arrow_forward,
          color:
              selectedSeats.isNotEmpty ? Colors.white : const Color(0xFFBEBEBE),
        ),
        onPressed: selectedSeats.isNotEmpty
            ? () {
                context.read<PageBloc>().add(GoToCheckoutPage(
                    widget.ticket.copyWith(seats: selectedSeats)));
              }
            : null,
      ),
    );
  }

  Column generateSeats() {
    List<int> numberOfSeats = [5, 7, 7, 7, 7];
    List<Widget> widgets = [];

    for (int i = 0; i < numberOfSeats.length; i++) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          numberOfSeats[i],
          (index) => Padding(
            padding: EdgeInsets.only(
              right: index < numberOfSeats[i] - 1 ? 16 : 0,
              bottom: 16,
            ),
            child: SelectableBox(
              text: "${String.fromCharCode(i + 65)}${index + 1}",
              width: 40,
              height: 40,
              textStyle: whiteNumberFont.copyWith(color: Colors.black),
              isSelected: selectedSeats
                  .contains("${String.fromCharCode(i + 65)}${index + 1}"),
              onTap: () {
                String seatNumber =
                    "${String.fromCharCode(i + 65)}${index + 1}";
                setState(() {
                  if (selectedSeats.contains(seatNumber)) {
                    selectedSeats.remove(seatNumber);
                  } else {
                    selectedSeats.add(seatNumber);
                  }
                });
              },
              // isEnabled: index != 0,
            ),
          ),
        ),
      ));
    }

    return Column(children: widgets);
  }
}
