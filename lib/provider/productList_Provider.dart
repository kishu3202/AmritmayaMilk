import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductListProvider extends ChangeNotifier {
  String? selectedProduct;
  String? selectedUnit;
  String? selectedQuantity;
  String? selectedRate;

  bool? polytheneSmallChecked = false;
  bool? polytheneBigChecked = false;
  bool? deliveryChecked = false;
  bool? maintenanceChecked = false;

  List<String> productIdList = [];
  List<String> productNameList = [];
  List<String> unitIdList = [];
  List<String> unitNameList = [];
  List<String> quantityList = [];
  List<String> rateList = [];

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
      final response = json.decode(res.body) as Map<String, dynamic>;
      print('API Response: $response');
      if (res.statusCode == 200) {
        quantityList.clear();

        final quantityData = response["productqntList"];
        print('Quantity Data: $quantityData');

        quantityData.forEach((quantity) {
          final quantityId = quantity["qnt"];
          if (!quantityList.contains(quantityId)) {
            quantityList.add(quantityId);
          }
        });
        notifyListeners();
      } else {
        throw Exception('Failed to fetch quantity IDs');
      }
    } catch (e) {
      throw Exception('Failed to fetch quantity IDs');
    }
  }

  Future<void> fetchRates(
      String productId, String unitId, String quantityId) async {
    try {
      final res = await http.get(
        Uri.parse(
            "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId"),
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
        notifyListeners();
      } else {
        throw Exception('Failed to fetch rates');
      }
    } catch (e) {
      print('Error fetching rates: $e');
      throw Exception('Failed to fetch rates');
    }
  }

  Future<void> submitDailyNeedProduct() async {
    try {
      final res = await http.post(
        Uri.parse(
            "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedProduct"),
        headers: {
          "Content-Type": "application/json",
          "X-API-KEY": "amritmayamilk050512",
        },
        body: json.encode({
          'productName': selectedProduct,
          'unit': selectedUnit,
          'quantity': selectedQuantity,
          'rate': selectedRate,
          'polytheneSmallChecked': polytheneSmallChecked,
          'polytheneBigChecked': polytheneBigChecked,
          'deliveryChecked': deliveryChecked,
          'maintenanceChecked': maintenanceChecked,
        }),
      );

      if (res.statusCode == 200) {
        print('Data submitted successfully');
      } else {
        print('Failed to submit data');
      }
    } catch (e) {
      print('Error during data submission: $e');
    }
  }

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
