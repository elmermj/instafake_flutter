// ignore_for_file: constant_identifier_names, non_constant_identifier_names

const SERVER_URL = "http://10.200.20.80:8080/";

const METADATA_KEY = 'metadata';

const POST_KEY = 'posts';

const MEDIA_KEY = 'medias';

Map<String, String> DEFAULT_HEADER(String token){
  return {
    'Authorization': 'Bearer $token',
  };
}

const DEFAULT_HEADER_NON_TOKEN = {
  'Content-Type': 'application/json',
};