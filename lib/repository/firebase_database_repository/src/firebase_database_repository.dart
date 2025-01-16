import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:calculator_admin/repository/repository.dart';

class FirebaseDatabaseRepository {
  FirebaseDatabaseRepository({
    FirebaseDatabase? firebaseDatabase
  }) : _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;
  final FirebaseDatabase _firebaseDatabase;
  
  // USER ID
  String userID() => FirebaseAuth.instance.currentUser!.uid;

  // ADD USERS
  Future<void> addUsers(String uid, Users users) async {
    try {
      await _firebaseDatabase.ref('users/$uid').set(users.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  // GET SPECIFIC USER
  Future<Users> getUsers(String uid) async {
    try {
      final snapshot = await _firebaseDatabase.ref('users/$uid').get();
      if (snapshot.exists) {
        return Users.fromSnapshot(snapshot);
      } else {
        throw Exception('User not found.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // GET USERS LIST
  Future<Users> getUsersList(String uid) async {
    try {
      final snapshot = await _firebaseDatabase.ref('users').get();
      if (snapshot.exists) {
        return Users.fromSnapshot(snapshot);
      } else {
        throw Exception('Empty.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // GET USERS LIST STREAM
  Stream<List<Users>> getUsersListStream() {
    return _firebaseDatabase.ref('users')
    .onValue
    .map((event) {
      List<Users> usersList = [];

      if (event.snapshot.exists) {
        final snapshotValues = event.snapshot.value as Map<dynamic, dynamic>;

        snapshotValues.forEach((key, values) {
          Users users = Users.fromSnapshot(event.snapshot.child(key));
          usersList.add(users);
        });
      }
      
      return usersList;
    }).handleError((error) {
      return [];
    });
  }

  // UPDATE USER
  Future<void> updateUsers(String id, DateTime expiry) async {
    try {
      final now = DateTime.now();
      await _firebaseDatabase.ref('users/$id')
      .update({
        'expiry': expiry.millisecondsSinceEpoch,
        'updated_at': now.millisecondsSinceEpoch
      });
    } catch (e) {
      throw('Error updating expiry: $e');
    }
  }
}