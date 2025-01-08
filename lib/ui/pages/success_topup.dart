part of 'pages.dart';

class SuccessTopUpPage extends StatelessWidget {
  final AppTransaction transaction;

  SuccessTopUpPage(this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: FutureBuilder(
          future: _processTopUp(context),
          builder: (_, snapshot) =>
              (snapshot.connectionState == ConnectionState.done)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 150,
                          margin: EdgeInsets.only(bottom: 70),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/top_up_done.png"),
                            ),
                          ),
                        ),
                        Text(
                          "Emmm Yummy!",
                          style: blackTextFont.copyWith(fontSize: 20),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "You have successfully\ntop up the wallet",
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
                              "My Wallet",
                              style: whiteTextFont.copyWith(fontSize: 16),
                            ),
                            onPressed: () {
                              // Navigate to "My Wallet" page
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
                            ),
                          ],
                        ),
                      ],
                    )
                  : Center(
                      child: SpinKitFadingCircle(
                        color: mainColor,
                        size: 50,
                      ),
                    ),
        ),
      ),
    );
  }

  Future<void> _processTopUp(BuildContext context) async {
    context.read<UserBloc>().add(TopUp(transaction.amount));

    await AppTransactionServices.saveTransaction(transaction);
  }
}
