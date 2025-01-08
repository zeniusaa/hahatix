part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage(this.ticket);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    int total = 26500 * widget.ticket.seats.length;

    return WillPopScope(
        onWillPop: () async {
          context.read<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
          return true;
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                color: accentColor1,
              ),
              SafeArea(
                  child: Container(
                color: Colors.white,
              )),
              ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      // note: BACK BUTTON
                      Row(
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.only(top: 20, left: defaultMargin),
                            padding: EdgeInsets.all(1),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<PageBloc>()
                                    .add(GoToSelectSeatPage(widget.ticket));
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (_, userState) {
                          User user = (userState as UserLoaded).user;

                          return Column(
                            children: <Widget>[
                              // note: PAGE TITLE
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "Checkout\nMovie",
                                  style: blackTextFont.copyWith(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // note: MOVIE DESCRIPTION
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 70,
                                    height: 90,
                                    margin: EdgeInsets.only(
                                        left: defaultMargin, right: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: NetworkImage(imagesBaseUrl +
                                                'w342' +
                                                widget.ticket.movieDetail
                                                    .posterPath),
                                            fit: BoxFit.cover)),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              2 * defaultMargin -
                                              70 -
                                              20,
                                          child: Text(
                                            widget.ticket.movieDetail.title,
                                            style: blackTextFont.copyWith(
                                                fontSize: 18),
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                          )),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                2 * defaultMargin -
                                                70 -
                                                20,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 6),
                                        child: Text(
                                          widget.ticket.movieDetail
                                              .genresAndLanguage,
                                          style: greyTextFont.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      RatingStars(
                                        voteAverage: widget
                                            .ticket.movieDetail.voteAverage,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: defaultMargin),
                                  child: Divider(
                                    color: Color(0xFFE4E4E4),
                                    thickness: 1,
                                  )),
                              _buildDetailRow("Order ID",
                                  widget.ticket.bookingCode, context),
                              _buildDetailRow(
                                  "Cinema", widget.ticket.theater.name, context,
                                  isMultiline: true),
                              _buildDetailRow("Date & Time",
                                  widget.ticket.time.dateAndTime, context),
                              _buildDetailRow("Seat Numbers",
                                  widget.ticket.seatsInString, context,
                                  isMultiline: true),
                              _buildDetailRow(
                                  "Price",
                                  "IDR 25.000 x ${widget.ticket.seats.length}",
                                  context),
                              _buildDetailRow(
                                  "Fee",
                                  "IDR 1.500 x ${widget.ticket.seats.length}",
                                  context),
                              _buildDetailRow(
                                  "Total",
                                  NumberFormat.currency(
                                          locale: 'id_ID',
                                          decimalDigits: 0,
                                          symbol: 'IDR ')
                                      .format(total),
                                  context),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: defaultMargin, vertical: 20),
                                  child: Divider(
                                    color: Color(0xFFE4E4E4),
                                    thickness: 1,
                                  )),
                              _buildDetailRow(
                                  "Your Wallet",
                                  NumberFormat.currency(
                                          locale: 'id_ID',
                                          decimalDigits: 0,
                                          symbol: 'IDR ')
                                      .format(user.balance),
                                  context,
                                  isColor: user.balance >= total
                                      ? Color(0xFF3E9D9D)
                                      : Color(0xFFFF5C83)),
                              Container(
                                width: 250,
                                height: 46,
                                margin: EdgeInsets.only(top: 36, bottom: 50),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: user.balance >= total
                                        ? Color(0xFF3E9D9D)
                                        : mainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    user.balance >= total
                                        ? "Checkout Now"
                                        : "Top Up My Wallet",
                                    style: whiteTextFont.copyWith(fontSize: 16),
                                  ),
                                  onPressed: () {
                                    if (user.balance >= total) {
                                      AppTransaction transaction =
                                          AppTransaction(
                                        userId: user.id,
                                        title: widget.ticket.movieDetail.title,
                                        subtitle: widget.ticket.theater.name,
                                        time: DateTime.now(),
                                        amount: -total,
                                        picture: widget
                                            .ticket.movieDetail.posterPath,
                                      );

                                      context.read<PageBloc>().add(
                                          GoToSuccessPage(
                                              widget.ticket
                                                  .copyWith(totalPrice: total),
                                              transaction));
                                    } else {
                                      context.read<PageBloc>().add(
                                          GoToTopUpPage(GoToTicketDetailPage(
                                              widget.ticket)));
                                      //
                                    }
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildDetailRow(String title, String value, BuildContext context,
      {bool isMultiline = false, Color? isColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        crossAxisAlignment:
            isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,
              style: greyTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400)),
          SizedBox(
            width:
                isMultiline ? MediaQuery.of(context).size.width * 0.55 : null,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: whiteNumberFont.copyWith(
                  color: isColor ?? Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
