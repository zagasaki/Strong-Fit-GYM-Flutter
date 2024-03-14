class Failure {
  final String message;

  const Failure([this.message = 'An Unknow error occured']);

  factory Failure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const Failure('please enter a stronger password.');
      case 'invalid-email':
        return const Failure('Email is not valid or badly formatted.');
      case 'email-already-in-use':
        return const Failure('An account already exists for that email.');
      case 'operation-not-allowed':
        return const Failure(
            'Operation is not allowed. Please contact support.');
      case 'user-disabled':
        return const Failure(
            'This user has been disabled. Please contact support for help.');
      default:
        return const Failure();
    }
  }
}
