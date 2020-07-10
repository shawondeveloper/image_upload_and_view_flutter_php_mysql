import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AllPerson extends StatefulWidget {
  @override
  _AllPersonState createState() => _AllPersonState();
}

class _AllPersonState extends State<AllPerson> {
  Future getPerson() async {
    var url = 'http://192.168.1.101/image_upload_php_mysql/view.php';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Php Mysql Crud Using Flutter'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: FutureBuilder(
        future: getPerson(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount:
                      snapshot.data.length == null ? 0 : snapshot.data.length,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        title: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                              "http://192.168.1.101/image_upload_php_mysql/uploads/${list[index]['image']}"),
                        ),
                        subtitle: Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(list[index]['name']),
                        ),),
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
