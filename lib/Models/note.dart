//model creation for the app for all the notes data from our api

class Note {
  //define all the parameters that i have given in my api
  String? id;
  String? email;
  String? title;
  String? content;
  DateTime? dateAdded;

  //simple constructor for making these notes
  Note({
    this.id,
    this.email,
    this.title,
    this.content,
    this.dateAdded,
  });

  //factory - create a single instance of the class means it will create the
  // object ones

  //this function is taking the daa as a json and making a single object from
  //that data

  //the data should be of the type string and the name of the data or where we are
  //storing this data is called map

  //map is like dictonary and json in nodejs
  //fetching the data from api
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map["id"],
      email: map["email"],
      title: map["title"],
      content: map["content"],
      //tryparse - converting the string to the date time format
      //and if the output by chance has nothing then it will be converted into null
      dateAdded: DateTime.tryParse(map["dateadded"]),
    );
  }

  //function is doing is that it is creating a map format of the data
  //creating the map from the data
  //sending data to api
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "title": title,
      "content": content,
      //converting the dateadded to a date fromat string so that our api can understand it correctly
      "dateadded": dateAdded!.toIso8601String()
    };
  }
}
