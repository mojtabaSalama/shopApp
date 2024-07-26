import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';
import 'package:shop_app/components/curser.dart';
import 'package:shop_app/components/head.dart';
import 'package:shop_app/components/snackbar.dart';
import 'package:shop_app/components/text_button.dart';

import 'package:shop_app/components/text_field.dart';

import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:shop_app/components/meterial_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

// form key and controllers
final _signinFormKey = GlobalKey<FormState>();
TextEditingController _customerName = TextEditingController();
TextEditingController _password = TextEditingController();

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
        builder: (context, customerProvider, child) {
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //form
              Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _signinFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          //form head
                          const Head(
                              head: "Sign in",
                              subhead:
                                  "Find the best quality products and order now ! "),
                          const SizedBox(
                            height: 20,
                          ),

                          //text fields
                          MyTextField(
                              hintText: "User name",
                              keyboardType: TextInputType.name,
                              icon: Icons.person,
                              isPassword: false,
                              controller: _customerName,
                              validator:
                                  Validators.required("User name is required")),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              hintText: "Password",
                              keyboardType: TextInputType.visiblePassword,
                              icon: Icons.password,
                              isPassword: true,
                              controller: _password,
                              validator:
                                  Validators.required("Password is required")),
                          const SizedBox(
                            height: 20,
                          ),

                          //submit button
                          customerProvider.isLoading
                              ? const MyCurser()
                              : MyButtun(
                                  width: double.infinity,
                                  onTap: () async {
                                    //check errors
                                    if (_signinFormKey.currentState
                                            ?.validate() ==
                                        true) {
                                      //set nedded data to send to backend
                                      final data = {
                                        'customerName': _customerName.text,
                                        'password': _password.text,
                                      };
                                      //send to backend
                                      final response =
                                          await customerProvider.signIn(data);

                                      //data is sent successfully
                                      if (response == true) {
                                        showMySnackbar(
                                            context, "Sign in succeed!");
                                        Navigator.pushNamed(
                                            context, '/shopPage');
                                      }
                                      //backend error
                                      else {
                                        showMySnackbar(context, response);
                                      }
                                    }
                                  },
                                  //button text
                                  child: Center(
                                      child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontSize: 17),
                                  ))),
                          const SizedBox(
                            height: 10,
                          ),

                          //navigate to signup page
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("don't have an account? "),
                              MyTextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/signUp');
                                },
                                text: "Sign up",
                              )
                            ],
                          )
                        ]),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
