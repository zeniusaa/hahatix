part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrasionData registrasionData;
  SignUpPage(this.registrasionData);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController retypePasswordcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    namecontroller.text = widget.registrasionData.name;
    emailcontroller.text = widget.registrasionData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSplashPage());
        return true;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 22),
                  height: 56,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            context.read<PageBloc>().add(GoToSplashPage());
                          },
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Create New\nAccount",
                          style: blackTextFont.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  height: 104,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: (widget.registrasionData.profileImage ==
                                    null)
                                ? AssetImage("assets/user_pic.png")
                                    as ImageProvider<Object>
                                : FileImage(
                                        widget.registrasionData.profileImage!)
                                    as ImageProvider<
                                        Object>, // Casting properly
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () async {
                            if (widget.registrasionData.profileImage == null) {
                              widget.registrasionData.profileImage =
                                  await getImage(); // Menggunakan getimage untuk memilih gambar
                              setState(() {});
                            } else {
                              widget.registrasionData.profileImage = null;
                              setState(() {});
                            }
                          },
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    (widget.registrasionData.profileImage ==
                                            null)
                                        ? "assets/btn_add_photo.png"
                                        : "assets/btn_del_photo.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36),
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Full Name",
                    hintText: "Full Name",
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Email",
                    hintText: "Email",
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Password",
                    hintText: "Password",
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: retypePasswordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Confirm Password",
                    hintText: "Confirm Password",
                  ),
                ),
                SizedBox(height: 30),
                FloatingActionButton(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white, // Warna ikon tombol
                  ),
                  backgroundColor: mainColor,
                  elevation: 0,
                  onPressed: () {
                    if (!(namecontroller.text.trim() != "" &&
                        emailcontroller.text.trim() != "" &&
                        passwordcontroller.text.trim() != "" &&
                        retypePasswordcontroller.text.trim() != "")) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Silahkan isi dulu semua kolom",
                      )..show(context);
                    } else if (passwordcontroller.text !=
                        retypePasswordcontroller.text) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message:
                            "Kata sandi tidak cocok dengan yang dikonfirmasi",
                      )..show(context);
                    } else if (passwordcontroller.text.length < 6) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Panjang password minimal 6 karakter",
                      )..show(context);
                    } else if (!EmailValidator.validate(emailcontroller.text)) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Alamat email tidak sesuai format",
                      )..show(context);
                    } else {
                      widget.registrasionData.name = namecontroller.text;
                      widget.registrasionData.email = emailcontroller.text;
                      widget.registrasionData.password =
                          passwordcontroller.text;

                      context
                          .read<PageBloc>()
                          .add(GoToPreferencePage(widget.registrasionData));
                    }
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
