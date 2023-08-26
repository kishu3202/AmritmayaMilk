import 'package:amritmaya_milk/provider/auth_Provider.dart';
import 'package:amritmaya_milk/screens/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formfield = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passToggle = true;
  late String email;
  late String password;
  bool validateEmail = false, validatePassword = false;
  bool validateEmailIdFormat = false, validatePasswordIdFormat = false;
  RegExp? regExpEmail;
  AuthProvider? authProvider;
  int selectOption = 0; // 0: Nothing selected, 1: Delivery boy, 2: user
  bool termAccepted = false;

  Future<bool> exitApp(BuildContext context) async {
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return await exitApp(context);
      },
      child: Scaffold(
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
                    height: 280,
                    width: 280,
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: selectOption,
                          onChanged: (value) {
                            setState(() {
                              selectOption = value!;
                            });
                          },
                        ),
                        const Text(
                          "Deliver Boy",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: selectOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectOption = value!;
                                  });
                                },
                              ),
                              const Text(
                                "User",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      // errorText: validateEmail ? null : 'Invalid email format',
                      // labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter an Email address';
                      String pattern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      if (!RegExp(pattern).hasMatch(value))
                        return 'Please enter an valid Email address';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 5,
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
                        child: Icon(passToggle
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter Password';

                      return null;
                    },
                  ),
                  if (selectOption == 2)
                    const SizedBox(
                      height: 4,
                    ),
                  if (selectOption == 2)
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
                    height: 5,
                  ),
                  if (selectOption == 2)
                    Transform.translate(
                      offset: const Offset(-15, 0),
                      child: CheckboxListTile(
                          title: RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                text: "I accept all the",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: " Terms & Conditions",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ]),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: termAccepted,
                          onChanged: (newValue) {
                            setState(() {
                              termAccepted = newValue!;
                            });
                          }),
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        final email = emailController.text;
                        final password = passwordController.text;
                        if (selectOption == 2 && !termAccepted) {
                          Fluttertoast.showToast(
                            msg: "Please check the checkbox before logging in.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else if (email.isNotEmpty && password.isNotEmpty) {
                          if (selectOption == 1) {
                            authProvider.setSelectOption(1);
                            authProvider.DeliveryBoylogin(
                                context, email, password);
                          } else if (selectOption == 2) {
                            authProvider.setSelectOption(2);
                            authProvider.Userlogin(context, email, password);
                          }
                        } else if (!_formfield.currentState!.validate()) {
                          print('Login Failed.');
                        }
                        // if (email.isNotEmpty && password.isNotEmpty) {
                        //   if (selectOption == 1) {
                        //     authProvider.DeliveryBoylogin(
                        //         context, email, password);
                        //   } else if (selectOption == 2) {
                        //     authProvider.Userlogin(context, email, password);
                        //   }
                        // } else if (!_formfield.currentState!.validate()) {
                        //   print('Login Failed.');
                        // }
                      });
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        // child: authProvider.loading
                        //     ? const CircularProgressIndicator(
                        //         color: Colors.white,
                        //       )
                        child: Text(
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
                  // if (selectOption == 2)
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       const Text(
                  //         "Create a new Account !!",
                  //         style: TextStyle(
                  //           fontSize: 17,
                  //           color: Colors.black87,
                  //           fontStyle: FontStyle.italic,
                  //         ),
                  //       ),
                  //       TextButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         const RegistrationScreen()));
                  //           });
                  //         },
                  //         child: const Text(
                  //           "Sign Up",
                  //           style: TextStyle(
                  //             color: Colors.blue,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
