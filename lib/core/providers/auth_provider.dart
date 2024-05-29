import 'package:flutter/material.dart';
import 'package:instafake_flutter/utils/enums/entry_state.dart';

class AuthProvider extends ChangeNotifier {

  String username;

  EntryState state = EntryState.register;

  AuthProvider({this.username = "Mapp"});
  
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
    username = newUsername;
    notifyListeners();
  }

  void changeEntryState({required EntryState newEntryState}) {
    state = newEntryState;
    notifyListeners();
  }

  commitEmailRegistration() {}

  commitEmailLogin() {}
}