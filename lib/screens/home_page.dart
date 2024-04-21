import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> users = [];
  bool isLoading = true;


  Future<void> fetchData() async {
    var client = http.Client();
    var response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      print("Success");
      var jsonString = response.body;
      var jsonData = jsonDecode(jsonString);
      if (jsonData != null && jsonData.isNotEmpty) {
        // Null check
        for (var item in jsonData) {
          users.add(UserModel.fromJson(item));
        }
        setState(() {
          isLoading = false; // Set isLoading to false after fetching products
        });
      }
    } else {
      setState(() {
        isLoading = false; // Set isLoading to false in case of error
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Fetching data from API",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
          centerTitle: true,
          backgroundColor: Colors.blue.withOpacity(.6),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
          physics:BouncingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(

                        title: Row(

                          children: [
                            const Expanded(
                                flex: 1,
                                child: Text("Title :",style: TextStyle(fontWeight:FontWeight.w600),)),
                            Expanded(
                                flex: 4,
                                child: Text(users[index].title)),
                          ],
                        ),

                        subtitle: Row(

                          children: [
                            const Expanded(
                              flex: 1,
                                child: Text("Body :",style: TextStyle(fontWeight:FontWeight.w600,color: Colors.blue),)),
                            Expanded(
                                flex: 4,
                                child: Text(users[index].body,style: TextStyle(color: Colors.blue),)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
