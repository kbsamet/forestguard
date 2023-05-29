import 'package:forestguard/util/consts.dart';
import "package:http/http.dart" as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

Future<Response> sendGetRequest(
    String endpoint, Map<String, dynamic>? params) async {
  const storage = FlutterSecureStorage();
  //String? value = await storage.read(key: "auth");

  var resp = await http.get(
      Uri.https(
        apiUrl,
        endpoint,
      ),
      headers: {
        // "Authorization": value!,
        "Content-Type": "application/json",
        "Accept": "application/json"
      });
  return resp;
}

Future<Map<String, dynamic>> sendPostRequest(
    String endpoint, Map<String, dynamic> body) async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: "auth");

  var resp = await http.post(
      Uri.http(
        apiUrl,
        endpoint,
      ),
      body: body,
      headers: {
        "Authorization": value!,
        "Content-Type": "application/json",
        "Accept": "application/json"
      });

  return resp.body as Map<String, dynamic>;
}

Future sendAuthorizationRequest(String username, String password) async {
  var resp = await http.post(
      Uri.http(
        apiUrl,
        "/login",
      ),
      body: {
        "username": username,
        "password": password,
      },
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      });
}
