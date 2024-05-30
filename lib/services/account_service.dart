import 'package:get/get.dart';

class AccountService extends GetxService{
  RxBool isLogin = false.obs;
  RxBool permissionGranted = false.obs;

  bool isAdmin = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    
  }
  
}