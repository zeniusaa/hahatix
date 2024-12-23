part of 'models.dart';

class RegistrasionData {
  String name;
  String email; 
  String password;
  List<String> selectedGenres;
  String selectedLang;
  File? profileImage; // Jadikan nullable dengan tanda '?'

  RegistrasionData(
    {this.name = "",
    this.email = "",
    this.password = "",
    this.selectedGenres = const [],
    this.selectedLang = "",
    this.profileImage,}
  );
}