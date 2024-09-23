import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  var email = ''.obs;
  var newPassword = ''.obs;

  FirebaseAuth _auth = FirebaseAuth.instance;

  // Send Password Reset Email
  void sendPasswordResetEmail() async {
    try {
      await _auth.sendPasswordResetEmail(email: email.value);
      Get.snackbar('Success', 'Password reset email sent');
      Get.toNamed('/reset-password'); // Navigate to Reset Password page
    } catch (e) {
      Get.snackbar('Error', 'Failed to send password reset email');
    }
  }

  // Reset Password
  void resetPassword() async {
    try {
      User? user = _auth.currentUser;
      await user?.updatePassword(newPassword.value);
      Get.snackbar('Success', 'Password has been updated');
      Get.offAllNamed('/login'); // Redirect to login page
    } catch (e) {
      Get.snackbar('Error', 'Failed to reset password');
    }
  }
}
