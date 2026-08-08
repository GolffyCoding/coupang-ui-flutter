import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Signup {
  final AuthRepository repository;
  const Signup(this.repository);

  Future<AppUser> call(String email, String password, String name) =>
      repository.signup(email, password, name);
}
