import 'dart:convert';

import 'package:frontent/Models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //base url of the api
  static String _baseurl = "https://aqueous-bayou-83936.herokuapp.com/notes";

  //function to add the note to our database backend
  static Future<void> addnoteDB(Note note) async {
    Uri requesturl = Uri.parse(_baseurl + "/add");
    var response = await http.post(requesturl, body: note.toMap());

    print(response.toString());
  }

  //funcion to delete the note to our database
  static Future<void> deletenodeDB(Note note) async {
    Uri requesturl = Uri.parse(_baseurl + "/delete");
    var response = await http.post(requesturl, body: note.toMap());
    print(response.toString());
  }

  //function to get all the notes from the database
  //when the app is restarted

  static Future<List<Note>> fetchdataDB(String email) async {
    Uri requesturl = Uri.parse(_baseurl + "/list");
    var response = await http.post(requesturl, body: {"email": email});
    var decoderesponse = jsonDecode(response.body);

    List<Note> notes = [];
    for (var result in decoderesponse) {
      Note newNote = Note.fromMap(result);
      notes.add(newNote);
    }

    return notes;
  }
}
