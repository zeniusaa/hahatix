part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subtitle;
  final int discount;

  Promo(this.title, this.subtitle, this.discount);

  @override
  List<Object> get props => [title, subtitle, discount];
}

List<Promo> dummyPromo = [
  Promo("Student Holiday", "Maximal of 2 people", 50),
  Promo("Family Club", "Minimun 3 people", 30),
  Promo("Subsciption Promo", "Minimun 1 year", 30),
];
