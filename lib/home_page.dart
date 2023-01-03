import 'dart:convert';
import 'package:complexgetapis/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> userList = [];
  // list of object with object[{{}{}}{}] ei types
  Future<List<UserModel>> getComplexApis() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      userList.clear();
      for (Map i in data) {
        userList.add(UserModel.fromJson(i as Map<String, dynamic>));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getComplexApis(),
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (ctx, i) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data![i].name.toString(),
                            style: TextStyle(
                                fontSize: 13, color: Colors.orangeAccent[800]),
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data![i].email.toString(),
                            style: TextStyle(
                                fontSize: 13, color: Colors.orangeAccent[800]),
                          ),
                          Text(
                            'City',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data![i].address!.city.toString(),
                            style: TextStyle(
                                fontSize: 13, color: Colors.orangeAccent[800]),
                          ),
                          Text(
                            'Lat',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data![i].address!.geo!.lat.toString(),
                            style: TextStyle(
                                fontSize: 13, color: Colors.orangeAccent[800]),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
