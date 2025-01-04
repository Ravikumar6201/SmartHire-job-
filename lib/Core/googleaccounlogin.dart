import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      // clientId:
      //     "547830999592-heg6lemeta9giptlfr78kqi2ojis8rhu.apps.googleusercontent.com",

      );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // Sign-In canceled by user
        return null;
      }

      // Obtain the authentication details from the sign-in process
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential for Firebase Authentication
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Return the Firebase user
      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  // Sign out from Google
  Future<void> signOut() async {
    try {
      await _auth.signOut(); // Sign out from Firebase
      await _googleSignIn.signOut(); // Sign out from Google
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
