import 'package:flutter/material.dart';

class EmailValidator extends StatelessWidget {
  EmailValidator({super.key});

  TextEditingController emailController = TextEditingController();
  bool validateEmailFormat(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(Icons.email),
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          print('Please enter an EmailId');
        } else if (!validateEmailFormat(value)) {
          print('Please enter a valid email format: test@gmail.com');
        }
        return null;
      },
    );
  }
}
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

// validator: (value) {
//   if (value!.isEmpty) {
//     return "Please enter your password";
//   }
//   return null;
// },
// onSaved: (value) {
//   password = value!;
// },
