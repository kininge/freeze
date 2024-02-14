import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeze/states/session_token/session_token_event.dart';
import 'package:freeze/states/session_token/session_token_state.dart';

class SessionTokenBloc extends Bloc<SessiontokenEvent, SessionTokenState> {
  SessionTokenBloc() : super(SessionTokenState(sessionToken: null)) {
    on<AddSessionToken>(_addSessionToken);
  }

  void _addSessionToken(
      AddSessionToken event, Emitter<SessionTokenState> emit) {
    emit(SessionTokenState(sessionToken: event.sessionToken));
  }
}
