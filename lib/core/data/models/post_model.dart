import 'package:hive/hive.dart';

part 'post_model.g.dart';

@HiveType(typeId: 1)
class PostModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String fileUrl;
  @HiveField(3)
  final String fileName;
  @HiveField(4)
  final String caption;
  @HiveField(5)
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.username,
    required this.fileUrl,
    required this.fileName,
    required this.caption,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      username: json['username'],
      fileUrl: json['fileUrl'],
      fileName: json['fileName'],
      caption: json['caption'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  static Future<List<PostModel>> fromJsonList(jsonDecode) {
    if (jsonDecode is List) {
      return Future.value(jsonDecode.map((e) => PostModel.fromJson(e)).toList());
    } else {
      throw Exception('Failed to parse json list');
    }
  }
}
