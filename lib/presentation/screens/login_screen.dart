import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperopoli_terminal/cubits/authentication/authentication_cubit.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordResetController;

  InputDecoration _getInputDecoration(
    String hintText,
    IconData icon,
  ) =>
      InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        fillColor: Colors.grey.withOpacity(0.2),
        filled: true,
        hintStyle: TextStyle(
          color: Colors.black45,
        ),
        hintText: hintText,
        suffixIcon: icon == Icons.email_outlined
            ? Icon(
                icon,
                color: Colors.black.withOpacity(0.7),
                size: 20,
              )
            : IconButton(
                icon: Icon(
                  icon,
                ),
                onPressed: () => setState(() {
                  _passwordVisible = !_passwordVisible;
                }),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
          borderSide: BorderSide.none,
        ),
      );

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordResetController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordResetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.help_outline_outlined,
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          hoverElevation: 0,
          highlightElevation: 0,
          onPressed: () {},
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  bottom: 8,
                ),
                child: Text(
                  'Copyright © 2021 Andrea Checchin',
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 60,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/ship_icon_red.png',
                            height: 200,
                          ),
                          Text(
                            'Paperopoli Terminal',
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 3,
                        minHeight: MediaQuery.of(context).size.width / 4,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 30,
                              left: 30,
                              top: 40,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 40,
                                      bottom: 15,
                                    ),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: _getInputDecoration(
                                        'Email',
                                        Icons.email_outlined,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 8,
                                    ),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: !_passwordVisible,
                                      decoration: _getInputDecoration(
                                        'Password',
                                        _passwordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            'Password recovery',
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text(
                                                'Close',
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            TextButton(
                                              child: Text(
                                                'Send',
                                              ),
                                              onPressed: () async {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    content: Text(
                                                      'Recovery email sent',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                );
                                                Navigator.pop(context);
                                                await FirebaseAuth.instance
                                                    .sendPasswordResetEmail(
                                                  email:
                                                      _passwordResetController
                                                          .text,
                                                );
                                              },
                                            ),
                                          ],
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Insert your email address for password recovery.',
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                child: TextFormField(
                                                  controller:
                                                      _passwordResetController,
                                                  autofocus: true,
                                                  decoration:
                                                      _getInputDecoration(
                                                    'Email',
                                                    Icons.email_outlined,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Forgot password?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  Center(
                                    child: MaterialButton(
                                      onPressed: () async {
                                        try {
                                          await context
                                              .read<AuthenticationCubit>()
                                              .logInWithCredentials(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                              );
                                          if (context
                                                  .read<AuthenticationCubit>()
                                                  .state
                                              is AuthenticationNotLogged) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Incorrect email and/or password',
                                                ),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'An error occured',
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      minWidth:
                                          MediaQuery.of(context).size.width / 6,
                                      height: 48,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      color: Colors.blue.withOpacity(0.8),
                                      elevation: 0,
                                      highlightElevation: 0,
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
