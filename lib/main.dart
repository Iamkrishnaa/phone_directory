import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_directory/app/services/local/auth_service.dart';
import 'package:phone_directory/app/services/local/firebase_service.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseService firebaseService = Get.put(FirebaseService());
  await firebaseService.init();

  Get.put(AuthService());

  FirebaseAuth auth = FirebaseAuth.instance;

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: auth.currentUser != null ? Routes.HOME : AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
