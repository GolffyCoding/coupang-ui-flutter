import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/usecase_providers.dart';
import '../../../../core/theme/cp_theme.dart';
import '../../../../core/widgets/coupang_widgets.dart';
import 'signup_page.dart';

class CpLoginPage extends ConsumerStatefulWidget {
  const CpLoginPage({super.key});

  @override
  ConsumerState<CpLoginPage> createState() => _CpLoginPageState();
}

class _CpLoginPageState extends ConsumerState<CpLoginPage> {
  final _emailController = TextEditingController(text: 'demo@coupang.dev');
  final _passwordController = TextEditingController(text: '123456');
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(loginUseCaseProvider)(
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CpColors.white,
      appBar: AppBar(
        backgroundColor: CpColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: CpColors.textMain),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const CoupangLogo(size: 32),
            const SizedBox(height: 8),
            const Text(
              '로그인하고 다양한 혜택을 받아보세요',
              style: TextStyle(fontSize: 13, color: CpColors.textMuted),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: '이메일',
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호',
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(
                _error!,
                style: const TextStyle(color: CpColors.red, fontSize: 13),
              ),
            ],
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CpColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: _loading ? null : _login,
                child: _loading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.4,
                        ),
                      )
                    : const Text(
                        '로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 14),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CpSignupPage()),
                ),
                child: const Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 13,
                    color: CpColors.textSub,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
