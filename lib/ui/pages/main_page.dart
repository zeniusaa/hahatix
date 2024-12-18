part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) {
                if (userState is UserLoaded) {
                  return Text(userState.user.name ?? 'No Name');
                } else {
                  return SizedBox();
                }
              },
            ),
            ElevatedButton(
              child: Text("Sign Out"),
              onPressed: () {
                AuthServices.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
