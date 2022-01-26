import 'package:flutter/cupertino.dart';
import 'package:frontent/Models/note.dart';
import 'package:frontent/Services/api_service.dart';

class NoteProvider with ChangeNotifier {
  //Provider - simple way to manage the state of our app or of our current
  //page. it is used to not use set state mehtod in our provider.it has three
  //parts 1. chaneNotifier 2.changeNotfirerProvider 3.consumer

  //1.changeNotifier - it is used to change the state of our app and is used to
  //send data to our app to

  //2.changeNotifierProvider - it is used to accept a provider and it is used to
  //initiliaze a data and prpvider.

  //3.consumer - it is used to accept the data from the changeNotifierProvider
  //and it helps to set the data or get the data in the frontent part of the app

  //adding the notes in our provider
  List<Note> notes = [];

  //for checking the loader
  bool is_loaded = true;

  //initstate for provider
  NoteProvider() {
    fetchdata();
  }

  //function to search the notes
  List<Note> search_notes(String search_q) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(search_q.toLowerCase()))
        .toList();
  }

  //function to sort the notes from new to old
  void sortNotes() {
    //sorting the second with first one on basic of date added
    notes.sort(
      (a, b) => b.dateAdded!.compareTo(a.dateAdded!),
    );
  }

  //function used to add notes in our model and send it to api
  void addNote(Note note) {
    //taking the parameter and adding the value of notes to the above notes list
    notes.add(note);
    //sorting notes
    sortNotes();
    //it is used to listen changeNotifierProvider to listen all the data that is
    //in this function
    notifyListeners();
    //adding the note to the databases
    ApiService.addnoteDB(note);
  }

  //fucntion used to update the notes in our model and send it to api
  void updateNote(Note note) {
    //first of all calculate the index where you want to update the notes
    int index =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    //setting the value of index in that note
    notes[index] = note;
    //sorting notes
    sortNotes();
    //notifying listeners
    notifyListeners();
    //adding the note to the databse
    ApiService.addnoteDB(note);
  }

  //function used to deleter the notes in our model and send it to api
  void deleteNote(Note note) {
    //caluculate the index of the element
    int index =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    //removing element in the index
    notes.removeAt(index);
    //sorting notes
    sortNotes();
    //notifying listners
    notifyListeners();
    //remove element from the databases
    ApiService.deletenodeDB(note);
  }

  void fetchdata() async {
    //fetching all the data from api
    notes = await ApiService.fetchdataDB("Hackersvilla776@gmail.com");
    //making loader disable
    is_loaded = false;
    //sorting notes
    sortNotes();
    //changing the ui
    notifyListeners();
  }
}
