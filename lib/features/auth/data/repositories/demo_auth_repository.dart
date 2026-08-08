import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Mock in-memory auth repository - no real backend, no real network call.
class DemoAuthRepository extends ChangeNotifier implements AuthRepository {
  DemoAuthRepository._internal();
  static final DemoAuthRepository instance = DemoAuthRepository._internal();

  final Map<String, String> _accounts = {
    'demo@coupang.dev': '123456',
  };
  final Map<String, String> _names = {'demo@coupang.dev': '쿠팡회원'};

  AppUser? _currentUser;

  @override
  AppUser? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  @override
  Future<AppUser> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final saved = _accounts[email];
    if (saved == null || saved != password) {
      throw Exception('이메일 또는 비밀번호가 올바르지 않습니다');
    }
    _currentUser = AppUser(email: email, name: _names[email] ?? '쿠팡회원');
    notifyListeners();
    return _currentUser!;
  }

  @override
  Future<AppUser> signup(String email, String password, String name) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (_accounts.containsKey(email)) {
      throw Exception('이미 가입된 이메일입니다');
    }
    _accounts[email] = password;
    _names[email] = name;
    _currentUser = AppUser(email: email, name: name);
    notifyListeners();
    return _currentUser!;
  }

  @override
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
