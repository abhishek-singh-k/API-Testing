import 'dart:convert';

import 'package:flutter/material.dart';
import 'Models/PostModel.dart';
import 'package:http/http.dart' as http;

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  List<PostModel> postlist=[];

  Future<List<PostModel>>? getPostApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'),);
    var data= jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for(Map i in data){
        postlist.add(PostModel.fromJson(i));

      }
      return postlist;
    }
    else
      {
        return postlist;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api calling',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 40.0,
          color: Colors.white,
        ),
        ),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot)
              {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }else if(snapshot.connectionState == ConnectionState.done)
                {
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: postlist.length,
                        itemBuilder: (context,index){
                          // return Text(index.toString());
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title\n'+postlist[index].title.toString()),
                                SizedBox(height: 20.0),
                                Text('Description\n'+postlist[index].body.toString()),


                              ],
                            ),
                          );
                        });
                  }else{
                    return Text('No data');
                  }
                }else{
                  return const SizedBox();
                }

                }
            ),
          )
        ],
      ),
    );
  }
}
// class photo
// {
//   String title, url;
//   photo(required this.title, required this.url)
// }
