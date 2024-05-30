import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instafake_flutter/core/data/models/user_model.dart';
import 'package:instafake_flutter/core/providers/auth_provider.dart';
import 'package:instafake_flutter/services/user_data_service.dart';
import 'package:instafake_flutter/utils/log.dart';
import 'package:provider/provider.dart';

class HomeTimelineScreen extends StatelessWidget {
  HomeTimelineScreen({super.key});

  final userService = Get.find<UserDataService>();

  @override
  Widget build(BuildContext context) {
    UserModel? userData = userService.userModel;
    Log.green("METADATA NAME ::: ${userData?.realname}");
    var provider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${userData?.realname} Timeline",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        )
      ),
      body: Center(
        child: Text(
          "${userData?.realname} Timeline",
        ),
      ),
    );
  }
}