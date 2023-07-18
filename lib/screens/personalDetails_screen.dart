import 'package:amritmaya_milk/data/user_personalDetails_data_model.dart';
import 'package:amritmaya_milk/provider/user_PersonalDetails_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  late String _name;
  late String _email;
  late String _contact;
  late String _address;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDetailsProvider>(context, listen: false);
    final userProfileDataModel = provider.userProfileDataModel;

    _nameController.text = userProfileDataModel!.userName;
    _contactController.text = userProfileDataModel!.userContact;
    _emailController.text = userProfileDataModel!.userEmail;
    _addressController.text = userProfileDataModel!.userAddress;

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
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
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
                  onChanged: (value) {
                    setState(() {
                      _contact = value;
                    });
                  },
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
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
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
                  onChanged: (value) {
                    setState(() {
                      _address = value;
                    });
                  },
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
                    onPressed: () async {
                      final updatedDetails = UserProfileDataModel(
                          userName: _nameController.text,
                          userEmail: _emailController.text,
                          userContact: _contactController.text,
                          userAddress: _addressController.text);

                      final success =
                          await provider.updatePersonalDetails(updatedDetails);
                      if (success) {
                        print("Profile updated sucessfully");
                      } else {
                        print("Profile update Failed");
                      }
                    },
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
