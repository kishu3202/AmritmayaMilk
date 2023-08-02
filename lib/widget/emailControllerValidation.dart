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

// FutureBuilder<Map<String, dynamic>>(
//   future: getProductListData(context),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState ==
//         ConnectionState.waiting) {
//       return CircularProgressIndicator();
//     } else if (snapshot.hasError) {
//       return Text("Error: ${snapshot.error}");
//     } else if (!(snapshot.data?['status'] ?? false)) {
//       return Text('Error: ${snapshot.data?['msg']}');
//     } else {
//       List<ProductList> productList =
//           Provider.of<ProductListProvider>(context)
//               .productList!;
//       return FutureBuilder<String?>(
//         future: Provider.of<ProductListProvider>(context)
//             .getSelectedProductId(),
//         builder: (context, snapshot) {
//           String? selectedProductId = snapshot.data;
//           return DropdownButton<String>(
//             items: productList.map((product) {
//               return DropdownMenuItem<String>(
//                 value: product.id,
//                 child: Text(product.name),
//               );
//             }).toList(),
//             value:
//                 selectedProductId ?? productList.first.,
//             onChanged:
//                 (String? newSelectedProductId) async {
//               await Provider.of<ProductListProvider>(
//                       context,
//                       listen: false)
//                   .saveSelectedProductId(
//                       newSelectedProductId!);
//             },
//           );
//         },
//       );
//     }
//   },
// ),
// const SizedBox(
//   height: 10,
// ),
// // FutureBuilder(
// //     future: getProductUnitData(context, productId),
// //     builder: (context, snapshot) => Consumer<
// //             ProductUnitProvider>(
// //         builder: (con, productQuantityInfo, _) => Align(
// //               alignment: Alignment.topLeft,
// //               child: DropdownButtonFormField<String>(
// //                 value: selectedUnit,
// //                 hint: const Text(
// //                   'Unit',
// //                   style: TextStyle(
// //                       fontSize: 15, color: Colors.black),
// //                 ),
// //                 onChanged: (String? newValue) async {
// //                   setState(() {
// //                     selectedUnit = newValue;
// //                     selectedQuantity = null;
// //                     selectedRate = null;
// //                     print('Selected Unit: $selectedUnit');
// //                     int selectedUnitIndex = Strings
// //                         .productUnitNameList
// //                         .indexOf(newValue!);
// //                     String? unitId = Strings
// //                         .productUnitIdList
// //                         .elementAt(selectedUnitIndex);
// //                     print(unitId);
// //                   });
// //                   if (selectedProduct != null &&
// //                       selectedUnit != null) {
// //                     final productId = Provider.of<
// //                                 ProductListProvider>(
// //                             context,
// //                             listen: false)
// //                         .productIdList
// //                         .elementAt(Provider.of<
// //                                     ProductListProvider>(
// //                                 context,
// //                                 listen: false)
// //                             .productNameList
// //                             .indexOf(selectedProduct!));
// //                     await getProductQuantityData(context,
// //                         productId, selectedUnit!);
// //                   }
// //                 },
// //                 items: Provider.of<ProductUnitProvider>(
// //                         context,
// //                         listen: false)
// //                     .productUnitNameList
// //                     .map<DropdownMenuItem<String>>(
// //                   (String value) {
// //                     return DropdownMenuItem<String>(
// //                       value: value,
// //                       child: Text(
// //                         value,
// //                         style: TextStyle(fontSize: 18),
// //                       ),
// //                     );
// //                   },
// //                 ).toList(),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please select an option';
// //                   }
// //                   return null;
// //                 },
// //                 icon: const Icon(
// //                   Icons.arrow_drop_down_circle,
// //                   color: Colors.blue,
// //                 ),
// //                 dropdownColor: Colors.deepPurple.shade50,
// //                 decoration: InputDecoration(
// //                   labelText: "Unit",
// //                   prefixIcon: const Icon(
// //                     Icons.shopping_cart,
// //                     color: Colors.blue,
// //                   ),
// //                   border: OutlineInputBorder(
// //                     borderRadius:
// //                         BorderRadius.circular(10),
// //                     borderSide: const BorderSide(
// //                       color: Colors.black87,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ))),
// // const SizedBox(
// //   height: 10,
// // ),
// // FutureBuilder(
// //     future: getProductQuantityData(
// //         context, productId, unitId),
// //     builder: (context, snapshot) => Consumer<
// //             ProductQuantityProvider>(
// //         builder: (con, productQuantityInfo, _) => Align(
// //               alignment: Alignment.topLeft,
// //               child: DropdownButtonFormField<String>(
// //                 value: selectedQuantity,
// //                 hint: const Text(
// //                   'Quantity',
// //                   style: TextStyle(
// //                       fontSize: 15, color: Colors.black),
// //                 ),
// //                 onChanged: (String? newValue) async {
// //                   setState(() {
// //                     selectedQuantity = newValue;
// //                     selectedRate = null;
// //                     print(
// //                         'Selected Quantity: $selectedQuantity');
// //                     int selectedQuantityIndex = Strings
// //                         .productQuantityNameList
// //                         .indexOf(newValue!);
// //                     String? quantityId = Strings
// //                         .productQuantityIdList
// //                         .elementAt(selectedQuantityIndex);
// //                     print(quantityId);
// //                   });
// //                   if (selectedProduct != null &&
// //                       selectedUnit != null &&
// //                       selectedQuantity != null) {
// //                     final productId = Provider.of<
// //                                 ProductListProvider>(
// //                             context,
// //                             listen: false)
// //                         .productIdList
// //                         .elementAt(Provider.of<
// //                                     ProductListProvider>(
// //                                 context,
// //                                 listen: false)
// //                             .productNameList
// //                             .indexOf(selectedProduct!));
// //                     await getProductRateData(
// //                         context,
// //                         productId,
// //                         selectedUnit!,
// //                         selectedQuantity!);
// //                   }
// //                 },
// //                 items:
// //                     Provider.of<ProductQuantityProvider>(
// //                             context,
// //                             listen: false)
// //                         .productQuantityIdList
// //                         .map<DropdownMenuItem<String>>(
// //                   (String value) {
// //                     return DropdownMenuItem<String>(
// //                       value: value,
// //                       child: Text(
// //                         value,
// //                         style: TextStyle(fontSize: 18),
// //                       ),
// //                     );
// //                   },
// //                 ).toList(),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please select an option';
// //                   }
// //                   return null;
// //                 },
// //                 icon: const Icon(
// //                   Icons.arrow_drop_down_circle,
// //                   color: Colors.blue,
// //                 ),
// //                 dropdownColor: Colors.deepPurple.shade50,
// //                 decoration: InputDecoration(
// //                   labelText: "Quantity",
// //                   prefixIcon: const Icon(
// //                     Icons.shopping_cart,
// //                     color: Colors.blue,
// //                   ),
// //                   border: OutlineInputBorder(
// //                     borderRadius:
// //                         BorderRadius.circular(10),
// //                     borderSide: const BorderSide(
// //                       color: Colors.black87,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ))),
// // const SizedBox(
// //   height: 10,
// // ),
// // FutureBuilder(
// //     future: getProductRateData(
// //         context, productId, unitId, quantityId),
// //     builder: (context, snapshot) => Consumer<
// //             ProductRateProvider>(
// //         builder: (con, productInfo, _) => Align(
// //               alignment: Alignment.topLeft,
// //               child: DropdownButtonFormField<String>(
// //                 value: selectedRate,
// //                 hint: const Text(
// //                   'Rate',
// //                   style: TextStyle(
// //                       fontSize: 15, color: Colors.black),
// //                 ),
// //                 onChanged: (String? newValue) {
// //                   setState(() {
// //                     selectedRate = newValue;
// //                     print('Selected Rate: $selectedRate');
// //                   });
// //                 },
// //                 items: Provider.of<ProductRateProvider>(
// //                         context,
// //                         listen: false)
// //                     .productRateIdList
// //                     .map<DropdownMenuItem<String>>(
// //                   (String value) {
// //                     return DropdownMenuItem<String>(
// //                       value: value,
// //                       child: Text(
// //                         value,
// //                         style: TextStyle(fontSize: 18),
// //                       ),
// //                     );
// //                   },
// //                 ).toList(),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please select an option';
// //                   }
// //                   return null;
// //                 },
// //                 icon: const Icon(
// //                   Icons.arrow_drop_down_circle,
// //                   color: Colors.blue,
// //                 ),
// //                 dropdownColor: Colors.deepPurple.shade50,
// //                 decoration: InputDecoration(
// //                   labelText: "Rate",
// //                   prefixIcon: const Icon(
// //                     Icons.shopping_cart,
// //                     color: Colors.blue,
// //                   ),
// //                   border: OutlineInputBorder(
// //                     borderRadius:
// //                         BorderRadius.circular(10),
// //                     borderSide: const BorderSide(
// //                       color: Colors.black87,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ))),

// FutureBuilder(
//     future: getProductListData(context),
//     builder: (context, snapshot) => Consumer<
//             ProductListProvider>(
//         builder: (con, productInfo, _) => Align(
//               alignment: Alignment.topLeft,
//               child: DropdownButtonFormField<String>(
//                 value: selectedProduct,
//                 hint: const Text(
//                   'Product Name',
//                   style: TextStyle(
//                       fontSize: 15, color: Colors.black),
//                 ),
//                 onChanged: (String? newValue) async {
//                   setState(() async {
//                     selectedProduct = newValue;
//                     // print(
//                     //     'Selected Product: $selectedProduct');
//                     int selectedProductIndex = Strings
//                         .productNameList
//                         .indexOf(newValue!);
//                     productId = Strings.productIdList
//                         .elementAt(selectedProductIndex);
//                     print(productId);
//                   });
//                 },
//                 items: Strings.productNameList
//                     .map<DropdownMenuItem<String>>(
//                         (String value) {
//                   print(value);
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   );
//                 }).toList(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select an option';
//                   }
//                   return null;
//                 },
//                 icon: const Icon(
//                   Icons.arrow_drop_down_circle,
//                   color: Colors.blue,
//                 ),
//                 dropdownColor: Colors.deepPurple.shade50,
//                 decoration: InputDecoration(
//                   labelText: "Product Name",
//                   prefixIcon: const Icon(
//                     Icons.shopping_cart,
//                     color: Colors.blue,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(10),
//                     borderSide: const BorderSide(
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ),
//             ))),
// const SizedBox(
//   height: 10,
// ),
// FutureBuilder(
//     future: getProductUnitData(context, productId),
//     builder: (context, snapshot) => Consumer<
//             ProductListProvider>(
//         builder: (con, productUnitInfo, _) => Align(
//               alignment: Alignment.topLeft,
//               child: DropdownButtonFormField<String>(
//                 value: selectedUnit,
//                 hint: const Text(
//                   'Unit',
//                   style: TextStyle(
//                       fontSize: 15, color: Colors.black),
//                 ),
//                 onChanged: (String? newValue) async {
//                   setState(() async {
//                     selectedUnit = newValue;
//                     print('Selected Unit: $selectedUnit');
//                     int selectedUnitIndex = Strings
//                         .productUnitNameList
//                         .indexOf(newValue!);
//                     unitId = Strings.productUnitIdList
//                         .elementAt(selectedUnitIndex);
//                     print(unitId);
//                     // if (newValue != unitId) {
//                     //   // Rebuild the widget to update the dropdown.
//                     //   setState(() {});
//                     //
//                     //   SharedPreferences prefs1 =
//                     //       await SharedPreferences
//                     //           .getInstance();
//                     //   prefs1.setString('unit_id', unitId);
//                     //
//                     //
//                     // }
//                     getProductQuantityData(
//                         con, productId, unitId);
//                   });
//                 },
//                 items: Strings.productUnitNameList
//                     .map<DropdownMenuItem<String>>(
//                         (String value) {
//                   print(value);
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   );
//                 }).toList(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select an option';
//                   }
//                   return null;
//                 },
//                 icon: const Icon(
//                   Icons.arrow_drop_down_circle,
//                   color: Colors.blue,
//                 ),
//                 dropdownColor: Colors.deepPurple.shade50,
//                 decoration: InputDecoration(
//                   labelText: "Unit",
//                   prefixIcon: const Icon(
//                     Icons.shopping_cart,
//                     color: Colors.blue,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(10),
//                     borderSide: const BorderSide(
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ),
//             ))),
// const SizedBox(
//   height: 10,
// ),
// FutureBuilder(
//     future: getProductQuantityData(
//         context, productId, unitId),
//     builder: (context, snapshot) => Consumer<
//             ProductQuantityProvider>(
//         builder: (con, productQuantityInfo, _) => Align(
//               alignment: Alignment.topLeft,
//               child: DropdownButtonFormField<String>(
//                 value: selectedQuantity,
//                 hint: const Text(
//                   'Quantity',
//                   style: TextStyle(
//                       fontSize: 15, color: Colors.black),
//                 ),
//                 onChanged: (String? newValue) {
//                   setState(() async {
//                     selectedQuantity = newValue;
//                     print(
//                         'Selected Quantity: $selectedQuantity');
//                     // int selectedQuantityIndex = Strings
//                     //     .productQuantityNameList
//                     //     .indexOf(newValue!);
//                     //  quantityId = Strings
//                     //     .productQuantityIdList
//                     //     .elementAt(selectedQuantityIndex);
//                     // print(quantityId);
//
//                     // if (quantityId == null) {
//                     //   showDialog(
//                     //       context: context,
//                     //       builder: (context) =>
//                     //           AlertDialog(
//                     //             title: Text('Error'),
//                     //             content: Text(
//                     //                 'Quantity ID is not found'),
//                     //             actions: [
//                     //               TextButton(
//                     //                   onPressed: () =>
//                     //                       Navigator.pop(
//                     //                           context),
//                     //                   child:
//                     //                       Text('Close'))
//                     //             ],
//                     //           ));
//                     // } else {
//                     // Save the quantity ID in shared preferences.
//                     SharedPreferences prefs =
//                         await SharedPreferences
//                             .getInstance();
//                     prefs.setString(
//                         'main_qnt', quantityId);
//
//                     getProductRateData(con, productId,
//                         unitId, selectedQuantity!);
//                   });
//                 },
//                 items: Strings.productQuantityNameList
//                     .map<DropdownMenuItem<String>>(
//                         (String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   );
//                 }).toList(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select an option';
//                   }
//                   return null;
//                 },
//                 icon: const Icon(
//                   Icons.arrow_drop_down_circle,
//                   color: Colors.blue,
//                 ),
//                 dropdownColor: Colors.deepPurple.shade50,
//                 decoration: InputDecoration(
//                   labelText: "Quantity",
//                   prefixIcon: const Icon(
//                     Icons.shopping_cart,
//                     color: Colors.blue,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(10),
//                     borderSide: const BorderSide(
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ),
//             ))),
// const SizedBox(
//   height: 10,
// ),
// FutureBuilder(
//     future: getProductRateData(
//         context, productId, unitId, quantityId),
//     builder: (context, snapshot) => Consumer<
//             ProductRateProvider>(
//         builder: (con, productInfo, _) => Align(
//               alignment: Alignment.topLeft,
//               child: DropdownButtonFormField<String>(
//                 value: selectedRate,
//                 hint: const Text(
//                   'Rate',
//                   style: TextStyle(
//                       fontSize: 15, color: Colors.black),
//                 ),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedRate = newValue;
//                     print('Selected Rate: $selectedRate');
//                   });
//                 },
//                 items: Strings.productRateIdList
//                     .map<DropdownMenuItem<String>>(
//                         (String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   );
//                 }).toList(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select an option';
//                   }
//                   return null;
//                 },
//                 icon: const Icon(
//                   Icons.arrow_drop_down_circle,
//                   color: Colors.blue,
//                 ),
//                 dropdownColor: Colors.deepPurple.shade50,
//                 decoration: InputDecoration(
//                   labelText: "Rate",
//                   prefixIcon: const Icon(
//                     Icons.shopping_cart,
//                     color: Colors.blue,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(10),
//                     borderSide: const BorderSide(
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ),
//             ))),

// import 'dart:convert';
// import 'dart:io';
//
// import 'package:amritmaya_milk/data/productList_data_model.dart';
// import 'package:amritmaya_milk/widget/string.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ProductListProvider extends ChangeNotifier {
//   List<ProductList>? post;
//   bool loading = false;
//
//   Future<Map<String, dynamic>> getProductNameList() async {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     // String productId = prefs.getString('id') ?? '';
//
//     Map<String, dynamic> responseMap = {
//       'status': false,
//       'msg': '',
//     };
//     try {
//       final res = await http.get(
//           Uri.parse(
//               "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productlist"),
//           headers: {
//             "Content-Type": "application/json",
//             "X-API-KEY": "amritmayamilk050512",
//           });
//
//       print(
//           "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productlist");
//       final response = json.decode(res.body) as Map<String, dynamic>;
//       if (res.statusCode == 200) {
//         responseMap['status'] = true;
//
//         Strings.productIdList.clear();
//         Strings.productNameList.clear();
//
//         final response1 = response["productList"];
//         response1.forEach((id) {
//           Strings.productIdList.add(id["id"]);
//           Strings.productNameList.add(id["name"]);
//         });
//
//         notifyListeners();
//         return responseMap;
//       } else {
//         responseMap['status'] = false;
//         responseMap['msg'] = 'Failed';
//         return responseMap;
//       }
//     } on SocketException {
//       responseMap['status'] = false;
//       responseMap['msg'] = 'No Internet Connectivity';
//       return responseMap;
//     } catch (e) {
//       print(e.toString());
//       responseMap['status'] = false;
//       responseMap['msg'] = 'Please try again later';
//       return responseMap;
//     }
//   }
//
//   Future<Map<String, dynamic>> getProductUnitList(productId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String unitId = prefs.getString('unit_id') ?? '';
//     Map<String, dynamic> responseMap = {
//       'status': false,
//       'msg': '',
//     };
//     try {
//       final res = await http.get(
//           Uri.parse(
//               "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productunit?product_id=$productId"),
//           headers: {
//             "Content-Type": "application/json",
//             "X-API-KEY": "amritmayamilk050512",
//           });
//       print(
//           "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productunit?product_id=$productId");
//       final response = json.decode(res.body) as Map<String, dynamic>;
//       if (res.statusCode == 200) {
//         responseMap['status'] = true;
//
//         Strings.productUnitIdList.clear();
//         Strings.productUnitNameList.clear();
//
//         final response1 = response["productunitList"];
//         response1.forEach((id) {
//           Strings.productUnitIdList.add(id["unit_id"]);
//           Strings.productUnitNameList.add(id["name"]);
//           print(Strings.productUnitNameList);
//           print("****************************************");
//         });
//         notifyListeners();
//         return responseMap;
//       } else {
//         responseMap['status'] = false;
//         responseMap['msg'] = 'Failed';
//         return responseMap;
//       }
//     } on SocketException {
//       responseMap['status'] = false;
//       responseMap['msg'] = 'No Internet Connectivity';
//       return responseMap;
//     } catch (e) {
//       print(e.toString());
//       responseMap['status'] = false;
//       responseMap['msg'] = 'Please try again later';
//       return responseMap;
//     }
//   }
//
//   Future<Map<String, dynamic>> getProductQuantityList(productId, unitId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String quantityId = prefs.getString('main_qnt') ?? '';
//     Map<String, dynamic> responseMap = {
//       'status': false,
//       'msg': '',
//     };
//     try {
//       final res = await http.get(
//           Uri.parse(
//               "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId"),
//           headers: {
//             "Content-Type": "application/json",
//             "X-API-KEY": "amritmayamilk050512",
//           });
//       print(
//           "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId");
//       final response = json.decode(res.body) as Map<String, dynamic>;
//       if (res.statusCode == 200) {
//         responseMap['status'] = true;
//
//         Strings.productQuantityIdList.clear();
//
//         final response1 = response["productqntList"];
//         response1.forEach((id) {
//           Strings.productQuantityIdList.add(id["qnt"]);
//           print(Strings.productQuantityIdList);
//         });
//         notifyListeners();
//         return responseMap;
//       } else {
//         responseMap['status'] = false;
//         responseMap['msg'] = 'Failed';
//         return responseMap;
//       }
//     } on SocketException {
//       responseMap['status'] = false;
//       responseMap['msg'] = 'No Internet Connectivity';
//       return responseMap;
//     } catch (e) {
//       print(e.toString());
//       responseMap['status'] = false;
//       responseMap['msg'] = 'Please try again later';
//       return responseMap;
//     }
//   }
//
//   Future<Map<String, dynamic>> getProductRateList(
//       productId, unitId, quantityId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String rate = prefs.getString('rate') ?? '';
//     Map<String, dynamic> responseMap = {
//       'status': false,
//       'msg': '',
//     };
//     try {
//       final res = await http.get(
//           Uri.parse(
//               "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId"),
//           headers: {
//             "Content-Type": "application/json",
//             "X-API-KEY": "amritmayamilk050512",
//           });
//       print(
//           "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId");
//       final response = json.decode(res.body) as Map<String, dynamic>;
//       if (res.statusCode == 200) {
//         responseMap['status'] = true;
//
//         Strings.productRateIdList.clear();
//
//         final response1 = response["productrateList"];
//         response1.forEach((id) {
//           Strings.productRateIdList.add(id["rate"]);
//           print(Strings.productRateIdList);
//         });
//         notifyListeners();
//         return responseMap;
//       } else {
//         responseMap['status'] = false;
//         responseMap['msg'] = 'Failed';
//         return responseMap;
//       }
//     } on SocketException {
//       responseMap['status'] = false;
//       responseMap['msg'] = 'No Internet Connectivity';
//       return responseMap;
//     } catch (e) {
//       print(e.toString());
//       responseMap['status'] = false;
//       responseMap['msg'] = 'Please try again later';
//       return responseMap;
//     }
//   }
// }

// Future<void> getProductListData(BuildContext con) async {
//   final bid = Provider.of<ProductListProvider>(context, listen: false);
//   final res = await bid.getProductNameList();
// }
//
// Future<void> getProductUnitData(BuildContext con, String productId) async {
//   fetchUnitId();
//   final bid = Provider.of<ProductListProvider>(context, listen: false);
//   final res = await bid.getProductUnitList(productId);
//   final unitId = res["unitId"];
// }
//
// Future<void> getProductQuantityData(
//     BuildContext con, String productId, String unitId) async {
//   fetchQuantityId();
//   final bid = Provider.of<ProductQuantityProvider>(context, listen: false);
//   final res = await bid.getProductQuantityList(productId, unitId);
//   final quantityId = res["quantityId"];
// }
//
// Future<void> getProductRateData(BuildContext con, String productId,
//     String unitId, String selectedQuantity) async {
//   final bid = Provider.of<ProductRateProvider>(context, listen: false);
//   final res =
//       await bid.getProductRateList(productId, unitId, selectedQuantity);
//   final rate = res['rate'];
// }

// void fetchProductId() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   setState(() {
//     productId = prefs.getString('id') ?? '';
//   });
// }
//
// void fetchUnitId() async {
//   SharedPreferences prefs1 = await SharedPreferences.getInstance();
//   setState(() {
//     unitId = prefs1.getString('unit_id') ?? '';
//
//     if (unitId != '') {
//       print('Unit ID: $unitId');
//     }
//   });
// }
//
// void fetchQuantityId() async {
//   SharedPreferences prefs2 = await SharedPreferences.getInstance();
//   setState(() {
//     quantityId = prefs2.getString('main_qnt') ?? '';
//
//     if (quantityId != '') {
//       print('Quantity ID: $quantityId');
//     }
//   });
// }
//
// void fetchRate() async {
//   SharedPreferences prefs3 = await SharedPreferences.getInstance();
//   setState(() {
//     rate = prefs3.getString('rate') ?? '';
//
//     if (rate != '') {
//       print('Rate: $rate');
//     }
//   });
// }
