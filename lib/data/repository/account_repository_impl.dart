import 'package:ancorio_rp/data/data_service.dart';
import 'package:ancorio_rp/data/entities/account_entity.dart';
import 'package:ancorio_rp/domain/repository/account_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

class AccountRepositoryImpl with DataService implements AccountRepository {
  @override
  String get collection => 'users';

  @override
  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );
      // Triggering the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      // Obtaining the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Creating a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final FirebaseAuth auth = FirebaseAuth.instance;

      // // Once signed in, returning the UserCredential
      final UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );

      final User? user = auth.currentUser;
      final String? uid = userCredential.user?.uid;

      final QuerySnapshot query = await reference
          .where(
            'costumerId',
            isEqualTo: uid,
          )
          .get();
      if (query.docs.isEmpty) {
        final AccountEntity account = AccountEntity(
          customerId: uid!,
          fullName: user?.displayName ?? '',
          email: user?.email ?? '',
          phoneNumber: user?.phoneNumber ?? '',
        );
        await reference.add(account.toJson());
      }
      return userCredential;
    } else {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );
      // Triggering the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtaining the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Creating a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final FirebaseAuth auth = FirebaseAuth.instance;

      // Once signed in, returning the UserCredential
      final UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );

      final User? user = auth.currentUser;
      final String? uid = userCredential.user?.uid;

      final QuerySnapshot query = await reference
          .where(
            'costumerId',
            isEqualTo: uid,
          )
          .get();

      if (query.docs.isEmpty) {
        final AccountEntity account = AccountEntity(
          customerId: uid!,
          fullName: user?.displayName ?? '',
          email: user?.email ?? '',
          phoneNumber: user?.phoneNumber ?? '',
        );
        await reference.add(account.toJson());
      }

      return userCredential;
    }
  }
}
