import 'dart:convert';

import 'package:firebase_flutter/models/constants.dart';
import 'package:http/http.dart' as http;

import '../models/note.dart';

class ApiService {
  Future<List<Note>?> getNotes() async {
    print('in');
    try {
      http.Response response = await http
          .get(Uri.parse(Constants.baseUrl + Constants.notesEndPoint));
      var body = json.decode(response.body) as Map<String, dynamic>;
      List<Note> notes = [];
      body.forEach((noteId, noteData) {
        notes.add(Note.fromJson(noteId,noteData));
      });
      return notes;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> postNote(Note note) async {
    return http.post(
        Uri.parse(Constants.baseUrl + Constants.notesEndPoint), // url
        body: jsonEncode(note.toJson()) // body
        );
  }
}
