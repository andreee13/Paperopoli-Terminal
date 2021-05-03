import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/themes/default_theme.dart';
import 'cubits/authentication/authentication_cubit.dart';
import 'data/repositories/user_repository.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await _initializeDeviceProperties();
  runZonedGuarded(
    () {
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationCubit(
                repository: UserRepository(
                  firebaseAuth: FirebaseAuth.instance,
                ),
              ),
            ),
          ],
          child: AppBootstrapper(),
        ),
      );
    },
    FirebaseCrashlytics.instance.recordError,
  );
}

Future<void> _initializeDeviceProperties() async {
  GestureBinding.instance!.resamplingEnabled = true;
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class AppBootstrapper extends StatefulWidget {
  @override
  _AppBootstrapperState createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<AppBootstrapper> {
  @override
  void initState() {
    context.read<AuthenticationCubit>().login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: DEFAULT_THEME,
        debugShowCheckedModeBanner: false,
        locale: Locale(
          'it',
          'IT',
        ),
        home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            print(state.runtimeType);
            if (state is AuthenticationError ||
                state is AuthenticationNotLogged) {
              return LoginScreen();
            } else if (state is AuthenticationLogged) {
              return HomeScreen();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
}
