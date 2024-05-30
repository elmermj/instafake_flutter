import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:instafake_flutter/core/data/models/user_model.dart';
import 'package:instafake_flutter/core/data/sources/local_user_model_data_source.dart';
import 'package:instafake_flutter/core/data/sources/remote_user_model_data_source.dart';
import 'package:instafake_flutter/core/domain/repos/user_model_repositories.dart';
import 'package:instafake_flutter/services/account_service.dart';
import 'package:instafake_flutter/services/user_data_service.dart';
import 'package:http/http.dart' as http;
import 'package:instafake_flutter/utils/log.dart';
import 'package:permission_handler/permission_handler.dart';

import 'utils/constants.dart';

class DependencyInjection {
  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    final userBox = await Hive.openBox<UserModel>(METADATA_KEY);
    http.Client client = http.Client();

    //Data Source
    Get.put<RemoteUserModelDataSource>(RemoteUserModelDataSource(client));
    Get.put<LocalUserModelDataSource>(LocalUserModelDataSource(userBox));

    //storage
    Get.put(userBox);

    //service
    Get.put(UserDataService(userBox));
    AccountService accountService = Get.put(AccountService());

    //repository
    Get.put<UserModelRepository>(
      UserModelRepositoryImpl(
        Get.find(), 
        Get.find()
      )
    );

    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      accountService.permissionGranted.value = true;
      Log.green("Storage permission granted.");
    } else {
      accountService.permissionGranted.value = false;
      Log.red("Storage permission denied.");
    }
  }
}