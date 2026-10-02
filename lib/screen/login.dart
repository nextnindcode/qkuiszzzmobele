import 'package:flutter/material.dart';

import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import './root.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userC = TextEditingController();
  final _passC = TextEditingController();
  bool _sembunyi = true;
  bool _loading = false;

  @override
  void dispose() {
    _userC.dispose();
    _passC.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    final ok =
        _userC.text.trim() == ProfileData.nim.trim() &&
        _passC.text.trim() == ProfileData.password.trim();

    if (ok) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainPage()),
      );
    } else {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('NIM atau password salah'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.coklatTua,
              AppColors.orangeGelap,
              AppColors.krem,
            ],
            stops: [0, 0.35, 0.35],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.krem,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.calculate_rounded,
                      size: 48,
                      color: AppColors.hijauTua,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Kuis Mobile',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.krem,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Silakan masuk untuk melanjutkan',
                    style: TextStyle(color: AppColors.krem),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: AppColors.putih,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.coklatTua.withValues(alpha: 0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.coklatTua,
                            ),
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            controller: _userC,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'NIM',
                              prefixIcon: Icon(
                                Icons.badge_rounded,
                                color: AppColors.hijauTua,
                              ),
                            ),
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'NIM wajib diisi'
                                : null,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _passC,
                            obscureText: _sembunyi,
                            onFieldSubmitted: (_) => _login(),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(
                                Icons.lock_rounded,
                                color: AppColors.hijauTua,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _sembunyi
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                ),
                                onPressed: () =>
                                    setState(() => _sembunyi = !_sembunyi),
                              ),
                            ),
                            validator: (v) => (v == null || v.isEmpty)
                                ? 'Password wajib diisi'
                                : null,
                          ),
                          const SizedBox(height: 22),
                          ElevatedButton(
                            onPressed: _loading ? null : _login,
                            child: _loading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: AppColors.krem,
                                    ),
                                  )
                                : const Text('Masuk'),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Demo: NIM ${ProfileData.nim} / password ${ProfileData.psw}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
