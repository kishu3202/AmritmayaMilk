import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductListProvider extends ChangeNotifier {
  String? selectedProductId;
  String? selectedUnitId;
  String? selectedQuantity;
  String? selectedRate;
  String? userId;
  String? otherId;
  String? customerId;

  List<String> productIdList = [];
  List<String> productNameList = [];
  List<String> unitIdList = [];
  List<String> unitNameList = [];
  List<String> quantityList = [];
  List<String> rateList = [];
  List<String> idList = [];
  List<String> nameList = [];
  List<String> amountList = [];
  List<String> otherCharge = [];

  int? productIdLength;
  int? unitIdLength;
  int? quantityLength;
  int? rateLength;
  int? otherChargesLength;
  int? otherIdLength;

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchProductNames() async {
    try {
      final res = await http.get(
        Uri.parse(
            "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productlist"),
        headers: {
          "Content-Type": "application/json",
          "X-API-KEY": "amritmayamilk050512",
        },
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        productIdList.clear();
        productNameList.clear();

        final productList = response["productList"];
        productList.forEach((product) {
          productIdList.add(product["id"]);
          productNameList.add(product["name"]);
        });

        notifyListeners();
      } else {
        throw Exception('Failed to fetch product names');
      }
    } catch (e) {
      throw Exception('Failed to fetch product names');
    }
  }

  Future<void> fetchUnitIds(String productId) async {
    try {
      final res = await http.get(
        Uri.parse(
            "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productunit?product_id=$productId"),
        headers: {
          "Content-Type": "application/json",
          "X-API-KEY": "amritmayamilk050512",
        },
      );
      print(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productunit?product_id=$productId");
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        unitIdList.clear();
        unitNameList.clear();

        final unitData = response["productunitList"];
        unitData.forEach((unit) {
          final unitId = unit["unit_id"];
          final unitName = unit["name"];

          if (!unitIdList.contains(unitId)) {
            unitIdList.add(unitId);
            unitNameList.add(unitName);
          }
        });
        notifyListeners();
      } else {
        throw Exception('Failed to fetch unit IDs');
      }
    } catch (e) {
      throw Exception('Failed to fetch unit IDs');
    }
  }

  Future<void> fetchQuantityIds(String productId, String unitId) async {
    try {
      final res = await http.get(
        Uri.parse(
            "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId"),
        headers: {
          "Content-Type": "application/json",
          "X-API-KEY": "amritmayamilk050512",
        },
      );
      print("productId: ${productId}");
      print(unitId);
      print(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId");
      final response = json.decode(res.body) as Map<String, dynamic>;
      print('API Response: $response');

      if (res.statusCode == 200) {
        quantityList.clear();

        final quantityData = response["productqntList"];
        print('Quantity Data: $quantityData');
        quantityData.forEach((quantity) {
          final quantityId = quantity["qnt"];
          quantityList.add(quantityId);
          // if (!quantityList.contains(quantityId)) {
          //   quantityList.add(quantityId);
          // }
        });

        notifyListeners();
      } else {
        throw Exception('Failed to fetch quantity IDs');
      }
    } catch (e) {
      print('Error during fetching quantity IDs: $e');
      throw Exception('Failed to fetch quantity IDs');
    }
  }

  Future<void> fetchRates(
      String productId, String unitId, String quantityId) async {
    try {
      final res = await http.get(
        Uri.parse(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId",
        ),
        headers: {
          "Content-Type": "application/json",
          "X-API-KEY": "amritmayamilk050512",
        },
      );
      print(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId");
      final response = json.decode(res.body) as Map<String, dynamic>;
      print('API Response - Fetch Rates: $response');
      if (res.statusCode == 200) {
        rateList.clear();

        final rateData = response["productrateList"];
        if (rateData is Map<String, dynamic>) {
          rateData.forEach((key, value) {
            final rateValue = value;
            rateList.add(rateValue.toString());
          });
        }
        print('Fetched Rates: $rateList');
        setSelectedRateId(rateList.first);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch rates');
      }
    } catch (e) {
      print('Error fetching rates: $e');
      throw Exception('Failed to fetch rates');
    }
  }

  Future<void> fetchOtherCharges() async {
    try {
      final res = await http.get(
        Uri.parse(
            "http://webiipl.in/amritmayamilk/api/UserApiController/othercharges"),
        headers: {
          "Content-Type": "application/json",
          "X-API-KEY": "amritmayamilk050512",
        },
      );

      final response = json.decode(res.body) as Map<String, dynamic>;
      print('API Response - Fetch Other Charges: $response');
      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        idList.clear();
        amountList.clear();
        nameList.clear();

        final otherCharges = response["othercharges"];
        print('Other Charges: $otherCharges');
        otherCharges.forEach((other) {
          final otherChargesId = other['id'];
          final otherChargesName = other['name'];
          final otherChargesAmount = other['amount'];

          if (!idList.contains(otherChargesId)) {
            idList.add(otherChargesId);
            amountList.add(otherChargesAmount);
            nameList.add(otherChargesName);
          }
        });
        // Save lists to SharedPreferences
        prefs.setStringList('otherChargesIds', idList);
        prefs.setStringList('otherChargesAmounts', amountList);
        prefs.setStringList('otherChargesNames', nameList);

        print('Saved Ids: ${prefs.getStringList('otherChargesIds')}');
        print('Saved Amounts: ${prefs.getStringList('otherChargesAmounts')}');
        print('Saved Names: ${prefs.getStringList('otherChargesNames')}');

        notifyListeners();
      } else {
        throw Exception('Failed to fetch other charges');
      }
    } catch (e) {
      throw Exception('Failed to fetch other charges');
    }
  }

  Future<void> submit(
      BuildContext context,
      String selectedProductId,
      String selectedUnitId,
      String selectedQuantity,
      String selectedRate,
      String otherCharge,
      String otherId,
      String userId,
      String customerId) async {
    setLoading(true);
    try {
      var map = new Map<String, dynamic>();
      map['product_id[]'] = selectedProductId;
      map['unit_id[]'] = selectedUnitId;
      map['qnt[]'] = selectedQuantity;
      map['rate[]'] = selectedRate;
      map['other_charges[]'] = otherCharge;
      map['other_id[]'] = otherId;
      map['staff_id'] = userId;
      map['customer_id'] = customerId;
      Response response = await post(
          Uri.parse(
              "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedProduct"),
          headers: {'X-API-KEY': 'amritmayamilk050512'},
          body: map);
      Map<String, dynamic> res = json.decode(response.body);
      print(res['Success']);
      if (res['Success'] == true) {
        print("Succssful submitted");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> submit(BuildContext context, selectedProductId, selectedUnitId,
  //     selectedQuantity, selectedRate, otherCharge, otherId) async {
  //   setLoading(true);
  //   try {
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
  //     if (selectedProductId == 0) {
  //     } else {
  //       for (int i = 0; i < selectedProductId!.length; i++) {
  //         print("Adding product ID: ${productIdList[i]}");
  //         listParam = {
  //           "product_id[]": productIdList[i].toString(),
  //         };
  //       }
  //     }
  //     if (selectedUnitId == 0) {
  //     } else {
  //       for (int i = 0; i < selectedUnitId!.length; i++) {
  //         print("Adding unit ID: ${unitIdList[i]}");
  //         listParam = {
  //           "unit_id[]": unitIdList[i].toString(),
  //         };
  //       }
  //     }
  //     if (selectedQuantity == 0) {
  //     } else {
  //       for (int i = 0; i < selectedQuantity!.length; i++) {
  //         print("Adding quantity: ${quantityList[i]}");
  //         listParam = {
  //           "qnt[]": quantityList[i].toString(),
  //         };
  //       }
  //     }
  //     if (selectedRate == 0) {
  //     } else {
  //       for (int i = 0; i < selectedRate!.length; i++) {
  //         print("Adding rate: ${rateList[i]}");
  //         listParam = {
  //           "rate[]": rateList[i].toString(),
  //         };
  //       }
  //     }
  //     if (otherCharge == 0) {
  //     } else {
  //       for (int i = 0; i < otherCharge.length; i++) {
  //         print("Adding other charges: ${idList[i]}");
  //         listParam = {
  //           "other_charges[]": idList[i].toString(),
  //         };
  //       }
  //     }
  //     if (otherId == 0) {
  //     } else {
  //       for (int i = 0; i < otherId.length; i++) {
  //         print("Adding other ID: ${otherId[i]}");
  //         listParam = {
  //           "other_id[]": otherId[i].toString(),
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
  //       "product_id[]": selectedProductId,
  //       "unit_id[]": selectedUnitId,
  //       "qnt[]": selectedQuantity,
  //       "rate[]": selectedRate,
  //       "other_charges[]": otherCharge,
  //       "other_id[]": otherId,
  //       "customer_id": customerId,
  //     };
  //     allParams.addAll(remainingParam);
  //     allParams.addAll(listParam);
  //     FormData formData = FormData.fromMap(allParams);
  //     print("FormData Values : ${formData.fields}");
  //     final response = await post(
  //         Uri.parse(
  //             'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedProduct'),
  //         headers: {'X-API-KEY': 'amritmayamilk050512'},
  //         body: formData);
  //     Map<String, dynamic> res = json.decode(response.body);
  //     print("Response Success: ${res['Success']}");
  //   } catch (e) {
  //     print('Error during data submission 1: $e');
  //   }
  // }

  void setSelectedRateId(String rate) {
    selectedRate = rate;
    notifyListeners();
  }
}
