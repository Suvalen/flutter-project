import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../services/api_service.dart';  // ← ADD THIS IMPORT


class YourLoginWidget extends StatefulWidget {
  const YourLoginWidget({super.key});

  @override
  State<YourLoginWidget> createState() => _YourLoginWidgetState();
}

class _YourLoginWidgetState extends State<YourLoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  bool _rememberMe = false;
  
  // ⭐ ADD THESE FOR TEST
  bool _isTesting = false;
  String _testResult = '';

  @override
  void initState() {
    super.initState();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _emailFocus.addListener(() {
      debugPrint('emailFocus.hasFocus = ${_emailFocus.hasFocus}');
    });
    _passwordFocus.addListener(() {
      debugPrint('passwordFocus.hasFocus = ${_passwordFocus.hasFocus}');
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/welcome-home',
        (route) => false,
      );
    }
  }

  // ⭐ ADD THIS TEST FUNCTION
  Future<void> _testBackendConnection() async {
    setState(() {
      _isTesting = true;
      _testResult = 'Testing connection...';
    });

    try {
      // Test 1: Check if server is reachable
      bool connected = await ApiService.testConnection();
      
      if (connected) {
        // Test 2: Try sending a message
        String response = await ApiService.sendMessage("What is diabetes?");
        
        setState(() {
          _isTesting = false;
          _testResult = '✅ Connected!\n\nBot response:\n$response';
        });
        
        debugPrint('✅ Backend connected! Response: $response');
      } else {
        setState(() {
          _isTesting = false;
          _testResult = '❌ Cannot connect to server.\n\nCheck:\n1. Is Flask running?\n2. Is IP address correct in api_service.dart?';
        });
      }
    } catch (e) {
      setState(() {
        _isTesting = false;
        _testResult = '❌ Error: $e';
      });
      debugPrint('❌ Connection error: $e');
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
                'Login Your\nAccount',
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
                    // Email Input
                    TextFormField(
                      focusNode: _emailFocus,
                      controller: _emailController,
                      onTap: () => debugPrint('Email field tapped'),
                      keyboardType: TextInputType.emailAddress,
                      enableInteractiveSelection: true,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        hintStyle: const TextStyle(color: Color(0xFFC2C3CB)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.84),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.84),
                          borderSide: const BorderSide(
                              color: Color(0xFF141718), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.84),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                      ),
                      showCursor: true,
                      cursorColor: const Color(0xFF141718),
                      readOnly: false,
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
                      focusNode: _passwordFocus,
                      controller: _passwordController,
                      onTap: () => debugPrint('Password field tapped'),
                      obscureText: true,
                      enableInteractiveSelection: true,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Color(0xFFC2C3CB)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.84),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.84),
                          borderSide: const BorderSide(
                              color: Color(0xFF141718), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.84),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                      ),
                      showCursor: true,
                      cursorColor: const Color(0xFF141718),
                      readOnly: false,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Forgot Password & Remember Me
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() => _rememberMe = value ?? false);
                        },
                        activeColor: const Color(0xFF141718),
                      ),
                      const Text(
                        'Remember Me',
                        style: TextStyle(
                          color: Color(0xFF323142),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF323142),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF141718),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFFF3F5F6),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
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

              // Sign Up link
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Create New Account? ',
                        style: TextStyle(
                          color: Color(0xFFACADB9),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign up',
                        style: const TextStyle(
                          color: Color(0xFF323142),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              Navigator.of(context).pushNamed('/register'),
                      ),
                    ],
                  ),
                ),
              ),
              
              // ⭐⭐⭐ TEST BUTTON - DELETE THIS SECTION LATER ⭐⭐⭐
              const SizedBox(height: 40),
              const Divider(color: Colors.orange, thickness: 2),
              const SizedBox(height: 16),
              
              Center(
                child: Text(
                  '🧪 DEBUG: Test Backend Connection',
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isTesting ? null : _testBackendConnection,
                  icon: _isTesting 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.wifi_find, color: Colors.white),
                  label: Text(
                    _isTesting ? 'Testing...' : 'Test Flask Backend',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              
              // Test Result Display
              if (_testResult.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _testResult.contains('✅') 
                        ? Colors.green[50] 
                        : Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _testResult.contains('✅') 
                          ? Colors.green 
                          : Colors.red,
                    ),
                  ),
                  child: Text(
                    _testResult,
                    style: TextStyle(
                      color: _testResult.contains('✅') 
                          ? Colors.green[800] 
                          : Colors.red[800],
                      fontSize: 13,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
              
              const SizedBox(height: 16),
              const Divider(color: Colors.orange, thickness: 2),
              // ⭐⭐⭐ END TEST BUTTON SECTION ⭐⭐⭐
              
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