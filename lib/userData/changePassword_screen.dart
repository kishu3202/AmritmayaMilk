import 'package:amritmaya_milk/provider/userProvider/changePassword_Provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String customerId;
  const ChangePasswordScreen({super.key, required this.customerId});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _changePasswordFromKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late String oldPassword;
  late String newPassword;
  late String confirmPassword;
  bool passToggle = true;
  bool newPassToggle = true;
  bool confirmPassToggle = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final changePasswordProvider = Provider.of<ChangePasswordProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Form(
              key: _changePasswordFromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 120, color: Colors.blue,),
                  SizedBox(height: 10),
                  Text("Change Password", style: TextStyle(fontSize: 17,),),
                  SizedBox(height: 50,),
                  TextFormField(
                      onChanged: (value) {
                        setState(() {
                          oldPassword = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      controller: oldPasswordController,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                        hintText: "Enter Old Password",
                        labelText: "Old Password",
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
                      }),
                  SizedBox(height: 30),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        newPassword = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    controller: newPasswordController,
                    obscureText: newPassToggle,
                    decoration: InputDecoration(
                      hintText: " Enter New Password",
                      labelText: "New Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            newPassToggle = !newPassToggle;
                          });
                        },
                        child: Icon(newPassToggle
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
                  SizedBox(height: 30),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        confirmPassword = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    controller: confirmPasswordController,
                    obscureText: confirmPassToggle,
                    decoration: InputDecoration(
                      hintText: "Enter Confirm Password",
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            confirmPassToggle = !confirmPassToggle;
                          });
                        },
                        child: Icon(confirmPassToggle
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: (value) {
                      if (value != newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 60),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final oldPassword = oldPasswordController.text;
                          final newPassword = newPasswordController.text;
                          final confirmPassword =
                              confirmPasswordController.text;

                          if (oldPassword.isNotEmpty &&
                              newPassword.isNotEmpty &&
                              confirmPassword.isNotEmpty) {
                            if (newPassword == confirmPassword) {
                              // Passwords match, proceed with changing the password
                              changePasswordProvider.changePassword(context,
                                  widget.customerId, oldPassword, newPassword);
                            } else {
                              // Passwords do not match, show a toast message
                              Fluttertoast.showToast(
                                msg: "Passwords do not match",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          } else if (_changePasswordFromKey.currentState!
                              .validate()) {
                            // Handle other validation or actions here
                            Navigator.pop(context);
                            print('false');
                          }
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Sumbit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )),
                  // InkWell(),
                  // TextButton(onPressed: (){}, child: Text('submit')),
                  // FilledButton(onPressed: (){}, child: Text('submit')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
