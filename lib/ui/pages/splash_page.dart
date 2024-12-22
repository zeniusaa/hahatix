part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 136,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70, bottom: 16),
              child: Text(
                "Waktunya Menonton Tanpa Ribet!",
                style: blackTextFont.copyWith(fontSize: 20),
              ),
            ),
            Text(
              "Rasakan pengalaman baru menonton\nbioskop tanpa antrean",
              style: greyTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            Container(
              width: 250,
              height: 46,
              margin: const EdgeInsets.only(top: 70, bottom: 19),
              child: ElevatedButton(
                child: Text(
                  "Pesan Tiket",
                  style: whiteTextFont.copyWith(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sudah Punya Akun? ",
                  style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<PageBloc>().add(GoToLoginPage());
                  },
                  child: Text(
                    "Login",
                    style: purpleTextFont,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
