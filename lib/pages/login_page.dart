import 'package:flutter/material.dart';
import 'package:mobile_tugas3/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isObscure = true;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Welcome to Our Project",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Image.asset(
                    'images/login_image.png',
                    height: 300,
                  ),
                ),
                const SizedBox(height: 24),
                const Text("Username"),
                const SizedBox(height: 10),
                TextField(
                  controller: _username,
                  decoration: InputDecoration(
                    hintText: "Enter the username",
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor:
                        isError ? Colors.red.shade100 : Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Password"),
                const SizedBox(height: 10),
                TextField(
                  controller: _password,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: "Enter the password",
                    prefixIcon: const Icon(Icons.lock),
                    filled: true,
                    fillColor:
                        isError ? Colors.red.shade100 : Colors.transparent,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      String msg = "";
                      if (_username.text == "admin" &&
                          _password.text == "admin123") {
                        msg = "Login berhasil!";
                        setState(() {
                          isError = false;
                        });

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                      } else {
                        msg = "Username/password salah!";
                        setState(() {
                          isError = true;
                        });
                      }

                      SnackBar snackbar = SnackBar(content: Text(msg));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
