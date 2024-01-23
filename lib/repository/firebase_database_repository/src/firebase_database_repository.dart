import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:calculator_admin/repository/repository.dart';

class FirebaseDatabaseRepository {
  FirebaseDatabaseRepository({
    FirebaseDatabase? firebaseDatabase
  }) : _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;
  final FirebaseDatabase _firebaseDatabase;
  
  // user id
  String userID() => FirebaseAuth.instance.currentUser!.uid;

  Future<void> addUsers(String uid, Users users) async {
    try {
      await _firebaseDatabase.ref('users/$uid').set(users.toJson());
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<Users> getUsers(String uid) async {
    try {
      final snapshot = await _firebaseDatabase.ref('users/$uid').get();
      if (snapshot.exists) {
        return Users.fromSnapshot(snapshot);
      } else {
        throw Exception('Something went wrong.');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<Users> getUsersList(String uid) async {
    try {
      final snapshot = await _firebaseDatabase.ref('users').get();
      if (snapshot.exists) {
        return Users.fromSnapshot(snapshot);
      } else {
        throw Exception('Something went wrong.');
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}