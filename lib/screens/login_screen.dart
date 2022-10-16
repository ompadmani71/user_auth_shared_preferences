import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool checkBoxVal = false;
  String? checkPassword;

  String? checkEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Login Screen"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: loginKey,
            child: Column(
              children: [
                Image.asset("assets/images/login.png"),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value != checkEmail) {
                      return "Please Enter Valid Email";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    Global.email = value;
                  },
                  controller: emailController,
                  decoration:
                      textFieldDecoration(icon: Icons.email, hint: "Enter Email", label: "Email"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value != checkPassword) {
                      return "Please Enter Valid Password";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    Global.password = value;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: textFieldDecoration(
                     icon:  Icons.key, hint: "Enter Password", label: "Password"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    checkEmail = prefs.getString("email");
                    checkPassword = prefs.getString("password");

                    if (loginKey.currentState!.validate()) {
                      loginKey.currentState!.save();

                      Navigator.of(context).pushReplacementNamed("/");

                      prefs.setBool("isLogin", true);
                      prefs.setBool("isRemember", checkBoxVal);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Remember me Login"),
                    Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                        value: checkBoxVal,
                        onChanged: (value) {
                          setState(() {
                            checkBoxVal = value!;
                          });
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFieldDecoration({required IconData icon, required String hint, required String label}) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hint,
      label: Text(label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
