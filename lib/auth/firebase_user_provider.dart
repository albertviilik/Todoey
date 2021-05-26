import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TodoeyFirebaseUser {
  TodoeyFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

TodoeyFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TodoeyFirebaseUser> todoeyFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TodoeyFirebaseUser>((user) => currentUser = TodoeyFirebaseUser(user));
