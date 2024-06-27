import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';
import 'package:shop_app/components/meterial_button.dart';
import 'package:shop_app/components/snackbar.dart';

import 'package:shop_app/components/text_field.dart';
import 'package:shop_app/models/customer.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final _signUpFormKey = GlobalKey<FormState>();
TextEditingController _username = TextEditingController();
TextEditingController _password = TextEditingController();

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _signUpFormKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Sign up ",
                            style: TextStyle(
                              fontSize: 25,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Enjoy the best shopping experience ",
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextField(
                              hintText: "User name",
                              keyboardType: TextInputType.name,
                              icon: Icons.person,
                              isPassword: false,
                              controller: _username,
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
                          MyButtun(
                              width: double.infinity,
                              onTap: () {
                                if (_signUpFormKey.currentState?.validate() ==
                                    true) {
                                  final response = context
                                      .read<CustomerProvider>()
                                      .signUp(Customer(
                                          name: _username.text,
                                          password: _password.text));

                                  if (response) {
                                    Navigator.pushNamed(context, '/shopPage');
                                  } else {
                                    showMySnackbar(
                                        context, "User is already existed ");
                                  }
                                }
                              },
                              child: Center(
                                  child: Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    fontSize: 17),
                              ))),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? "),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/signIn');
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                  ))
                            ],
                          )
                        ]),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
