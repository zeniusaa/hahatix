part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  WalletPage(this.pageEvent);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(pageEvent);
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
              ),
            ),
            // note: CONTENT
            SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 0),
                child: ListView(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<PageBloc>()
                                  .add(pageEvent); // Konsistensi penggunaan
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) {
                            if (userState is UserLoaded) {
                              return Column(
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  Text(
                                    "My Wallet",
                                    style: blackTextFont.copyWith(fontSize: 20),
                                  ),
                                  // note: ID CARD
                                  buildWalletCard(userState),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Recent Transaction",
                                      style: blackTextFont,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  FutureBuilder(
                                    future:
                                        AppTransactionServices.getTransactions(
                                            userState.user.id),
                                    builder: (_, snapshot) {
                                      if (snapshot.hasData) {
                                        return generateTransactionList(
                                          snapshot.data as List<AppTransaction>,
                                          MediaQuery.of(context).size.width -
                                              2 * defaultMargin,
                                        );
                                      } else {
                                        return SpinKitFadingCircle(
                                          size: 50,
                                          color: mainColor,
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(height: 75),
                                ],
                              );
                            } else {
                              return SizedBox(); // Fallback jika `userState` tidak valid
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // note: BUTTON
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 250,
                height: 46,
                margin: EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Top Up My Wallet",
                    style: whiteTextFont.copyWith(fontSize: 16),
                  ),
                  onPressed: () {
                    context
                        .read<PageBloc>()
                        .add(GoToTopUpPage(GoToWalletPage(pageEvent)));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWalletCard(UserLoaded userState) {
    return Container(
      height: 185,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFF382A74),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CardReflectionClipper(),
            child: Container(
              height: 185,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 18,
                      height: 18,
                      margin: EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFF2CB),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accentColor2,
                      ),
                    ),
                  ],
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: 'IDR ',
                    decimalDigits: 0,
                  ).format(userState.user.balance),
                  style: whiteNumberFont.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: <Widget>[
                    buildCardInfo(
                      "Card Holder",
                      userState.user.name ?? '',
                    ),
                    SizedBox(width: 30),
                    buildCardInfo(
                      "Card ID",
                      userState.user.id.substring(0, 10).toUpperCase(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: whiteTextFont.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
        Row(
          children: <Widget>[
            Text(
              value,
              style: whiteTextFont.copyWith(fontSize: 12),
            ),
            SizedBox(width: 4),
            SizedBox(
              height: 14,
              width: 14,
              child: Image.asset('assets/ic_check.png'),
            ),
          ],
        ),
      ],
    );
  }

  Column generateTransactionList(
      List<AppTransaction> transactions, double width) {
    transactions.sort(
      (transaction1, transaction2) =>
          transaction2.time.compareTo(transaction1.time),
    );

    return Column(
      children: transactions
          .map(
            (transaction) => Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: TransactionCard(transaction, width),
            ),
          )
          .toList(),
    );
  }
}

class CardReflectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 15);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
