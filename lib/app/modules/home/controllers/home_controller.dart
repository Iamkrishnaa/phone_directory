import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:phone_directory/app/routes/app_pages.dart';
import 'package:phone_directory/app/services/local/auth_service.dart';

class HomeController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getPhoneDirectoryCollectionReference() {
    return firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("phone_directory");
  }

  Future addPhoneDirectory(Map<String, dynamic> data) async {
    try {
      await getPhoneDirectoryCollectionReference().add(data);
    } catch (e) {
      e.printError();
    }
  }

  Future updatePhoneDirectory(
    Map<String, dynamic> data,
    String documentId,
  ) async {
    try {
      await getPhoneDirectoryCollectionReference().doc(documentId).update(data);
    } catch (e) {
      e.printError();
    }
  }

  Future deletePhoneDirectory(String documentId) async {
    try {
      await getPhoneDirectoryCollectionReference().doc(documentId).delete();
    } catch (e) {
      e.printError();
    }
  }

  Stream<QuerySnapshot> get phoneDirectoryStream =>
      getPhoneDirectoryCollectionReference().snapshots();

  signout() async {
    AuthService authService = Get.find();
    await authService.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
