import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instafake_flutter/core/data/models/user_model.dart';
import 'package:instafake_flutter/core/domain/repos/user_model_repository.dart';
import 'package:instafake_flutter/core/domain/usecases/login_usecase.dart';
import 'package:instafake_flutter/services/user_data_service.dart';
import 'package:instafake_flutter/utils/enums/entry_state.dart';

class AuthProvider extends ChangeNotifier {
  final UserModelRepository _userModelRepository;
  EntryState state = EntryState.login;
  UserModel? user;
  AuthProvider({required UserModelRepository userModelRepository}): _userModelRepository = userModelRepository;
  
  ValueNotifier<String?> emailErrorNotifier = ValueNotifier<String?>(null);
  ValueNotifier<String?> passwordErrorNotifier = ValueNotifier<String?>(null);

  void changeEmailErrorNotifierValue ({required String? newError}) {
    emailErrorNotifier.value = newError;
    notifyListeners();
  }

  void changePasswordErrorNotifierValue ({required String? newError}) {
    passwordErrorNotifier.value = newError;
    notifyListeners();
  }

  void changeUsername({required String newUsername}) async {
    notifyListeners();
  }

  void changeEntryState({required EntryState newEntryState}) {
    state = newEntryState;
    notifyListeners();
  }

  commitEmailRegistration(){}

  commitEmailLogin({required String username, required String password}) async {
    var result = await LoginUseCase(_userModelRepository).login(username, password);
    result.fold(
      (result){
        Get.snackbar('Login Failed', result.toString());
      },
      (result){
        Get.snackbar('Login Success', 'Logged in successfully');
        Get.find<UserDataService>().userModel = result;
      }
    );

  }

  getMetadata(){

  }
}