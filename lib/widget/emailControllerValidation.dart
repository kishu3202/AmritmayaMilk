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

// Container(
//     child: ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: customers.length,
//         itemBuilder: (context, index) {
//           final customer = customers[index];
//           return Padding(
//             padding: const EdgeInsets.all(5),
//             child: Container(
//               decoration: ShapeDecoration(
//                 shape: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//               ),
//               child: ListTile(
//                 title: Text(customers[index]['name']),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                             'Contact Number: ${customers[index]['number']}'),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         CircleAvatar(
//                           radius: 10,
//                           backgroundColor: Colors.blue,
//                           child: Icon(
//                             Icons.phone,
//                             color: Colors.white,
//                             size: 15,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                         'From Date: ${customers[index]['fromDate']}'),
//                     Text(
//                         'To Date: ${customers[index]['toDate']}'),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         })),

// Container(
//     child: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: customers.length,
//         itemBuilder: (context, index) {
//           final customer = customers[index];
//           return Padding(
//             padding: const EdgeInsets.all(5),
//             child: Container(
//               decoration: ShapeDecoration(
//                 shape: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide:
//                       const BorderSide(color: Colors.grey),
//                 ),
//               ),
//               child: ListTile(
//                 title: Row(
//                   children: [
//                     RichText(
//                       text: TextSpan(
//                         style: DefaultTextStyle.of(context).style,
//                         children: [
//                           TextSpan(
//                               text: customers[index]['name'],
//                               style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black)),
//                           const TextSpan(text: '\n'),
//                           const TextSpan(
//                             text: 'Contact Number: ',
//                             style: TextStyle(
//                                 fontSize: 15, color: Colors.black),
//                           ),
//                           TextSpan(
//                             text: customers[index]['number'],
//                             style: const TextStyle(
//                                 fontSize: 15, color: Colors.black),
//                           ),
//                           const TextSpan(text: '\n'),
//                           const TextSpan(
//                             text: 'From Date: ',
//                             style: TextStyle(
//                                 fontSize: 15, color: Colors.black),
//                           ),
//                           TextSpan(
//                             text: customers[index]['fromDate'],
//                             style: const TextStyle(
//                                 fontSize: 15, color: Colors.black87),
//                           ),
//                           const TextSpan(text: '\n'),
//                           const TextSpan(
//                             text: 'To Date: ',
//                             style: TextStyle(
//                                 fontSize: 15, color: Colors.black),
//                           ),
//                           TextSpan(
//                             text: customers[index]['toDate'],
//                             style: const TextStyle(
//                                 fontSize: 15, color: Colors.black87),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         })),

// Container(
//   child: ListView(
//     physics: NeverScrollableScrollPhysics(),
//     shrinkWrap: true,
//     children: [
//       ListTile(
//         title: Text('Customer Name'),
//       ),
//       ListTile(
//         title: Text('Contact Number'),
//       ),
//       ListTile(
//         title: Text('From Date'),
//       ),
//       ListTile(
//         title: Text('To Date'),
//       ),
//     ],
//   ),
// ),

// final List customers = [
//   {
//     'name': 'Kishori',
//     'email': 'kishori@gmail.com',
//     'phoneNo': '8379813263',
//     'address': 'Pune'
//   },
//   {
//     'name': 'Dipti',
//     'email': 'dipti@gmail.com',
//     'phoneNo': '8894561223',
//     'address': 'Satara',
//   },
//   {
//     'name': 'Rahul',
//     'email': 'rahul@gmail.com',
//     'phoneNo': '9689998016',
//     'address': 'Sangli',
//   },
//   {
//     'name': 'Sayali',
//     'email': 'sayali@gmail.com',
//     'phoneNo': '8975599697',
//     'address': 'Mumbai',
//   }
// ];

// Expanded(
//   child: RadioListTile(
//     contentPadding:
//         EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
//     tileColor: Colors.deepPurple.shade50,
//     value: 2,
//     groupValue: selectedOption,
//     onChanged: (value) {
//       setState(() {
//         selectedOption = value as int;
//       });
//     },
//     title: Transform.translate(
//         offset: Offset(-10, 0), child: Text("With QR Scanner")),
//   ),
// ),

// Expanded(
//   child: RadioListTile(
//     contentPadding:
//         EdgeInsets.symmetric(horizontal: 4, vertical: 0),
//     tileColor: Colors.deepPurple.shade50,
//     value: 1,
//     groupValue: selectedOption,
//     onChanged: (value) {
//       setState(() {
//         selectedOption = value as int;
//       });
//     },
//     title: Transform.translate(
//       offset: Offset(-10, 0),
//       child: TextFormField(
//         controller: mobileNoController,
//         keyboardType: TextInputType.phone,
//         decoration: InputDecoration(
//           hintText: 'With Mobile No',
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter a mobile number';
//           }
//           return null;
//         },
//         enabled: selectedOption == 1,
//       ),
//     ),
//   ),
// ),

// Align(
//   alignment: Alignment.topLeft,
//   child: TextField(
//     onChanged: (value) {
//       unit = value;
//     },
//     decoration: InputDecoration(
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10)),
//         labelText: 'Unit'),
//     style:
//         const TextStyle(fontSize: 15, color: Colors.black),
//   ),
// ),
// const SizedBox(
//   height: 10,
// ),
// Align(
//   alignment: Alignment.topLeft,
//   child: TextField(
//     onChanged: (value) {
//       quantity = value;
//     },
//     decoration: InputDecoration(
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10)),
//         labelText: 'Quantity'),
//     style:
//         const TextStyle(fontSize: 15, color: Colors.black),
//   ),
// ),
// const SizedBox(
//   height: 10,
// ),
// Align(
//   alignment: Alignment.topLeft,
//   child: TextField(
//     onChanged: (value) {
//       rate = value;
//     },
//     decoration: InputDecoration(
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10)),
//         labelText: 'Rate'),
//     style:
//         const TextStyle(fontSize: 15, color: Colors.black),
//   ),
// ),

// onPressed: () {
//   if (!formKey.currentState!.validate()) {
//     print('Validation Error');
//   } else {
//     if (!(polytheneSmallChecked! ||
//         polytheneBigChecked! ||
//         deliveryChecked! ||
//         maintenanceChecked!)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content:
//               Text('Please select at least one checkbox'),
//         ),
//       );
//     }
//     print(
//         "submit successful selectedProduct: ${selectedProduct}");
//     print(
//         "submit successful selectedProduct: ${selectedUnit}");
//     print(
//         "submit successful selectedProduct: ${selectedQuantity}");
//     print(
//         "submit successful selectedProduct: ${selectedRate}");
//   }
// },

// Future<void> _fetchProductList() async {
//   final response = await http.get(
//     Uri.parse(
//         "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productlist"),
//     headers: {'X-API-KEY': 'amritmayamilk050512'},
//   );
//   print(
//       "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productlist");
//   if (response.statusCode == 200) {
//     print('API Response: ${response.body}');
//     productList.clear();
//     final jsonBody = json.decode(response.body);
//     final productListData = ProductList.fromJson(jsonBody);
//     setState(() {
//       productList = productListData.productList;
//     });
//   } else {
//     print('Failed to fetch product list: ${response.statusCode}');
//   }
// }

// Future<void> _fetchProductUnitList(String, productId) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final response = await http.get(
//     Uri.parse(
//         'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productunit?product_id=$productId'),
//     headers: {'X-API-KEY': 'amritmayamilk050512'},
//   );
//   print(
//       'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productunit?product_id=$productId');
//   if (response.statusCode == 200) {
//     final jsonBody = json.decode(response.body);
//     final productUnitData = ProductUnitList.fromJson(jsonBody);
//     setState(() {
//       productunitList = productUnitData.productunitList;
//     });
//   } else {
//     print('Failed to fetch product units: ${response.statusCode}');
//   }
// }
//
// Future<void> _fetchProductQntList(String, productId, unitId) async {
//   final response = await http.get(
//     Uri.parse(
//         "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId"),
//     headers: {'X-API-KEY': 'amritmayamilk050512'},
//   );
//   print(
//       "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId");
//   if (response.statusCode == 200) {
//     final jsonBody = json.decode(response.body);
//     print(jsonBody);
//     final productQntData = ProductQuantityList.fromJson(jsonBody);
//     setState(() {
//       productqntList = productQntData.productqntList;
//     });
//   } else {
//     print('Failed to fetch product units: ${response.statusCode}');
//   }
// }
//
// Future<void> _fetchProductRateList(
//     String, productId, unitId, quantityId) async {
//   final response = await http.get(
//     Uri.parse(
//         'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId'),
//     headers: {'X-API-KEY': 'amritmayamilk050512'},
//   );
//   print(
//       "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId");
//   if (response.statusCode == 200) {
//     final jsonBody = json.decode(response.body);
//     print(jsonBody);
//     final productRateData = ProductRateList.fromJson(jsonBody);
//     setState(() {
//       productrateList = productRateData.productrateList;
//     });
//   } else {
//     print('Failed to fetch product units: ${response.statusCode}');
//   }
// }

// Align(
//   alignment: Alignment.topLeft,
//   child: DropdownButtonFormField<String>(
//     value: selectedRate,
//     hint: const Text(
//       'Rate',
//       style: TextStyle(fontSize: 15, color: Colors.black),
//     ),
//     onChanged: (String? newValue) {
//       setState(() {
//         selectedRate = newValue;
//       });
//     },
//     validator: (value) {
//       if (value == null || value.isEmpty) {
//         return 'Please select an option';
//       }
//       return null;
//     },
//     icon: const Icon(
//       Icons.arrow_drop_down_circle,
//       color: Colors.blue,
//     ),
//     dropdownColor: Colors.deepPurple.shade50,
//     decoration: InputDecoration(
//       labelText: "Rate",
//       prefixIcon: const Icon(
//         Icons.price_change_outlined,
//         color: Colors.blue,
//       ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: const BorderSide(
//           color: Colors.black87,
//         ),
//       ),
//     ),
//     items: productrateList != null
//         ? [productrateList?.rate].map((rate) {
//             return DropdownMenuItem<String>(
//               value: rate,
//               child: Text(rate!),
//             );
//           }).toList()
//         : [],
//   ),
// ),
