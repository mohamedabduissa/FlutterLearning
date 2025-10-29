import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_user_provider.dart';
import '../controllers/auth_controller.dart';
import 'register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(analyticsServiceProvider).logScreenView('LoginScreen');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref
          .read(authControllerProvider.notifier)
          .signInWithEmail(_emailController.text.trim(), _passwordController.text.trim());
    }
  }

  Future<void> _submitGoogleLogin() async {
    await ref.read(authControllerProvider.notifier).signInWithGoogle();
  }

  String getFriendlyErrorMessage(String error) {
    if (error.contains('wrong-password')) {
      return 'Incorrect password. Please try again.';
    } else if (error.contains('user-not-found')) {
      return 'No account found with this email.';
    } else if (error.contains('network-request-failed')) {
      return 'Network error. Check your internet connection.';
    } else {
      // Fallback for unexpected errors
      return 'An unexpected error occurred. Please try again later.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        // Show safe message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(getFriendlyErrorMessage(next.errorMessage!)), backgroundColor: Colors.red),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => (value == null || !value.contains('@')) ? 'Enter a valid email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) =>
                      (value == null || value.length < 6) ? 'Password is too short (6+ characters)' : null,
                ),
                const SizedBox(height: 24),

                authState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _submitLogin,
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                        child: const Text('Login'),
                      ),
                const SizedBox(height: 16),

                authState.isLoading
                    ? const SizedBox.shrink()
                    : ElevatedButton.icon(
                        onPressed: _submitGoogleLogin,
                        // ... (existing code) ...
                        icon: const Icon(Icons.login), //
                        label: const Text('Login with Google'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                const SizedBox(height: 24),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
                  },
                  child: const Text('Don\'t have an account? Register now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
