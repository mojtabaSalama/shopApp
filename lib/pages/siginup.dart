import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';
import 'package:shop_app/components/curser.dart';
import 'package:shop_app/components/head.dart';
import 'package:shop_app/components/meterial_button.dart';
import 'package:shop_app/components/snackbar.dart';
import 'package:shop_app/components/text_button.dart';

import 'package:shop_app/components/text_field.dart';

import 'package:wc_form_validators/wc_form_validators.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final _signUpFormKey = GlobalKey<FormState>();
TextEditingController _customerName = TextEditingController();
TextEditingController _password = TextEditingController();

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
        builder: (context, customerProvider, child) {
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
                            const Head(
                                head: "Sign up",
                                subhead: "Enjoy the best shopping experience "),
                            const SizedBox(
                              height: 20,
                            ),
                            MyTextField(
                                hintText: "User name",
                                keyboardType: TextInputType.name,
                                icon: Icons.person,
                                isPassword: false,
                                controller: _customerName,
                                validator: Validators.required(
                                    "User name is required")),
                            const SizedBox(
                              height: 10,
                            ),
                            MyTextField(
                                hintText: "Password",
                                keyboardType: TextInputType.visiblePassword,
                                icon: Icons.password,
                                isPassword: true,
                                controller: _password,
                                validator: Validators.required(
                                    "Password is required")),
                            const SizedBox(
                              height: 20,
                            ),
                            customerProvider.isLoading
                                ? const MyCurser()
                                : MyButtun(
                                    width: double.infinity,
                                    onTap: () async {
                                      final data = {
                                        'customerName': _customerName.text,
                                        'password': _password.text,
                                      };
                                      if (_signUpFormKey.currentState
                                              ?.validate() ==
                                          true) {
                                        final response =
                                            await customerProvider.signUp(data);

                                        if (response == true) {
                                          showMySnackbar(
                                              context, "Sign in succeed!");
                                          Navigator.pushNamed(
                                              context, '/shopPage');
                                        } else {
                                          showMySnackbar(context, response);
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
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account? "),
                                MyTextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/signIn');
                                  },
                                  text: "Sign in",
                                )
                              ],
                            )
                          ]),
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
