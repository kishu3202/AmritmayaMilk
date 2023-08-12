import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductListProvider extends ChangeNotifier {
  String? selectedProduct;
  String? selectedUnit;
  String? selectedQuantity;
  String? selectedRate;
  String? userId;
  String? otherId;

  // bool? polytheneSmallChecked = false;
  // bool? polytheneBigChecked = false;
  // bool? deliveryChecked = false;
  // bool? maintenanceChecked = false;

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

          print(otherChargesId);
          print(otherChargesName);

          if (!idList.contains(otherChargesId)) {
            idList.add(otherChargesId);
            amountList.add(otherChargesAmount);
            nameList.add(otherChargesName);
          }

          prefs.setString('otherChargesId', otherChargesId);
          prefs.setString('otherChargesAmount', otherChargesAmount);
          prefs.setString('otherChargesName', otherChargesName);
        });
        notifyListeners();
      } else {
        throw Exception('Failed to fetch other charges');
      }
    } catch (e) {
      throw Exception('Failed to fetch other charges');
    }
  }

  // Future<void> submit() async {
  //   var headers = {
  //     "Content-Type": "application/json",
  //     'X-API-KEY': 'amritmayamilk050512',
  //   };
  //   var uri = Uri.parse(
  //       'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedProduct');
  //
  //   var data = {
  //     'customer_id': 'widget.customerId',
  //     'product_id[]': selectedProduct.toString(),
  //     'qnt[]': selectedQuantity.toString(),
  //     'unit_id[]': selectedUnit.toString(),
  //     'rate[]': selectedRate.toString(),
  //     'staff_id': userId,
  //     'other_charges[]': otherCharge.toString(),
  //     'other_id[]': otherId.toString()
  //   };
  //   for (int i = 0; i < selectedProduct!.length; i++) {
  //     data.addAll({'product_id[$i]': selectedProduct![i]});
  //     data.addAll({'qnt[$i]': selectedQuantity![i]});
  //     data.addAll({'unit_id[$i]': selectedUnit![i]});
  //     data.addAll({'rate[$i]': selectedRate![i]});
  //     data.addAll({"other_charges[$i]": otherCharge[i]});
  //   }
  //   var response = await http.post(uri, headers: headers, body: data);
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     print(jsonData);
  //     print(jsonData["Success"]);
  //   } else {
  //     Fluttertoast.showToast(msg: "Error Occurred", timeInSecForIosWeb: 25);
  //   }
  // }

  void setSelectedProduct(String productId) {
    selectedProduct = productId;
    notifyListeners();
  }

  void setSelectedUnitId(String unitId) {
    selectedUnit = unitId;
    notifyListeners();
  }

  void setSelectedQuantityId(String quantityId) {
    selectedQuantity = quantityId;
    print('Selected Quantity ID: $selectedQuantity');
    fetchRates(
      selectedProduct!,
      selectedUnit!,
      selectedQuantity!,
    );
    notifyListeners();
  }

  void setSelectedRateId(String rate) {
    selectedRate = rate;
    notifyListeners();
  }
}
