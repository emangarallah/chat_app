


import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff28475E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(height: 150),
            Image.asset("assets/images/scholar.png"),
            Text('Scolar Chat',style: TextStyle(fontSize: 20,fontFamily: ' Pacifico',color: Colors.white,),),
            SizedBox(height: 100),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text('Sign In',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,fontFamily: ' Pacifico',
                  color: Colors.white
                ),),
              ],
            ),

            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.white
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),

              ),
            ),



          ],
        ),
      ),
    );
  }
}
