part of 'models.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> TheaterName = [
  Theater("CGV 23 Paskal Hyper Square"),
  Theater("CGV Paris Van Java"),
  Theater("CGV Metro Indah Mall"),
  Theater("XXI Cihampelas Walk"),
  Theater("XXI Bandung Trade Center"),
  Theater("XXI Summarecon Bandung"),
  Theater("XXI Ubertos")
];
