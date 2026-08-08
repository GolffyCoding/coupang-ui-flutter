import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;
  const Login(this.repository);

  Future<AppUser> call(String email, String password) =>
      repository.login(email, password);
}
