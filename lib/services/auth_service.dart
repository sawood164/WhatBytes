import 'package:wha_bytes/data/models/user_model.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../data/local_storage.dart';
import 'auth_manager.dart';
import 'firebase_auth_service.dart';

class AuthService {
  static final FirebaseAuthService _firebaseAuth = FirebaseAuthService();

  static Future<firebase_auth.User?> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final firebaseUser = await _firebaseAuth.signUpWithEmailAndPassword(
        email,
        password,
        name,
      );
      
      if (firebaseUser != null) {
        // Create local user
        final user = User(
          email: email,
          password: password,  // Consider not storing password
          name: name,
        );
        
        final userBox = LocalStorage.getUserBox();
        await userBox.put(email, user);
        
        return firebaseUser;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      final firebaseUser = await _firebaseAuth.signInWithEmailAndPassword(
        email,
        password,
      );

      if (firebaseUser != null) {
        // Create local user data if it doesn't exist
        final userBox = LocalStorage.getUserBox();
        User? localUser = userBox.get(email);
        
        if (localUser == null) {
          // Create new local user from Firebase data
          localUser = User(
            email: email,
            password: password,  // Consider encrypting or not storing
            name: firebaseUser.displayName ?? 'User', // Get name from Firebase
          );
          await userBox.put(email, localUser);
        }
        
        await AuthManager.setLoggedIn(email);
        return localUser;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() async {
    await _firebaseAuth.signOut();
    await AuthManager.logout();
  }
} 