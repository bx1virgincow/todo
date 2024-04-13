import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/common/color.dart';
import 'package:todo/features/account/view/bloc/account_bloc.dart';
import 'package:todo/features/landing/view/ui/landing_screen.dart';

import '../../../../common/widget/text_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  //form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //disposing controllers
  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColor.backgroundColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFields(
                      validator: (value) {
                        if (value == null && value!.isEmpty) {
                          return 'Field required';
                        }
                        return null;
                      },
                      controller: firstNameController,
                      hintText: 'Firstname',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 6),
                    TextFields(
                      validator: (value) {
                        if (value == null && value!.isEmpty) {
                          return 'Field required';
                        }
                        return null;
                      },
                      controller: lastNameController,
                      hintText: 'LastName',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 6),
                    TextFields(
                      validator: (value) {
                        if (value == null && value!.isEmpty) {
                          return 'Field required';
                        }
                        return null;
                      },
                      controller: emailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 6),
                    SwitchListTile(
                        title: const Text('Remember Me'),
                        value: state is StayLoggedInState
                            ? state.isLoggedIn
                            : false,
                        onChanged: (value) {
                          if (state is StayLoggedInState) {
                            state.isLoggedIn = value;
                          }

                          context
                              .read<AccountBloc>()
                              .add(StayLoggedInEvent(isRemember: value));
                          log('value: $value');
                        }),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AccountBloc>().add(
                                  OnRegisterUserEvent(
                                    firstname: firstNameController.text,
                                    lastname: lastNameController.text,
                                    email: emailController.text,
                                  ),
                                );
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, AccountState state) {
        if (state is AccountSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LandingScreen(),
            ),
          );
        }
      },
    );
  }
}
