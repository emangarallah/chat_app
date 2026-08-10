import 'package:chat_app/screen/cubit_regester/Regester_state.dart';
import 'package:chat_app/screen/cubit_regester/regester_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constant.dart';
import '../helper/show_snak_bar.dart';
import '../widget/custobuttom.dart';
import '../widget/customtextfield.dart';
import 'chat_page.dart';

class RegisterPage extends StatelessWidget {
   RegisterPage({super.key});

  static String id = 'RegisterPage';
  String? email;
  String? password;
  //bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegesterCubit,RegesterState>(
      listener: (context,state){
        if(state is RegesterSuccess){
          Navigator.pushNamed(context, ChatPage.id);

        }else if(state is RegesterFailure){
          showSnackBar(context, state.errorMessage);

        }

      },
      builder:(context,state)=> ModalProgressHUD(
        inAsyncCall:state is RegesterStateLoading ,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 75),
                  Image.asset(
                    kLogo,
                    height: 100,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'pacifico',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 75),
                  const Row(
                    children: [
                      Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomFormTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 10),
                  CustomFormTextField(
                    obscureText: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 20),
                  CustomButon(
                    onTap: ()  {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<RegesterCubit>(context). registerUser(
                          email: email!,
                          password: password!,
                        );
                      }
                    },

                    text: 'REGISTER',
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          '  Login',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}