// ignore_for_file: constant_identifier_names, non_constant_identifier_names

// const SERVER_URL = "http://10.200.20.80:8080/"; //OFFICE IP V4
const SERVER_URL = "http://192.168.0.103:8080/"; //HOME SERVER IP V4
// const SERVER_URL = "http://192.168.0.1:8888/"; //HOME SERVER DEFAULT GATEWAY
// const SERVER_URL = "http://localhost:8080/"; 
const METADATA_KEY = 'metadata';
const POST_KEY = 'posts';
const MEDIA_KEY = 'medias';
const POST_THUMBNAILS_KEY = 'post_thumbnails';
const SEARCH_SUGGESTIONS_KEY = 'suggestions';
const COMMENTS_KEY = 'comments';
MEDIA_DIRECTORY (String dirPath, String filename){
  return '$dirPath/medias/$filename';
}

Map<String, String> DEFAULT_HEADER(String token){
  return {
    'Authorization': token,
  };
}
const DEFAULT_HEADER_NON_TOKEN = {
  'Content-Type': 'application/json',
};