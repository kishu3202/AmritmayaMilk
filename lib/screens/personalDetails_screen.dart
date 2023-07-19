import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String token = '';

  @override
  void initState() {
    initializeForm();
    super.initState();
  }

  void initializeForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    _nameController.text = prefs.getString('name') ?? '';
    _contactController.text = prefs.getString('contact') ?? '';
    _emailController.text = prefs.getString('email') ?? '';
    _addressController.text = prefs.getString('address') ?? '';
  }

  void updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var updatedUser = new Map<String, dynamic>();
    updatedUser['name'] = _nameController.text;
    updatedUser['contact'] = _contactController.text;
    updatedUser['email'] = _emailController.text;
    updatedUser['address'] = _addressController.text;

    final String url =
        "https://webiipl.in/amritmayamilk/api/UserApiController/profile_update";
    final Map<String, String> headers = {'X-API-KEY': 'amritmayamilk050512'};
    final http.Response response =
        await http.post(Uri.parse(url), headers: headers, body: updatedUser);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['Success'] == true) {
      print("update sucess");
      // Update the shared preferences with the new details
      prefs.setString('name', updatedUser['name']);
      prefs.setString('contact', updatedUser['contact']);
      prefs.setString('email', updatedUser['email']);
      prefs.setString('address', updatedUser['address']);

      Fluttertoast.showToast(
          msg: 'Profile Details Update have been save Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: 'Failed to update details!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
      print("update failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Personal Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: _contactController,
                  decoration: InputDecoration(
                      hintText: 'Contact',
                      prefixIcon: Icon(Icons.contact_phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _addressController,
                  decoration: InputDecoration(
                      hintText: 'Address',
                      prefixIcon: Icon(Icons.location_city),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: updateProfile,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
