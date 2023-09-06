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
        prefixIcon: const Icon(Icons.email),
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          print('Please enter an EmailId');
        } else if (!validateEmailFormat(value)) {
          print('Please enter a valid email format: test@gmail.com');
        }
      },
    );
  }
}

//// submit data api
// var headers = {
//   'X-API-KEY': 'amritmayamilk050512',
// };
// var uri = Uri.parse(
//     'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedProduct');
// var data = {
//   'customer_id': widget.customerId.toString(),
//   'staff_id': userId,
// };
// print('Selected Product List: ${selectedProductId}');
// print('Selected Unit List: ${selectedUnitId}');
// print('Selected Quantity List: ${productData.selectedQuantity}');
// print('Selected Rate List: ${productData.selectedRate}');
// print('Other Charge List: ${productData.otherCharge}');
// print('Other ID List: ${otherId}');
// Map<String, dynamic> listParam = {
// //list parameters add
// "product_id[]": '',
// "unit_id[]": '',
// "qnt[]": '',
// "rate[]": '',
// "other_charges[]": '',
// "other_id[]": '',
// "customer_id": '',
// };
//
// for (int i = 0; i < selectedProductId!.length; i++) {
// data['product_id[]'] = selectedProductId![i];
// data['unit_id[]'] = selectedUnitId![i];
// data['qnt[]'] = selectedQuantity![i];
// data['rate[]'] = selectedRate![i];
// data['other_charges[]'] = productData.otherCharge[i];
// // data['other_id[]'] = otherId[i];
// if (i < otherId.length) {
// data['other_id[]'] = otherId[i];
// } else {
// data['other_id[]'] = ''; // Or any default value
// }
// Map<String, dynamic> remainingParam = {
// // without list parametr
// "staff_id": userId,
// };
// Map<String, dynamic> allParams = {
// // all parameter
// "staff_id": userId,
// "product_id[]": selectedProductId,
// "unit_id[]": selectedUnitId,
// "qnt[]": selectedQuantity,
// "rate[]": selectedRate,
// "other_charges[]": otherCharge,
// "other_id[]": otherId,
// "customer_id": widget.customerId,
// };
// listParam.addAll(data);
// remainingParam.addAll(data);
// allParams.addAll(data);
// }
// var response = await http.post(uri, headers: headers, body: data);
// if (response.statusCode == 200) {
// final jsonData = json.decode(response.body);
// print('Response JSON Data: $jsonData');
// print('Success: ${jsonData["Success"]}');
// print(jsonData["Success"]);
// _showToastMessage("Daily Need has been saved Successfully");
//
// final dailyNeedProvider =
// Provider.of<DailyNeedProductProvider>(context, listen: false);
// await dailyNeedProvider.getPostDailyNeedProduct(widget.customerId);
// dailyNeedProvider.notifyListeners();
// } else {
// Fluttertoast.showToast(
// msg: "Error Occurred", timeInSecForIosWeb: 25);
// }
// } catch (e) {
// print('Error during data submission: $e');
// _showToastMessage('Failed to save Daily Need');
// }
// }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

// Card(
//   shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(5.0),
//       side: const BorderSide(
//         color: Colors.black,
//       )),
//   child: Padding(
//     padding: const EdgeInsets.all(10.0),
//     child: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Builder(builder: (context) {
//                 final productData =
//                     Provider.of<ProductListProvider>(context,
//                         listen: false);
//                 return FutureBuilder(
//                   future: productData.fetchProductNames(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       return DropdownButtonFormField<String>(
//                         hint: const Text(
//                           'Product Name',
//                           style: TextStyle(
//                               fontSize: 15, color: Colors.black),
//                         ),
//                         value: productData.selectedProduct,
//                         items: productData.productNameList
//                             .map((String value) {
//                           return DropdownMenuItem<String>(
//                             value: productData.productIdList[
//                                 productData.productNameList
//                                     .indexOf(value)],
//                             child: Text(value),
//                           );
//                         }).toList(),
//                         onChanged: (String? selectedValue) {
//                           productData
//                               .setSelectedProduct(selectedValue!);
//                           productData.fetchUnitIds(
//                               productData.selectedProduct!);
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please select an option';
//                           }
//                           return null;
//                         },
//                         icon: const Icon(
//                           Icons.arrow_drop_down_circle,
//                           color: Colors.blue,
//                         ),
//                         dropdownColor: Colors.deepPurple.shade50,
//                         decoration: InputDecoration(
//                           labelText: "Product Name",
//                           prefixIcon: const Icon(
//                             Icons.shopping_bag_outlined,
//                             color: Colors.blue,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.circular(10),
//                             borderSide: const BorderSide(
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 );
//               }),
//               SizedBox(height: 20),
//               Consumer<ProductListProvider>(
//                 builder: (context, productData, _) {
//                   return DropdownButtonFormField<String>(
//                     hint: const Text(
//                       'Unit',
//                       style: TextStyle(
//                           fontSize: 15, color: Colors.black),
//                     ),
//                     value: productData.selectedUnit,
//                     items: productData.unitNameList
//                         .map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: productData.unitIdList[productData
//                             .unitNameList
//                             .indexOf(value)],
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? selectedValue) {
//                       selectedUnit = selectedValue!;
//                       productData
//                           .setSelectedUnitId(selectedValue!);
//                       productData.fetchQuantityIds(
//                         productData.selectedProduct!,
//                         productData.selectedUnit!,
//                       );
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select an option';
//                       }
//                       return null;
//                     },
//                     icon: const Icon(
//                       Icons.arrow_drop_down_circle,
//                       color: Colors.blue,
//                     ),
//                     dropdownColor: Colors.deepPurple.shade50,
//                     decoration: InputDecoration(
//                       labelText: "Unit",
//                       prefixIcon: const Icon(
//                         Icons.ad_units_outlined,
//                         color: Colors.blue,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: const BorderSide(
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 20),
//               Consumer<ProductListProvider>(
//                 builder: (context, productData, _) {
//                   return DropdownButtonFormField<String>(
//                     hint: const Text(
//                       'Quantity',
//                       style: TextStyle(
//                           fontSize: 15, color: Colors.black),
//                     ),
//                     value: productData.selectedQuantity,
//                     items: productData.quantityList
//                         .map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: productData.quantityList[
//                             productData.quantityList
//                                 .indexOf(value)],
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? selectedValue) {
//                       quantityId = selectedValue!;
//                       productData
//                           .setSelectedQuantityId(selectedValue);
//                       productData.fetchRates(
//                           productData.selectedProduct!,
//                           productData.selectedUnit!,
//                           productData.selectedQuantity!);
//                       print(selectedQuantity);
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select an option';
//                       }
//                       return null;
//                     },
//                     icon: const Icon(
//                       Icons.arrow_drop_down_circle,
//                       color: Colors.blue,
//                     ),
//                     dropdownColor: Colors.deepPurple.shade50,
//                     decoration: InputDecoration(
//                       labelText: "Quantity",
//                       prefixIcon: const Icon(
//                         Icons.production_quantity_limits,
//                         color: Colors.blue,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: const BorderSide(
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 20),
//               Consumer<ProductListProvider>(
//                 builder: (context, productData, _) {
//                   print('Rate List: ${productData.rateList}');
//                   return DropdownButtonFormField<String>(
//                     hint: const Text(
//                       'Rate',
//                       style: TextStyle(
//                           fontSize: 15, color: Colors.black),
//                     ),
//                     value: productData.selectedRate,
//                     items:
//                         productData.rateList.map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? selectedValue) {
//                       rate = selectedValue!;
//                       productData
//                           .setSelectedRateId(selectedValue!);
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select an option';
//                       }
//                       return null;
//                     },
//                     icon: const Icon(
//                       Icons.arrow_drop_down_circle,
//                       color: Colors.blue,
//                     ),
//                     dropdownColor: Colors.deepPurple.shade50,
//                     decoration: InputDecoration(
//                       labelText: "Rate",
//                       prefixIcon: const Icon(
//                         Icons.monetization_on,
//                         color: Colors.blue,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: const BorderSide(
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       ElevatedButton(onPressed: () {}, child: Text('Add More')),
//     ],
//   ),
// ),

// Card(
//   shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(5.0),
//       side: const BorderSide(
//         color: Colors.black,
//       )),
//   child: Padding(
//     padding: const EdgeInsets.all(10.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Other Charges",
//           style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black),
//         ),
//         const SizedBox(
//           height: 16,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.deepPurple.shade50,
//                   border: Border.all(
//                     color: Colors.grey,
//                     width: 1.0,
//                   ),
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: Transform.translate(
//                   offset: const Offset(-10, 0),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 1),
//                     child: CheckboxListTile(
//                       // tristate: true,
//                       title: const Text(
//                         'Polythene charges (Small)',
//                         style: TextStyle(
//                             color: Colors.black87, fontSize: 15),
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         // side: BorderSide(color: Colors.grey),
//                       ),
//                       value: polytheneSmallChecked,
//                       onChanged: (value) {
//                         setState(() {
//                           polytheneSmallChecked = value;
//                         });
//                       },
//                       controlAffinity:
//                           ListTileControlAffinity.leading,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.deepPurple.shade50,
//                   border: Border.all(
//                     color: Colors.grey,
//                     width: 1.0,
//                   ),
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: Transform.translate(
//                   offset: const Offset(-10, 0),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 1),
//                     child: CheckboxListTile(
//                       // tristate: true,
//                       title: const Text(
//                         'Polythene charges (Big)',
//                         style: TextStyle(
//                             color: Colors.black87, fontSize: 15),
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         // side: BorderSide(color: Colors.grey),
//                       ),
//                       value: polytheneBigChecked,
//                       onChanged: (value) {
//                         setState(() {
//                           polytheneBigChecked = value;
//                         });
//                       },
//                       controlAffinity:
//                           ListTileControlAffinity.leading,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.deepPurple.shade50,
//                   border: Border.all(
//                     color: Colors.grey,
//                     width: 1.0,
//                   ),
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: Transform.translate(
//                   offset: const Offset(-10, 0),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 1),
//                     child: CheckboxListTile(
//                       // tristate: true,
//                       title: const Text(
//                         'Delivery charges',
//                         style: TextStyle(
//                             color: Colors.black87, fontSize: 15),
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         // side: BorderSide(color: Colors.grey),
//                       ),
//                       value: deliveryChecked,
//                       onChanged: (value) {
//                         setState(() {
//                           deliveryChecked = value;
//                         });
//                       },
//                       controlAffinity:
//                           ListTileControlAffinity.leading,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.deepPurple.shade50,
//                   border: Border.all(
//                     color: Colors.grey,
//                     width: 1.0,
//                   ),
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: Transform.translate(
//                   offset: const Offset(-10, 0),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 1),
//                     child: CheckboxListTile(
//                       // tristate: true,
//                       title: const Text(
//                         'Maintenance charges',
//                         style: TextStyle(
//                             color: Colors.black87, fontSize: 15),
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         // side: BorderSide(color: Colors.grey),
//                       ),
//                       value: maintenanceChecked,
//                       onChanged: (value) {
//                         setState(() {
//                           maintenanceChecked = value;
//                         });
//                       },
//                       controlAffinity:
//                           ListTileControlAffinity.leading,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),

// body: SizedBox(
//   height: MediaQuery.of(context).size.height,
//   width: MediaQuery.of(context).size.width,
//   child: ListView.builder(
//     shrinkWrap: true,
//     physics: NeverScrollableScrollPhysics(),
//     itemCount: dailyNeedList.length,
//     itemBuilder: (context, index) {
//       final dialNeed = dailyNeedList[index];
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Card(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0)),
//           color: Colors.deepPurple.shade50,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 8.0,
//               ),
//               Text(dailyNeedProvider.dialNeedList[index].name ?? ""),
//               SizedBox(
//                 height: 5.0,
//               ),
//               Text(dailyNeedProvider.dialNeedList[index].createdAt
//                       .toString() ??
//                   ""),
//               SizedBox(
//                 height: 5.0,
//               ),
//               Text(
//                 dailyNeedProvider.dialNeedList[index].orderId ?? "",
//               ),
//               SizedBox(
//                 height: 5.0,
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   ),
// ),

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

// Future<void> fetchRates(
//     String productId, String unitId, String quantityId) async {
//   try {
//     final res = await http.get(
//       Uri.parse(
//           "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId"),
//       headers: {
//         "Content-Type": "application/json",
//         "X-API-KEY": "amritmayamilk050512",
//       },
//     );
//
//     final response = json.decode(res.body) as Map<String, dynamic>;
//     print('API Response - Fetch Rates: $response');
//     if (res.statusCode == 200) {
//       rateList.clear();
//
//       final rateData = response["productrateList"];
//       if (rateData is Map<String, dynamic>) {
//         rateData.forEach((key, value) {
//           final rateValue = value;
//           rateList.add(rateValue.toString());
//         });
//       }
//       print('Fetched Rates: $rateList');
//       notifyListeners();
//     } else {
//       throw Exception('Failed to fetch rates');
//     }
//   } catch (e) {
//     print('Error fetching rates: $e');
//     throw Exception('Failed to fetch rates');
//   }
// }

// Future<void> submitDailyNeedProduct() async {
//   var headers = {
//     "Content-Type": "application/json",
//     'X-API-KEY': 'amritmayamilk050512',
//   };
//
//   var request = http.MultipartRequest(
//       'POST',
//       Uri.parse(
//           'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedProduct'));
//   request.fields.addAll({
//     'customer_id': 'widget.customerId',
//     'product_id[]': "selectedProduct",
//     'qnt[]': 'selectedQuantity',
//     'unit_id[]': 'selectedUnit',
//     'rate[]': 'selectedRate',
//     'staff_id': 'staffId',
//     'other_charges[]': 'selectedIds',
//     'other_id[]': 'otherId'
//   });
//   request.headers.addAll(headers);
//   try {
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       final jsonData = await response.stream.bytesToString();
//       final decoded = jsonDecode(jsonData);
//       print(decoded);
//       print(decoded["Success"]);
//     } else {
//       print(response.reasonPhrase);
//     }
//   } catch (e) {
//     debugPrint("cachedError${e.toString()}");
//   }
// }

// Future<void> _submitDailyNeedProduct(BuildContext context) async {
//   final productData =
//       Provider.of<ProductListProvider>(context, listen: false);
//
//   if (!formKey.currentState!.validate()) {
//     print('Please fill all the details');
//   } else {
//     if (productData.selectedIds.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.red,
//           content: Text(
//             'Please select at least one checkbox',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       );
//     } else {
//       try {
//         final requestData = {
//           'product_id[]': productData.selectedProduct,
//           'unit_id[]': productData.selectedUnit,
//           'qnt[]': productData.selectedQuantity,
//           'rate[]': productData.selectedRate,
//           'other_charges[]': productData.selectedIds,
//           'customer_id': widget.customerId,
//           'staff_id': productData.staffId,
//           'other_id[]': productData.otherId,
//         };
//         if (widget.savedDialNeedList != null) {
//           final savedDataList = json.decode(widget.savedDialNeedList);
//           if (savedDataList is List && savedDataList.isNotEmpty) {
//             final staffId = savedDataList[0]['productdetails'][0]['staff_id'];
//             requestData['staff_id'] = staffId;
//
//             final otherId =
//                 savedDataList[0]['other_charges'][0]['other_charges_id'];
//             requestData['other_id[]'] = otherId;
//           }
//         }
//         print('Request body: ${json.encode(requestData)}');
//
//         await productData.submit();
//         _showToastMessage("Daily Need has been saved Successfully");
//
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('submittedData', json.encode(requestData));
//         print('Submitted data stored in shared preferences: $requestData');
//
//         // Now update the dailyNeedList in the provider with the submitted data
//         final dailyNeedProvider =
//             Provider.of<DailyNeedProductProvider>(context, listen: false);
//         await dailyNeedProvider.getPostDailyNeedProduct(widget.customerId);
//         dailyNeedProvider.notifyListeners();
//       } catch (e) {
//         print('Error during data submission: $e');
//         _showToastMessage('Failed to save Daily Need');
//       }
//     }
//   }
// }

// Widget addProductCard() {
//   return Card(
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(5.0),
//         side: const BorderSide(
//           color: Colors.black,
//         )),
//     child: Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               children: [
//                 Builder(builder: (context) {
//                   final productData = Provider.of<ProductListProvider>(
//                       context,
//                       listen: false);
//                   return FutureBuilder(
//                     future: productData.fetchProductNames(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else {
//                         return DropdownButtonFormField<String>(
//                           hint: const Text(
//                             'Product Name',
//                             style:
//                             TextStyle(fontSize: 15, color: Colors.black),
//                           ),
//                           value: productData.selectedProduct,
//                           items:
//                           productData.productNameList.map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: productData.productIdList[
//                               productData.productNameList.indexOf(value)],
//                               child: Text(value),
//                             );
//                           }).toList(),
//                           onChanged: (String? selectedValue) {
//                             productData.setSelectedProduct(selectedValue!);
//                             productData
//                                 .fetchUnitIds(productData.selectedProduct!);
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please select an option';
//                             }
//                             return null;
//                           },
//                           icon: const Icon(
//                             Icons.arrow_drop_down_circle,
//                             color: Colors.blue,
//                           ),
//                           dropdownColor: Colors.deepPurple.shade50,
//                           decoration: InputDecoration(
//                             labelText: "Product Name",
//                             prefixIcon: const Icon(
//                               Icons.shopping_bag_outlined,
//                               color: Colors.blue,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: const BorderSide(
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   );
//                 }),
//                 SizedBox(height: 20),
//                 Consumer<ProductListProvider>(
//                   builder: (context, productData, _) {
//                     return DropdownButtonFormField<String>(
//                       hint: const Text(
//                         'Unit',
//                         style: TextStyle(fontSize: 15, color: Colors.black),
//                       ),
//                       value: productData.selectedUnit,
//                       items: productData.unitNameList.map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: productData.unitIdList[
//                           productData.unitNameList.indexOf(value)],
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? selectedValue) {
//                         selectedUnit = selectedValue!;
//                         productData.setSelectedUnitId(selectedValue!);
//                         productData.fetchQuantityIds(
//                           productData.selectedProduct!,
//                           productData.selectedUnit!,
//                         );
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select an option';
//                         }
//                         return null;
//                       },
//                       icon: const Icon(
//                         Icons.arrow_drop_down_circle,
//                         color: Colors.blue,
//                       ),
//                       dropdownColor: Colors.deepPurple.shade50,
//                       decoration: InputDecoration(
//                         labelText: "Unit",
//                         prefixIcon: const Icon(
//                           Icons.ad_units_outlined,
//                           color: Colors.blue,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Consumer<ProductListProvider>(
//                   builder: (context, productData, _) {
//                     return DropdownButtonFormField<String>(
//                       hint: const Text(
//                         'Quantity',
//                         style: TextStyle(fontSize: 15, color: Colors.black),
//                       ),
//                       value: productData.selectedQuantity,
//                       items: productData.quantityList.map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: productData.quantityList[
//                           productData.quantityList.indexOf(value)],
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? selectedValue) {
//                         quantityId = selectedValue!;
//                         productData.setSelectedQuantityId(selectedValue);
//                         productData.fetchRates(
//                             productData.selectedProduct!,
//                             productData.selectedUnit!,
//                             productData.selectedQuantity!);
//                         print(selectedQuantity);
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select an option';
//                         }
//                         return null;
//                       },
//                       icon: const Icon(
//                         Icons.arrow_drop_down_circle,
//                         color: Colors.blue,
//                       ),
//                       dropdownColor: Colors.deepPurple.shade50,
//                       decoration: InputDecoration(
//                         labelText: "Quantity",
//                         prefixIcon: const Icon(
//                           Icons.production_quantity_limits,
//                           color: Colors.blue,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Consumer<ProductListProvider>(
//                   builder: (context, productData, _) {
//                     print('Rate List: ${productData.rateList}');
//
//                     return DropdownButtonFormField<String>(
//                       hint: const Text(
//                         'Rate',
//                         style: TextStyle(fontSize: 15, color: Colors.black),
//                       ),
//                       value: productData.selectedRate,
//                       items: productData.rateList.map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? selectedValue) async {
//                         if (selectedValue != null) {
//                           productData.setSelectedProduct(selectedValue);
//                           productData
//                               .fetchUnitIds(productData.selectedProduct!);
//                           await productData.fetchQuantityIds(
//                             productData.selectedProduct!,
//                             productData.selectedUnit!,
//                           );
//                           await productData.fetchRates(
//                             productData.selectedProduct!,
//                             productData.selectedUnit!,
//                             productData.selectedQuantity!,
//                           );
//                         }
//                       },
//                       // onChanged: (String? selectedValue) {
//                       //   rate = selectedValue!;
//                       //   productData.setSelectedRateId(selectedValue!);
//                       // },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select an option';
//                         }
//                         return null;
//                       },
//                       icon: const Icon(
//                         Icons.arrow_drop_down_circle,
//                         color: Colors.blue,
//                       ),
//                       dropdownColor: Colors.deepPurple.shade50,
//                       decoration: InputDecoration(
//                         labelText: "Rate",
//                         prefixIcon: const Icon(
//                           Icons.monetization_on,
//                           color: Colors.blue,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

///////////////////product scree api code
// Future<void> fetchUnitIds(String productId) async {
//   final List<ProductunitList> unitList = [];
//   try {
//     final res = await http.get(
//       Uri.parse(
//           "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productunit?product_id=$productId"),
//       headers: {
//         "Content-Type": "application/json",
//         "X-API-KEY": "amritmayamilk050512",
//       },
//     );
//     print(
//         "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productunit?product_id=$productId");
//     final response = json.decode(res.body) as Map<String, dynamic>;
//     if (res.statusCode == 200) {
//       // unitIdList.clear();
//       // unitNameList.clear();
//
//       final unitData = response["productunitList"];
//       // unitData.forEach((unit) {
//       for (var unit in unitData) {
//         // final unitId = unit["unit_id"];
//         // final unitName = unit["name"];
//         unitList.add(ProductunitList.fromJson(unit));
//         // unitIdList.add(unitId);
//         // unitNameList.add(unitName);
//         // });
//       }
//       unitListDataMap[productCardId] = unitData;
//       notifyListeners();
//     } else {
//       throw Exception('Failed to fetch unit IDs');
//     }
//   } catch (e) {
//     throw Exception('Failed to fetch unit IDs');
//   }
// }
//
// Future<void> fetchQuantityIds(String productId, String unitId) async {
//   final List<ProductqntList> quantityList = [];
//   try {
//     final res = await http.get(
//       Uri.parse(
//           "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId"),
//       headers: {
//         "Content-Type": "application/json",
//         "X-API-KEY": "amritmayamilk050512",
//       },
//     );
//     print(unitId);
//     print(
//         "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId");
//     final response = json.decode(res.body) as Map<String, dynamic>;
//     print('API Response: $response');
//
//     if (res.statusCode == 200) {
//       // quantityList.clear();
//
//       final quantityData = response["productqntList"];
//       print('Quantity Data: $quantityData');
//       for (var quantity in quantityData) {
//         quantityList.add(ProductqntList.fromJson(quantity));
//       }
//
//       // quantityData.forEach((quantity) {
//       //   final quantityId = quantity["qnt"];
//       //   // quantityList.add(quantityId);
//       // });
//       quantityListDataMap[productCardId] = quantityData;
//       notifyListeners();
//     } else {
//       throw Exception('Failed to fetch quantity IDs');
//     }
//   } catch (e) {
//     print('Error during fetching quantity IDs: $e');
//     throw Exception('Failed to fetch quantity IDs');
//   }
// }
//
// Future<void> fetchRates(
//     String productId, String unitId, String quantityId) async {
//   String rate = '';
//   try {
//     final res = await http.get(
//       Uri.parse(
//         "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId",
//       ),
//       headers: {
//         "Content-Type": "application/json",
//         "X-API-KEY": "amritmayamilk050512",
//       },
//     );
//     print(
//         "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId");
//     final response = json.decode(res.body) as Map<String, dynamic>;
//     print('API Response - Fetch Rates: $response');
//     if (res.statusCode == 200) {
//       // rateList.clear();
//
//       final rateData = response["productrateList"];
//       if (rateData is Map<String, dynamic>) {
//         rate = ProductrateList.fromJson(rateData).rate;
//       }
//       // rateData.forEach((key, value) {
//       //   final rateValue = value;
//       //   // rateList.add(rateValue.toString());
//       // });
//
//       // print('Fetched Rates: $rateList');
//       // setSelectedRateId(rateList.first);
//       rateDataMap[productCardId] = rateData;
//       notifyListeners();
//     } else {
//       throw Exception('Failed to fetch rates');
//     }
//   } catch (e) {
//     print('Error fetching rates: $e');
//     throw Exception('Failed to fetch rates');
//   }
// }
//
// Future<void> submit2(
//     BuildContext context,
//     List selectedProductIdList,
//     List selectedUnitIdList,
//     List selectedQuantityNameList,
//     List selectedRateList,
//     List otherCharge,
//     List otherId,
//     String userId,
//     String customerId) async {
//   setLoading(true);
//   try {
//     Dio dio = Dio();
//     Map<String, dynamic> listParam = {
//       //list parameters add
//       "product_id[]": '',
//       "unit_id[]": '',
//       "qnt[]": '',
//       "rate[]": '',
//       "other_charges[]": '',
//       "other_id[]": '',
//       "customer_id": '',
//     };
//     print("**********************************************************");
//     // if(productNameIdLength==0){} else{
//     //   for(int i=0;i<productNameIdLength!;i++){
//     //     listParam ={
//     //       "product_id[]": productNameIdList![i].toString(),
//     //     };
//     //   }
//     // }
//     if (selectedProductIdList == 0) {
//     } else {
//       for (int i = 0; i < selectedProductIdList.length; i++) {
//         print("Adding product ID: ${productIdList[i]}");
//         listParam = {
//           "product_id[]": productIdList[i].toString(),
//         };
//       }
//     }
//     if (selectedUnitIdList == 0) {
//     } else {
//       for (int i = 0; i < selectedUnitIdList.length; i++) {
//         print("Adding unit ID: ${unitIdList[i]}");
//         listParam = {
//           "unit_id[]": unitIdList[i].toString(),
//         };
//       }
//     }
//     if (selectedQuantityNameList == 0) {
//     } else {
//       for (int i = 0; i < selectedQuantityNameList.length; i++) {
//         print("Adding quantity: ${quantityList[i]}");
//         listParam = {
//           "qnt[]": quantityList[i].toString(),
//         };
//       }
//     }
//     if (selectedRateList == 0) {
//     } else {
//       for (int i = 0; i < selectedRateList.length; i++) {
//         print("Adding rate: ${rateList[i]}");
//         listParam = {
//           "rate[]": rateList[i].toString(),
//         };
//       }
//     }
//     if (otherCharge == 0) {
//     } else {
//       for (int i = 0; i < otherCharge.length; i++) {
//         print("Adding other charges: ${amountList[i]}");
//         listParam = {
//           "other_charges[]": amountList[i].toString(),
//         };
//       }
//     }
//     if (otherId == 0) {
//     } else {
//       for (int i = 0; i < otherId.length; i++) {
//         print("Adding other ID: ${idList[i]}");
//         listParam = {
//           "other_id[]": idList[i].toString(),
//         };
//       }
//     }
//     Map<String, dynamic> remainingParam = {
//       // without list parametr
//       "staff_id": userId,
//     };
//     Map<String, dynamic> allParams = {
//       // all parameter
//       "staff_id": userId,
//       "product_id[]": selectedProductIdList,
//       "unit_id[]": selectedUnitIdList,
//       "qnt[]": selectedQuantityNameList,
//       "rate[]": selectedRateList,
//       "other_charges[]": otherCharge,
//       "other_id[]": otherId,
//       "customer_id": customerId,
//     };
//     allParams.addAll(remainingParam);
//     allParams.addAll(listParam);
//     FormData formData = FormData.fromMap(allParams);
//     print("FormData Values : ${formData.fields}");
//     final response = await dio.post(
//       'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedProduct',
//       data: formData,
//       options: Options(
//         headers: {'X-API-KEY': 'amritmayamilk050512'},
//       ),
//     );
//     Map<String, dynamic> res = json.decode(response.data);
//     print("Response Success: ${res['Success']}");
//     Fluttertoast.showToast(
//         msg: 'Daily Need have been save Successfully',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 2,
//         backgroundColor: Colors.green,
//         textColor: Colors.white);
//   } catch (e) {
//     print('Error during data submission 1: $e');
//     Fluttertoast.showToast(
//         msg: 'Failed to submit data',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 2,
//         backgroundColor: Colors.red,
//         textColor: Colors.white);
//   }
// }
/////////////////////////////////////////////////////////////////////////////////////////////////
