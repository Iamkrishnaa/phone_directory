import 'package:get/get.dart';
import 'package:phone_directory/app/services/local/auth_service.dart';

class LoginController extends GetxController {
  Future loginWithGoogle() async {
    AuthService authService = Get.find();
    await authService.loginwithGoogle();
  }
}
