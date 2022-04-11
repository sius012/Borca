import 'package:borca2/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? user;

  registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
      await user!.updateDisplayName(name);
      user = auth.currentUser;
      if (userCredential != null) {
        final docUser = FirebaseFirestore.instance
            .collection('users_detail')
            .doc(user!.uid);

        final dU = Users(
            id_user: user!.uid, id: '', level: "sesepuh", username: "garox");

        final json = dU.toJson();

        await docUser.set(json);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  loginUser({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
    } catch (e) {
      print(e.toString());
    }
  }

  logoutUser() {}
}

class Users {
  String id;
  final String id_user;
  final String username;
  final String level;

  Users({
    this.id = '',
    required this.username,
    required this.level,
    required this.id_user,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_user': id_user,
        'username': username,
        'level': level,
      };
}
