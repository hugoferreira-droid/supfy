import 'dart:developer';

abstract class Failure implements Exception {
  final String? message;

  Failure(this.message);
}

class AppFailure extends Failure {
  AppFailure(String? message) : super(message) {
    log(message.toString(), name: 'AppFailure');
  }
}
