import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_faces/auth/models/models.dart';

extension FirebaseAuthUserExtension on firebase_auth.User {
  User get toUser => User(
        id: uid,
        email: email,
        name: displayName,
        photo: photoURL,
      );
}
