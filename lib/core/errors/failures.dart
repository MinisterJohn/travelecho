import 'package:equatable/equatable.dart';

/// Base class for failures
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Unexpected failure
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
