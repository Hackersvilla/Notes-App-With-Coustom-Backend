import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontent/Models/note.dart';
import 'package:frontent/Providers/note_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'addNote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color color = Colors.grey;
  String search_query = "";
  app_bar() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          SizedBox(
            height: 50,
            width: 300,
            child: TextField(
                onChanged: (val) {
                  search_query = val;
                },
                style: const TextStyle(color: Colors.white70),
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintText: "Search..",
                    hintStyle: TextStyle(color: Colors.grey))),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0);
              });
            },
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: const Color(0xff3b3b3b),
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                    child: Icon(Icons.refresh, color: Colors.white))),
          )
        ],
      ),
    );
  }

  grid_view(NoteProvider provider) {
    return (provider.notes.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.search_notes(search_query).length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (0.9 / 0.4), crossAxisCount: 1),
                itemBuilder: (context, index) {
                  Note currentnotes =
                      provider.search_notes(search_query)[index];
                  return GestureDetector(
                    onTap: () {
                      //update
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => AddNote(
                            isUpdate: true,
                            note: currentnotes,
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      //delete
                      provider.deleteNote(currentnotes);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //for title
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                currentnotes.title!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                currentnotes.content!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }))
        : const Center(
            child: Text(
              "No Notes",
              style: TextStyle(color: Colors.white),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    //here we are making an instance of the provider so that we can use it in
    //the provider
    NoteProvider provider = Provider.of<NoteProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff252525),
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => AddNote(
                          isUpdate: false,
                        )));
          },
          child: const Icon(Icons.add, color: Colors.white)),
      backgroundColor: const Color(0xff252525),
      body: (provider.is_loaded == false)
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //Appbar
                    app_bar(),
                    //gridview
                    grid_view(provider)
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
