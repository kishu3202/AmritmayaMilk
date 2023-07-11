import 'package:amritmaya_milk/provider/auth_Provider.dart';
import 'package:amritmaya_milk/screens/forget_password_screen.dart';
import 'package:amritmaya_milk/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// main() async {
//   var headers = {
//     'Content-Type': 'application/json',
//     'X-API-KEY': 'amritmayamilk050512',
//   };
//   var http;
//   var request = http.Request(
//       'POST',
//       Uri.parse(
//           'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/login'));
//   request.body = {
//     'email': 'sahu@gmail.com',
//     'password': '1234',
//     // 'token': 'b6c6cb50a0149f4b',
//   };
//   request.headers.addAll(headers);
//
//   StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//   } else {
//     print(response.reasonPhrase);
//   }
// }

class _LoginScreenState extends State<LoginScreen> {
  final _formfield = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passToggle = true;
  late String email;
  late String password;
  bool validateEmail = false, validatePassword = false;
  bool validateEmailIdFormat = false, validatePasswordIdFormat = false;
  String patternEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp? regExpEmail;

  @override
  void initState() {
    super.initState();
    setState(() {
      regExpEmail = RegExp(patternEmail);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Form(
            key: _formfield,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "image/amritmaya.jpeg",
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",

                    // labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  onChanged: (value) {
                    setState(() {
                      emailController.text.isEmpty
                          ? validateEmail = true
                          : validateEmail = false;
                      !regExpEmail!.hasMatch(emailController.text)
                          ? validateEmailIdFormat = true
                          : validateEmailIdFormat = false;
                      // validateEmail
                      //     ? ThemeHelper().buildErrorContainer(
                      //         validateEmail, "Please enter email id", context)
                      //     : ThemeHelper().buildErrorContainer(
                      //         validateEmailIdFormat,
                      //         "Please enter email format: test@gmail.com",
                      //         context);
                    });
                  },
                  // validator: (value) {
                  //   validateEmail = RegExp(
                  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //       .hasMatch(value!);
                  //   if (value.isEmpty) {
                  //     return ("Please Enter your email");
                  //   } else if (validateEmail == false) {
                  //     return "Enter valid email";
                  //   }
                  // },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    hintText: "Password",

                    // labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.lock),

                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      passwordController.text.isEmpty
                          ? validatePassword = true
                          : validatePassword = false;
                      validatePassword != passwordController.text.isEmpty;
                    });
                  },

                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please enter your password";
                  //   }
                  //   return null;
                  // },
                  // onSaved: (value) {
                  //   password = value!;
                  // },
                ),
                // SizedBox(
                //   height: 5,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgetPasswordScreen()),
                        );
                      },
                      child: const Text(
                        "Forget Password",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),

                InkWell(
                  onTap: () {
                    setState(() {
                      final email = emailController.text;
                      final password = passwordController.text;
                      if (email.isNotEmpty && password.isNotEmpty) {
                        // final apiProvider =
                        //     Provider.of<AuthProvider>(context, listen: false);
                        // final response =
                        //     await apiProvider.login(email, password);
                        // if (response.statusCode == 200) {
                        //   print('Login Successful');
                        // } else {
                        //   print('Login Failed');
                        // }
                      } else {
                        print('Enter Email and Password');
                      }
                    });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: authProvider.loading
                          ? CircularProgressIndicator()
                          : Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Create a new Account !!",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            if (_formfield.currentState!.validate()) {
                              print("failed");
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()),
                              );
                            }
                          });
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
