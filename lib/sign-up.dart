import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, String password) async
  {
    try{
      print("hi");
      var url = "https://reqres.in/api/register";
      var body = {
        'email':email,
        'password':password,
      };
      print(url);
      print(body);
      var response = await http.post(Uri.parse(url), body: body);
      print("response --> $response");
      if(response.statusCode==200)
        {
          print('Account created successfully');
        }
      else
        {
          print('failed');
        }

    }
    catch(e){
      print(e.toString());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Sign up form "),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(height:20,),

            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'abc@123',
                suffixStyle: TextStyle(
                  fontSize: 100.0,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: ()
              {
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 50.0,
                width: 350.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Sign Up',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
