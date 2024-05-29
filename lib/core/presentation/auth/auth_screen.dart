import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instafake_flutter/core/providers/auth_provider.dart';
import 'package:instafake_flutter/utils/enums/entry_state.dart';
import 'package:instafake_flutter/widgets/custom_card_widget.dart';
import 'package:instafake_flutter/widgets/custom_text_field.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditController = TextEditingController();
  final TextEditingController emailConfirmEditController = TextEditingController();
  final TextEditingController passwordEditController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(0, 0.6),
            child: switchState(context.watch<AuthProvider>().state, context),
          )
        ],
      ),
    );
  }

  Widget switchState(EntryState state, BuildContext context){
    switch(state){
      case EntryState.register:
        return CustomCardWidget(
          child: ListView(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            children: [
              CustomTextField(
                labelText: "Name",
                controller: nameEditingController,
              ),
              CustomTextField(
                labelText: "Email",
                controller: emailEditController,
              ),
              CustomTextField(
                labelText: "Confirm Email",
                controller: emailConfirmEditController,
                onChanged: (text) {
                  if (text != emailEditController.text) {
                    context.watch<AuthProvider>().changeEmailErrorNotifierValue(newError: "Emails do not match");
                  } else {
                    context.watch<AuthProvider>().changeEmailErrorNotifierValue(newError: null);
                  }
                },
                errorNotifier: context.watch<AuthProvider>().emailErrorNotifier,
              ),
              CustomTextField(
                labelText: "Password",
                controller: passwordEditController,
                obscureText: true,
              ),
              CustomTextField(
                labelText: "Confirm Password",
                controller: passwordConfirmController,
                onChanged: (text) {
                  if (text != passwordEditController.text) {
                    context.watch<AuthProvider>().changePasswordErrorNotifierValue(newError: "Passwords do not match");
                  } else {
                    context.watch<AuthProvider>().changePasswordErrorNotifierValue(newError: null);
                  }
                },
                errorNotifier: context.watch<AuthProvider>().passwordErrorNotifier,
              ),
              ElevatedButton(
                onPressed: () => context.watch<AuthProvider>().commitEmailRegistration(),
                child: const Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  context.watch<AuthProvider>().changeEntryState(newEntryState: EntryState.login);
                },
                child: Text(
                  "Or login with Email.",
                  style: TextStyle(
                    color: Get.theme.colorScheme.surface,
                  ),
                ),
              ),
            ],
          )
        );
      case EntryState.login:
        return CustomCardWidget(
          child: ListView(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            children: [
              CustomTextField(
                labelText: "Email",
                controller: emailEditController
              ),
              CustomTextField(
                labelText: "Password",
                controller: passwordEditController,
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextButton(
                      onPressed: (){
                        context.watch<AuthProvider>().changeEntryState(newEntryState: EntryState.login);
                      }, 
                      child: Row(
                        children: [
                          Icon(LucideIcons.chevronLeft, color: Get.theme.colorScheme.surface,),
                          Text(
                            "Back to Google Login",
                            style: TextStyle(
                              color: Get.theme.colorScheme.surface,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: ()=>context.watch<AuthProvider>().commitEmailLogin(),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Get.theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: (){
                  context.watch<AuthProvider>().changeEntryState(newEntryState: EntryState.register);
                }, 
                child: Text(
                  "Don't have an account? Register here.",
                  style: TextStyle(
                    color: Get.theme.colorScheme.surface,
                  ),
                )
              )
            ],
          ),
        );
      default:
        return const Text('Error');
    }
  }
}