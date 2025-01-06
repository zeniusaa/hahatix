part of 'pages.dart';

class ProfilePage extends StatefulWidget{
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
 Widget build(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      context.read<PageBloc>().add(GoToMainPage());

      return true;
    },
    child: Scaffold(
      body: Center(
        child: Text("profile page"),
      ),
    ));
 }
}