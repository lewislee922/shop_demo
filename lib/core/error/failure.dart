import 'package:equatable/equatable.dart';

abstract class Failure {}

class AuthorizedFailure extends Failure {}

class NetworkFailure extends Failure {}

class NoDataFailure extends Failure {}
