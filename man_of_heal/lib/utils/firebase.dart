import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

final Future<FirebaseApp> firebaseInitialization = !kIsWeb
    ? Firebase.initializeApp()
    : Firebase.initializeApp(
        options: FirebaseOptions(
        apiKey: "AIzaSyBOCtevea41bUu36eeROkoCDVGIJE8q3aw",
        appId: "1:552953459310:web:d2f2bc60a0c8cf1a9e6c7f",
        messagingSenderId: "552953459310",
        projectId: "manofheal-app",
      ));
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
