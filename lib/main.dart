

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main()
{
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url="https://swapi.dev/api/people/";
  List data;

  @override
  void initState() {

    this.getJsonData();


    super.initState();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept":"application/json"}
    );
    
    print(response.body);
    
    setState(() {
      var convertDataToJson=json.decode(response.body);

      data=convertDataToJson['results'];
    });

    return "Sucess";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Retrive Json via HTTP Get"),
      ),

      body: new ListView.builder(
        itemCount: data== null ? 0 : data.length,
        itemBuilder: (BuildContext context,int index){
          return new Container(
            child: new Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  new Card(
                    child: new Container(
                      child: new Text(data[index]['name']),
                      padding: EdgeInsets.all(20),
                    ),
                  )

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


