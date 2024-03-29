import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String id;
  final String email;
  final String? name;
  final bool isEmailVerified;
  const AuthUser({
    this.name,
    required this.id,
    required this.email,
    required this.isEmailVerified,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        name: user.displayName,
        id: user.uid,
        email: user.email!,
        isEmailVerified: user.emailVerified,
      );
}
