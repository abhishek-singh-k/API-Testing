
import 'package:flutter/material.dart';
import 'dart:convert';
import 'Models/UserModel.dart';
import 'package:http/http.dart' as http;

class SecondExample extends StatefulWidget {
  const SecondExample({super.key});

  @override
  State<SecondExample> createState() => _SecondExampleState();
}

class _SecondExampleState extends State<SecondExample> {

  List<UserModel> userlist=[];
  Future<List<UserModel>> getUserModelApi() async{
    final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    print(response);
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200)
      {
        for (Map i in data)
          {
            userlist.add(UserModel.fromJson(i));
          }
        return userlist;
      }
    else
      {
        return  userlist;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("API",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 40.0,
            color: Colors.lightBlueAccent,
          ),),

      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserModelApi(),
            builder:(context, AsyncSnapshot<List<UserModel>>snapshot){//AsyncSnapshot<List<UserModel>>what is the use of this line
              if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return const CircularProgressIndicator();
                }
              else
                {
                  return ListView.builder(
                      itemCount: userlist.length,
                      itemBuilder: (context,index)
                      {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableRow(title: "name"":    ", value: snapshot.data![index].name.toString()),
                              ReusableRow(title: 'username'":   ", value: snapshot.data![index].username.toString()),
                              ReusableRow(title: "email"':   ', value: snapshot.data![index].email.toString()),
                              ReusableRow(title: "City"'    ', value: snapshot.data![index].address!.city.toString()),
                               ReusableRow(title: "Street"':    ', value: snapshot.data![index].address!.street.toString()),
                              ReusableRow(title: "Latitude]"':    ', value: snapshot.data![index].address!.geo!.lat.toString()),

                        ],
                        ),
                        );
                      }
                      );
                }
            }
          ),),
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children:[
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}


