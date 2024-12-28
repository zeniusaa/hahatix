import 'dart:io';
import 'package:hahatix/bloc/blocs.dart';
import 'package:hahatix/services/services.dart';
import 'package:hahatix/ui/widgets/widgets.dart';
import 'package:hahatix/shared/shared.dart';
import 'package:hahatix/bloc/theme_bloc.dart';
import 'package:hahatix/models/models.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

part 'sign_in_page.dart';
part 'wrapper.dart';
part 'main_page.dart';
part 'splash_page.dart';
part 'movie.page.dart';
part 'sign_up_page.dart';
part 'preference_page.dart';

Future<File?> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    return File(image.path);
  } else {
    return null; // Jika pengguna membatalkan pemilihan gambar
  }
}
