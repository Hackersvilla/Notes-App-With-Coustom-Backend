import 'package:flutter/material.dart';
import 'package:frontent/Models/note.dart';
import 'package:frontent/Providers/note_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNote extends StatefulWidget {
  bool isUpdate;
  Note? note;
  AddNote({Key? key, required this.isUpdate, this.note}) : super(key: key);
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  FocusNode focusnode = FocusNode();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();

  //adding notes in the app
  void addnote() {
    Note note = Note(
        id: const Uuid().v1(),
        email: "Hackersvilla776@gmail.com",
        title: titlecontroller.text,
        content: contentcontroller.text,
        dateAdded: DateTime.now());
    Provider.of<NoteProvider>(context, listen: false).addNote(note);
    Navigator.pop(context);
  }

  //updating notes in the app
  void updatenote() {
    widget.note!.title = titlecontroller.text;
    widget.note!.content = contentcontroller.text;
    widget.note!.dateAdded = DateTime.now();
    Provider.of<NoteProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    if (widget.isUpdate) {
      titlecontroller.text = widget.note!.title!;
      contentcontroller.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              if (widget.isUpdate) {
                //update the data
                updatenote();
              } else {
                //adding notes
                addnote();
              }
            },
            child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.check, color: Colors.white)),
          ),
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "New Note",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.lato().fontFamily,
          ),
        ),
      ),
      backgroundColor: const Color(0xff252525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //for title of
              TextField(
                controller: titlecontroller,
                autofocus: (widget.isUpdate == true) ? false : true,
                onSubmitted: (val) {
                  if (val != "") {
                    focusnode.requestFocus();
                  }
                },
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: GoogleFonts.lato().fontFamily,
                    fontWeight: FontWeight.w800),
                decoration: const InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    border: InputBorder.none),
              ),
              const SizedBox(
                height: 10,
              ),
              //for content
              Expanded(
                child: TextField(
                  controller: contentcontroller,
                  maxLines: null,
                  focusNode: focusnode,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.w300),
                  decoration: const InputDecoration(
                      hintText: "Content",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
