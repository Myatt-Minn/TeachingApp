import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:teamx/app/data/user.model.dart';

class UseraccountsController extends GetxController {
  var userList = <UserModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      var loadedUsers = querySnapshot.docs
          .map((doc) => UserModel.fromDocumentSnapshot(doc))
          .toList();

      userList.assignAll(loadedUsers); // Update the observable list
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> deleteUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .delete();
      userList.remove(user);
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<void> editUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .update(user.toJson());
      fetchUsers(); // Refresh the user list after edit
    } catch (e) {
      print('Error editing user: $e');
    }
  }
}
