class SessiontokenEvent {}

class AddSessionToken extends SessiontokenEvent {
  final int sessionToken;

  AddSessionToken({required this.sessionToken});
}
