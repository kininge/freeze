import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freeze/screens/authentication.dart';
import 'package:freeze/states/session_token/session_token_bloc.dart';
import 'package:freeze/theme/theme.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => SessionTokenBloc()),
      ],
      child: MaterialApp(
        title: 'Freeze',
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home: const AuthenticationScreen(),
      ),
    );
  }
}
