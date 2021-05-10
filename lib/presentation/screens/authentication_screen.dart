import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paperopoli_terminal/presentation/widgets/authentication/login_form.dart';

class AuthenticatonScreen extends StatefulWidget {
  @override
  _AuthenticatonScreenState createState() => _AuthenticatonScreenState();
}

class _AuthenticatonScreenState extends State<AuthenticatonScreen> {
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
                child: LoginFormWidget(),
              ),
            ),
          ],
        ),
      );
}
