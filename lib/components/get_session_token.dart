import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeze/screens/session.dart';
import 'package:freeze/states/session_token/session_token_bloc.dart';
import 'package:freeze/states/session_token/session_token_state.dart';

class GetSessionToken extends StatelessWidget {
  final Widget child;

  const GetSessionToken({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    SessionTokenBloc sessionTokenBloc = context.read<SessionTokenBloc>();

    return BlocBuilder<SessionTokenBloc, SessionTokenState>(
      buildWhen: (SessionTokenState previous, SessionTokenState current) {
        return previous != current;
      },
      bloc: sessionTokenBloc,
      builder: (BuildContext blocBuilderContext, SessionTokenState state) {
        if (state.sessionToken == null) {
          return const SessionTokenScreen();
        } else {
          return child;
        }
      },
    );
  }
}
