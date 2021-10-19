import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountRepository {
  Future<UserCredential> signInWithGoogle();
}
