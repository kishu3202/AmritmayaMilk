import 'package:amritmaya_milk/provider/userProvider/support_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getSupportData();
    });
    super.initState();
  }

  void getSupportData() async {
    final supportProvider =
        Provider.of<SupportProvider>(context, listen: false);
    try {
      await supportProvider.fetchSupportData();
      final email = supportProvider.email;
      final disclaimer = supportProvider.disclaimer;
      print('email: $email');
      print('disclaimer: $disclaimer');
    } catch (error) {
      print('Error fetching amount: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Support"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Center(
                child: Icon(
                  Icons.contact_support_outlined,
                  size: 100,
                  color: Colors.blue,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<SupportProvider>(
                  builder: (context, supportProvider, _) {
                    final email = supportProvider.email;
                    final disclaimer = supportProvider.disclaimer;
                    // Check if email and disclaimer are not null before displaying them
                    if (email != null && disclaimer != null) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Email: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " ${email}",
                                    style:
                                        const TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Disclaimer: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${disclaimer}",
                                    style:
                                        const TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Text('Email and Disclaimer not available.');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
