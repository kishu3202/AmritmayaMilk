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
// void callNumber(String phoneNumber) async {
//   final url = 'tel:$phoneNumber';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text('Could not make the call.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// validateEmail
//     ? Opacity(opacity: 0.0)
//     : Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text("Please enter valid Email address",
//               style:
//                   TextStyle(color: Colors.red, fontSize: 13)),
//         ],
//       ),
// validator: (email) {
//   if (email!.isEmpty) {
//     return 'Please enter an email address';
//   } else if (!_validateEmail(email)) {
//     return 'Please enter a valid email address';
//   }
//   return null;
// },
// onChanged: (value) {
//   final emailRegExp = RegExp(
//       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//   validateEmail = emailRegExp.hasMatch(value);
//   print(validateEmail);
//
//   // setState(() {
//   //   validateEmail = value.isEmpty || validateEmail;
//   // });
// },
// onChanged: (value) {
//   setState(() {
//     //  validateEmail = _validateEmail(value);
//     emailController.text.isEmpty
//         ? validateEmail = true
//         : validateEmail = false;
//     !regExpEmail!.hasMatch(emailController.text)
//         ? validateEmailIdFormat = true
//         : validateEmailIdFormat = false;
//   });
