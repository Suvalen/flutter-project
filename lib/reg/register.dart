import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFF7F8FA)),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Create your\nAccount',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: const Color(0xFF323142),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      letterSpacing: -1.52,
                    ),
              ),
              const SizedBox(height: 48),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Full Name Input
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        hintStyle: const TextStyle(color: Color(0xFFC2C3CB)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.67),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.84),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email Input
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        hintStyle: const TextStyle(color: Color(0xFFC2C3CB)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.67),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.84),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        if (!value!.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password Input
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Color(0xFFC2C3CB)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.67),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.84),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a password';
                        }
                        if ((value?.length ?? 0) < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF141718),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Color(0xFFF3F5F6),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Divider with text
              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFC2C3CB))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Continue With Accounts',
                      style: TextStyle(
                        color: const Color(0xFFACADB9),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: Color(0xFFC2C3CB))),
                ],
              ),
              const SizedBox(height: 24),

              // Social Buttons
              Row(
                children: [
                  Expanded(
                    child: _SocialButton(
                      label: 'GOOGLE',
                      color: const Color(0xFFD44638),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SocialButton(
                      label: 'FACEBOOK',
                      color: const Color(0xFF4267B2),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sign In link
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Already Have An Account? ',
                        style: TextStyle(
                          color: Color(0xFFACADB9),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign In',
                        style: const TextStyle(
                          color: Color(0xFF323142),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: null, // Add navigation here
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 2.55,
          ),
        ),
      ),
    );
  }
}

// IMPROVED: Functional registration form with proper TextFormFields - replaces static Figma UI
