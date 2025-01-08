import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:hahatix/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hahatix/extensions/extensions.dart';
import 'package:hahatix/shared/shared.dart';
import 'package:http/http.dart' as http;

part 'firebase_options.dart';
part 'auth_services.dart';
part 'user_services.dart';
part 'movie_services.dart';
part 'ticket_services.dart';
part 'app_transaction_services.dart';
