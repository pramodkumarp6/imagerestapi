import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/Photo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  List<Photo> photosList = [];


  Future<List<Photo>> getUserApi() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
     var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photo photo = Photo(title:i['title'],url:i['url']);
        photosList.add(photo);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ImageView"),


      ),
      body: Column(

          children: [
            Expanded(
            child: FutureBuilder(
             future: getUserApi(),
             builder: (context,AsyncSnapshot<List<Photo>>snapshot){
               return ListView.builder(
                   itemCount: photosList.length,
                   itemBuilder: (context ,index){
                 return ListTile(
                   leading:CircleAvatar(
                    backgroundImage:NetworkImage(snapshot.data![index].url.toString())
                   ),

                   title: Text (snapshot.data![index].title.toString()),
                 );
               });
            })
            )
          ],

        )
      );

  }
}
