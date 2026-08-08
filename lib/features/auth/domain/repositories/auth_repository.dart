import '../entities/user.dart';

abstract interface class AuthRepository {
  AppUser? get currentUser;
  Future<AppUser> login(String email, String password);
  Future<AppUser> signup(String email, String password, String name);
  void logout();
}
