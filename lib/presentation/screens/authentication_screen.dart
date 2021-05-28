import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paperopoli_terminal/presentation/widgets/authentication/login_form.dart';

class AuthenticatonScreen extends StatefulWidget {
  @override
  _AuthenticatonScreenState createState() => _AuthenticatonScreenState();
}

class _AuthenticatonScreenState extends State<AuthenticatonScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(
        seconds: 1,
      ),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
    Future.delayed(
      Duration(
        seconds: 1,
      ),
      () => _controller.forward(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xffFDFCFD),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          hoverElevation: 0,
          highlightElevation: 0,
          onPressed: () {},
          child: Icon(
            Icons.help_outline_outlined,
            color: Colors.black,
          ),
        ),
        body: Stack(
          children: [
            FadeTransition(
              opacity: _animation,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/landing.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 64,
                  top: 32,
                ),
                child: Text(
                  'PAPEROPOLI TERMINAL',
                  style: GoogleFonts.nunito(
                    fontSize: 64,
                    color: Color(0xff242342),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                ),
                child: Text(
                  'Copyright © 2021 Andrea Checchin',
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 380,
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/ship_icon.png',
                        width: 300,
                        color: Color(0xff5564E8).withOpacity(0.7),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 200,
                          ),
                          child: LoginFormWidget(),
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
