import 'package:hive/hive.dart';
import 'package:instafake_flutter/core/data/models/user_model.dart';
import 'package:instafake_flutter/utils/constants.dart';

class LocalUserModelDataSource {
  final Box<UserModel> userMetadataBox;

  LocalUserModelDataSource(this.userMetadataBox);

  Future<void> saveUserMetadata(UserModel response) async {
    await userMetadataBox.put(METADATA_KEY, response);
  }

  UserModel? getUserMetadata() {
    return userMetadataBox.get(METADATA_KEY);
  }

  Future<void> clearUserMetadata() async {
    await userMetadataBox.delete(METADATA_KEY);
  }
}