import 'dart:convert';

import 'package:http_nodejs/models/api_response.dart';
import 'package:http_nodejs/models/note_capturing.dart';
import 'package:http_nodejs/models/user.dart';
import 'package:http/http.dart' as http;

// The service responsible for networking requests
class Api {
  static const endpoint = 'http://localhost:3000';

  var client = new http.Client();

  // this allows user to add sign up info
  Future<ApiResponseModel> postSignup({User body}) async {
    ApiResponseModel _apiResponseModel;
    var response = await client.post('$endpoint/user/signup',
        body: json.encode(body.toJson()));
    if (response.statusCode == 422) {
      return _apiResponseModel =
          ApiResponseModel.fromJson(json.decode(response.body));
    }
    if (response.statusCode == 500) {
      return _apiResponseModel =
          ApiResponseModel.fromJson(json.decode(response.body));
    }
    if (response.statusCode == 201) {
      ApiResponseModel _apiResponse = ApiResponseModel(isSent: true);
      _apiResponseModel = _apiResponse;
      return _apiResponse;
    }
    return _apiResponseModel;
  }

  // this allows user to log into the database
  Future<ApiResponseModel> postLogin({User body}) async {
    ApiResponseModel _apiResponseModel;
    var response = await client.post('$endpoint/user/login',
        body: json.encode(body.toJson()));
    if (response.statusCode == 404) {
      return _apiResponseModel =
          ApiResponseModel.fromJson(json.decode(response.body));
    }
    if (response.statusCode == 401) {
      return _apiResponseModel =
          ApiResponseModel.fromJson(json.decode(response.body));
    }
    if (response.statusCode == 500) {
      return _apiResponseModel =
          ApiResponseModel.fromJson(json.decode(response.body));
    }
    if (response.statusCode == 201) {
      _apiResponseModel = ApiResponseModel.fromJson(json.decode(response.body));
      return _apiResponseModel;
    }
    return _apiResponseModel;
  }

  //this allows user to correct login password for database access
  Future<ApiResponseModel> patchUser({User body}) async {
    ApiResponseModel _apiResponseModel;
    var response = await client.patch('$endpoint/user/update/${body.email}',
        body: json.encode(body.toJson()));
    if (response.statusCode == 200) {
      ApiResponseModel _apiResponse = ApiResponseModel(isSent: true);
      _apiResponseModel = _apiResponse;
      return _apiResponse;
    }
    if (response.statusCode == 500) {
      return _apiResponseModel =
          ApiResponseModel.fromJson(json.decode(response.body));
    }
    return _apiResponseModel;
  }

  // allows user to save a new note to the database
  Future<ApiResponseModel> postNote({NoteCapturingModel body}) async {
    ApiResponseModel _apiResponseModel;
    var response = await client.post('$endpoint/notes',
        headers: {"Authorization": "Bearer ${body.token}"},
        body: json.encode(body.toJson()));
    if (response.statusCode == 201) {
      ApiResponseModel _apiResponse = ApiResponseModel(isSent: true);
      _apiResponseModel = _apiResponse;
      return _apiResponse;
    }
    if (response.statusCode == 500) {
      return _apiResponseModel =
          ApiResponseModel.fromJson(json.decode(response.body));
    }
    return _apiResponseModel;
  }

  // user must receive all the notes from database
  Future<List<NoteCapturingModel>> getNotes({NoteCapturingModel body}) async {
    var notes = List<NoteCapturingModel>();
    var response = await client.get(
      '$endpoint/notes/${body.userEmail}',
      headers: {"Authorization": "Bearer ${body.token}"},
    );
    notes = [];
    if (response.statusCode == 200) {
      //parse into list
      var parsed = json.decode(response.body) as List<dynamic>;
      // loop to convert each item to Note
      for (var note in parsed) {
        notes.add(NoteCapturingModel.fromJson(note));
      }
    }
    if (response.statusCode == 500) {
      NoteCapturingModel _singleNote = NoteCapturingModel(
          title: 'Server Failed', description: 'Ploblem being resolved');
      notes.add(_singleNote);
    }
    return notes;
  }

  // allows user to update the note
  Future<ApiResponseModel> patchNote({NoteCapturingModel body}) async {
    ApiResponseModel _apiResponseModel;
    var response = await client.patch(
        '$endpoint/notes/update/${body.id.toString()}',
        headers: {"Authorization": "Bearer ${body.token}"},
        body: json.encode(body.toJson()));
    if (response.statusCode == 200) {
      ApiResponseModel _apiResponse = ApiResponseModel(isSent: true);
      _apiResponseModel = _apiResponse;
      return _apiResponse;
    }
    if (response.statusCode == 500) {
      return _apiResponseModel =
          ApiResponseModel.fromJson(json.decode(response.body));
    }
    return _apiResponseModel;
  }

  // allows one note at a time delete
  Future<ApiResponseModel> deleteNote({NoteCapturingModel body}) async {
    ApiResponseModel _apiResponseModel;
    var response = await client.patch(
        '$endpoint/notes/delete/${body.id.toString()}',
        headers: {"Authorization": "Bearer ${body.token}"});
    if (response.statusCode == 200) {
      ApiResponseModel _apiResponse = ApiResponseModel(isSent: true);
      _apiResponseModel = _apiResponse;
      return _apiResponse;
    }
    if (response.statusCode == 500) {
      return _apiResponseModel =
          ApiResponseModel.fromJson(json.decode(response.body));
    }
    return _apiResponseModel;
  }
}
