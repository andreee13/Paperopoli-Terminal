import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperopoli_terminal/cubits/authentication/authentication_cubit.dart';
import 'package:paperopoli_terminal/presentation/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
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
        suffixIcon: Icon(
          icon,
          color: Colors.black.withOpacity(0.7),
          size: 20,
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
        resizeToAvoidBottomInset: false,
        appBar: !_loading
            ? AppBar(
                title: Row(
                  children: [
                    Icon(
                      Icons.widgets,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Paperopoli Terminal',
                    ),
                  ],
                ),
              )
            : null,
        body: _loading
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Stack(
                children: [
                  Center(
                    child: ConstrainedBox(
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
                              top: 50,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                                      bottom: 24,
                                    ),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: _getInputDecoration(
                                        'Password',
                                        Ionicons.key_outline,
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
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  MaterialButton(
                                    onPressed: () async {
                                      setState(() {
                                        _loading = true;
                                      });
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
                                            .state is AuthenticationNotLogged) {
                                          setState(() {
                                            _loading = false;
                                          });
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
                                        MediaQuery.of(context).size.height - 40,
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      );
}
