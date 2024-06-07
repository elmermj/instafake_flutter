import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:instafake_flutter/core/data/models/comment_model.dart';
import 'package:instafake_flutter/core/data/models/post_model.dart';
import 'package:instafake_flutter/core/data/models/post_thumbnail_model.dart';
import 'package:instafake_flutter/core/data/models/suggestion_model.dart';
import 'package:instafake_flutter/core/data/models/user_model.dart';
import 'package:instafake_flutter/core/data/sources/local_post_model_data_source.dart';
import 'package:instafake_flutter/core/data/sources/local_user_model_data_source.dart';
import 'package:instafake_flutter/core/data/sources/remote_post_model_data_source.dart';
import 'package:instafake_flutter/core/data/sources/remote_story_model_data_source.dart';
import 'package:instafake_flutter/core/data/sources/remote_user_model_data_source.dart';
import 'package:instafake_flutter/core/domain/repos/post_model_repository.dart';
import 'package:instafake_flutter/core/domain/repos/story_model_repository.dart';
import 'package:instafake_flutter/core/domain/repos/user_model_repository.dart';
import 'package:instafake_flutter/services/account_service.dart';
import 'package:instafake_flutter/services/user_data_service.dart';
import 'package:http/http.dart' as http;
import 'package:instafake_flutter/utils/log.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:permission_handler/permission_handler.dart';

import 'utils/constants.dart';

// READ ME

// I use GetX because of its perfect ability for dependency injection which makes it easier for me to manage the storage and services.
// The GetService interface has the ability to store value in memory and accessible throughout the application as long as the service class is not terminated                   /next line
// - very useful for clean architecture.
// There are so many Get.put()s being called. That is because I want to create instances in memory so the value will be accessible to the affected classes                      /next line
// - avoiding any kind of repeating initialization which in my honest opinion it will slow down the application.
// For state management, I use Provider as required. Although I still prefer GetX because of the aforementioned reasoning, maybe because I'm not really good at Provider        /next line
// - I can learn and improve my technique once I see a source code from a complex application created fully with Provider.
// For the sake of simplicity, I use Hive as my storage solution. It's pretty quick at loading and saving data. I know data persistence is not required, I just can't help it.  /next line
// - I really care about quality and I want to make sure that my application will be able to run smoothly even after the user closes the application.
// I don't have enough time to generate unit tests as I rely on manual tests for every function, method, or API I created.                                                      /next line
// - I hope that my code is clean and understandable. I will make sure to write unit tests in the future.
// It's more into that no one ever shown me and taught me how to code for unit tests, integration tests, and end-to-end. I still scratch my head everytime I do this            /next line
// - perhaps, if I get accepted, I can learn how to do it properly from better developers and I can improve my skills.


// A bit of myself, I code because I love doing this. It's like playing a grand strategy game like HOI4 or Victoria 3 -- gotta build properly from beginning or lose the end game.

class DependencyInjection {
  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(PostModelAdapter());
    Hive.registerAdapter(PostThumbnailModelAdapter());
    Hive.registerAdapter(SuggestionModelAdapter());
    Hive.registerAdapter(CommentModelAdapter());
    final userBox = await Hive.openBox<UserModel>(METADATA_KEY);
    final postsBox = await Hive.openBox<PostModel>(POST_KEY);
    final postThumbnailsBox = await Hive.openBox<PostThumbnailModel>(POST_THUMBNAILS_KEY);
    final searchSuggestionsBox = await Hive.openBox<SuggestionModel>(SEARCH_SUGGESTIONS_KEY);
    final commentsBox = await Hive.openBox<SuggestionModel>(COMMENTS_KEY);

    http.Client client = http.Client();
    // String token = userBox.get(METADATA_KEY)?.token ?? '';
    //Data Source intances
    Get.put<RemoteUserModelDataSource>(RemoteUserModelDataSource(client));
    Get.put<RemoteStoryModelDataSource>(RemoteStoryModelDataSource(client));
    Get.put<RemotePostModelDataSource>(RemotePostModelDataSource(client, SERVER_URL));
    Get.put<LocalUserModelDataSource>(LocalUserModelDataSource(userBox, searchSuggestionsBox));
    Get.put<LocalPostModelDataSource>(LocalPostModelDataSource(postsBox, postThumbnailsBox, client));

    //storage intances
    Get.put(userBox);
    Get.put(postsBox);
    Get.put(postThumbnailsBox);
    Get.put(searchSuggestionsBox);
    Get.put(commentsBox);

    //service instances
    Get.put(UserDataService(userBox));
    DeviceStatusService accountService = Get.put(DeviceStatusService());

    //repository instances
    Get.put<UserModelRepository>(
      UserModelRepositoryImpl(
        localDataSource: Get.find(), 
        remoteDataSource: Get.find()
      )
    );

    Get.put<PostModelRepository>(
      PostModelRepositoryImpl(
        localDataSource: Get.find(), 
        remoteDataSource: Get.find()
      )
    );

    Get.put<StoryModelRepository>(
      StoryModelRepositoryImple(remoteDataSource: Get.find())
    );

    await requestPermissions(accountService);

  }

  static requestPermissions(DeviceStatusService accountService) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid && accountService.permissionsGranted.value==false){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      int apiLevel = androidInfo.version.sdkInt;
      Log.yellow("API LEVEL ::: $apiLevel");
      if(apiLevel >= 33){
        PermissionStatus storageStatus = await Permission.manageExternalStorage.request();
        PermissionStatus photosStatus = await Permission.photos.request();
        PermissionStatus cameraStatus = await Permission.camera.request();
        PermissionStatus videoStatus = await Permission.videos.request();
        PermissionStatus audioStatus = await Permission.audio.request();
        PermissionStatus mediaStatus = await Permission.mediaLibrary.request();
        PermissionStatus microphoneStatus = await Permission.microphone.request();

        if(
          storageStatus.isDenied &&
          photosStatus.isDenied &&
          cameraStatus.isDenied &&
          videoStatus.isDenied &&
          audioStatus.isDenied &&
          mediaStatus.isDenied &&
          microphoneStatus.isDenied
        ){
          accountService.permissionsGranted.value = false;
        }else {
          accountService.permissionsGranted.value = true;
        }
        Log.yellow("STORAGE STATUS ::: $storageStatus");
        Log.yellow("PHOTOS STATUS ::: $photosStatus"); 
        Log.yellow("CAMERA STATUS ::: $cameraStatus");
        Log.yellow("VIDEO STATUS ::: $videoStatus");
        Log.yellow("AUDIO STATUS ::: $audioStatus");
        Log.yellow("MEDIA STATUS ::: $mediaStatus");
        Log.yellow("MICROPHONE STATUS ::: $microphoneStatus");
        Log.yellow("Permission STATUS ::: ${accountService.permissionsGranted.value}");

      } else {
        PermissionStatus externalStorageStatus = await Permission.manageExternalStorage.request();
        PermissionStatus storageStatus = await Permission.storage.request();
        PermissionStatus microphoneStatus = await Permission.microphone.request();
        PermissionStatus cameraStatus = await Permission.camera.request();

        if(
          externalStorageStatus.isDenied && 
          storageStatus.isDenied &&
          microphoneStatus.isDenied &&
          cameraStatus.isDenied
        ){
          accountService.permissionsGranted.value = false;
        }else {
          accountService.permissionsGranted.value = true;
        }
      }
    }

    // Not tested on IOS
    // if(Platform.isIOS && accountService.permissionsGranted.value==false){
    //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //   if(iosInfo.systemVersion. >= '14.0'){
    //     PermissionStatus photosStatus = await Permission.photos.request();
    //     PermissionStatus cameraStatus = await Permission.camera.request();
    //     PermissionStatus videoStatus = await Permission.videos.request();
    //     PermissionStatus microphoneStatus = await Permission.microphone.request();
    //   } else {
    //     PermissionStatus storageStatus = await Permission.storage.request();
    //     PermissionStatus microphoneStatus = await Permission.microphone.request();
    //   }
    // }
  }

  static autoCleanCachedMedias<T>(){
    
  }

  static bool isJwtExpired(String token) {
    if(token.isEmpty) return true;

    bool isExpired = JwtDecoder.isExpired(token);
    Log.yellow(isExpired.toString());
    return isExpired;
  }

}