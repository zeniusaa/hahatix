part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final AppTransaction transaction;

  SuccessPage(this.ticket, this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: FutureBuilder(
              future: ticket != null
                  ? processTicketOrder(context)
                  : _processTopUp(),
              builder: (_, snapshot) => (snapshot.connectionState ==
                      ConnectionState.done)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 150,
                          margin: EdgeInsets.only(bottom: 70),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ticket == null
                                      ? "assets/top_up_done.png"
                                      : "assets/ticket_done.png"))),
                        ),
                        Text(
                          ticket == null ? "Emmm Yummy!" : "Happy Watching!",
                          style: blackTextFont.copyWith(fontSize: 20),
                        ),
                        SizedBox(height: 16),
                        Text(
                          ticket == null
                              ? "You have successfully\ntop up the wallet"
                              : "You have successfully\nbought the ticket",
                          textAlign: TextAlign.center,
                          style: blackTextFont.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Container(
                          height: 45,
                          width: 250,
                          margin: EdgeInsets.only(top: 70, bottom: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              ticket == null ? "My Wallet" : "My Tickets",
                              style: whiteTextFont.copyWith(fontSize: 16),
                            ),
                            onPressed: () {
                              // Navigate to appropriate page
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Discover new movie? ",
                              style: greyTextFont.copyWith(
                                  fontWeight: FontWeight.w400),
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<PageBloc>(context)
                                    .add(GoToMainPage());
                              },
                              child: Text(
                                "Back to Home",
                                style: purpleTextFont,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  : Center(
                      child: SpinKitFadingCircle(
                        color: mainColor,
                        size: 50,
                      ),
                    )),
        ));
  }

  Future<void> processTicketOrder(BuildContext context) async {
    context.read<UserBloc>().add(Purchase(ticket.totalPrice));
    context.read<TicketBloc>().add(BuyTicket(ticket, transaction.userId));

    // Simpan tiket ke database
    await TicketServices.saveTicket(transaction.userId, ticket);

    // Simpan transaksi ke database
    await AppTransactionServices.saveTransaction(transaction);
  }

  Future<void> _processTopUp() async {
    // Logic for top-up processing (future implementation)
  }
}
