import 'dart:convert';

import 'package:apicall/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SamplePost> samplePost = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: callData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: samplePost.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 120,
                    color: Colors.greenAccent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'user: ${samplePost[index].userId}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Id: ${samplePost[index].id}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'title: ${samplePost[index].title}',
                          style: TextStyle(fontSize: 18),
                          maxLines: 1,
                        ),
                        Text(
                          'Body: ${samplePost[index].body}',
                          style: TextStyle(fontSize: 18),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<List<SamplePost>> callData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        samplePost.add(SamplePost.fromJson(index));
      }
    } else {
      print('ERROR happens');
    }
    return samplePost;
  }
}
