import 'dart:convert';

import 'package:amritmaya_milk/data/deliverBoy_data_model/productUnit_data_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/deliverBoy_data_model/productList_data_model.dart';
import '../../data/deliverBoy_data_model/productOtherCharges_data_model.dart';
import '../../data/deliverBoy_data_model/productQuantity_data_model.dart';
import '../../data/deliverBoy_data_model/productRate_data_model.dart';

class ProductCard {
  String? productId;
  String? productName;
  String? unitId;
  String? unitName;
  String? quantity;
  String? rate;
  int? id;
  ProductCard(
      {this.productId,
      this.productName,
      this.unitName,
      this.unitId,
      this.rate,
      this.quantity,
      this.id});
  ProductCard copyWith(
      {String? productId,
      String? productName,
      String? unitId,
      String? unitName,
      String? quantity,
      String? rate,
      int? id}) {
    return ProductCard(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unitId: unitId ?? this.unitId,
      unitName: unitName ?? this.unitName,
      quantity: quantity ?? this.quantity,
      rate: rate ?? this.rate,
      id: id ?? this.id,
    );
  }
}

class ProductListProvider extends ChangeNotifier {
  String? selectedProductId;
  String? selectedUnitId;
  String? selectedQuantity;
  String? selectedRate;
  String userId = '';
  String customerId = '';
  //
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
  List<String> otherId = [];

  //id genrator
  int productCardId = 0;
  void nextProductCardId() {
    productCardId = productCardId + 1;
    notifyListeners();
  }

  // this is for product card
  final List<ProductCard> productCards = [];

  //this is for map of cards productIdMap
  final Map<int, String> selectedProductIdMap = <int, String>{};
  //this is for map of cards unitIdMap
  final Map<int, String> selectedUnitIdMap = <int, String>{};
  //this is for map of cards quantityMap
  final Map<int, String> selectedQuantityMap = <int, String>{};
  //this is for map of rateMap
  final Map<int, String> selectedRateMap = <int, String>{};

  //map to store unit list data
  final Map<int, List<ProductunitList>> unitListDataMap =
      <int, List<ProductunitList>>{};
  // map to store quantity list data
  final Map<int, List<ProductqntList>> quantityListDataMap =
      <int, List<ProductqntList>>{};
  // map to store rate list data
  final Map<int, String> rateDataMap = <int, String>{};

  void setSelectedProductId(int productCardId, String productId) {
    selectedProductIdMap[productCardId] = productId;
    notifyListeners();
  }

  void setSelectedUnitId(int productCardId, String unitId) {
    selectedUnitIdMap[productCardId] = unitId;
    notifyListeners();
  }

  void removeSelectedUnitId(int productCardId) {
    selectedUnitIdMap.remove(productCardId);
    notifyListeners();
  }

  void setSelectedQuantity(int productCardId, String quantity) {
    selectedQuantityMap[productCardId] = quantity;
    notifyListeners();
  }

  void removeSelectedQuantity(int productCardId) {
    selectedQuantityMap.remove(productCardId);
    notifyListeners();
  }

  void setSelectedRate(int productCardId, String rate) {
    selectedRateMap[productCardId] = rate;
    notifyListeners();
  }

  void removeSelectedRate(int productCardId) {
    selectedRateMap.remove(productCardId);
    notifyListeners();
  }

  //this is for product data list
  final List<ProductListElement> products = [];

  // for other charges list
  List<Othercharge> otherCharges = [];

  void addCard(ProductCard productCard) {
    productCards.add(productCard);
    notifyListeners();
  }

  void removeCard(int productCardId) {
    final index =
        productCards.indexWhere((element) => element.id == productCardId);
    productCards.removeAt(index);
    notifyListeners();
  }

  void updateCard(int productCardId, ProductCard productCard) {
    final index =
        productCards.indexWhere((element) => element.id == productCardId);
    productCards[index] = productCard;
    notifyListeners();
  }

  void resetState() async {
    productCardId = 0;
    productCards.clear();
    selectedRateMap.clear();
    selectedQuantityMap.clear();
    selectedUnitIdMap.clear();
    selectedProductIdMap.clear();
    otherCharges.clear();
    otherId.clear();
    unitListDataMap.clear();
    quantityListDataMap.clear();
    rateDataMap.clear();
    notifyListeners(); // Notify listeners to update the UI
  }

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
        // productIdList.clear();
        // productNameList.clear();

        final productList = response["productList"];
        for (var product in productList) {
          // productList.forEach((product) {
          // productIdList.add(product["id"]);
          // productNameList.add(product["name"]);
          products.add(ProductListElement.fromJson(product));
        }
        removeSelectedUnitId(productCardId);
        removeSelectedQuantity(productCardId);
        removeSelectedRate(productCardId);
        unitListDataMap.remove(productCardId);
        quantityListDataMap.remove(productCardId);
        rateDataMap.remove(productCardId);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch product names');
      }
    } catch (e) {
      throw Exception('Failed to fetch product names');
    }
  }

  Future<void> fetchUnitIds(int productCardId, String productId) async {
    final List<ProductunitList> unitList = [];
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
        // unitIdList.clear();
        // unitNameList.clear();

        final unitData = response["productunitList"];
        // unitData.forEach((unit) {
        for (var unit in unitData) {
          // final unitId = unit["unit_id"];
          // final unitName = unit["name"];
          unitList.add(ProductunitList.fromJson(unit));
          // unitIdList.add(unitId);
          // unitNameList.add(unitName);
          // });
        }
        unitListDataMap[productCardId] = unitList;
        removeSelectedQuantity(productCardId);
        removeSelectedRate(productCardId);
        quantityListDataMap.remove(productCardId);
        rateDataMap.remove(productCardId);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch unit IDs');
      }
    } catch (e) {
      throw Exception('Failed to fetch unit IDs');
    }
  }

  Future<void> fetchQuantityIds(
      int productCardId, String productId, String unitId) async {
    final List<ProductqntList> quantityList = [];
    try {
      final res = await http.get(
        Uri.parse(
            "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId"),
        headers: {
          "Content-Type": "application/json",
          "X-API-KEY": "amritmayamilk050512",
        },
      );
      print(unitId);
      print(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId");
      final response = json.decode(res.body) as Map<String, dynamic>;
      print('API Response: $response');

      if (res.statusCode == 200) {
        // quantityList.clear();

        final quantityData = response["productqntList"];
        print('Quantity Data: $quantityData');
        for (var quantity in quantityData) {
          quantityList.add(ProductqntList.fromJson(quantity));
        }

        // quantityData.forEach((quantity) {
        //   final quantityId = quantity["qnt"];
        //   // quantityList.add(quantityId);
        // });
        quantityListDataMap[productCardId] = quantityList;
        removeSelectedRate(productCardId);
        rateDataMap.remove(productCardId);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch quantity IDs');
      }
    } catch (e) {
      print('Error during fetching quantity IDs: $e');
      throw Exception('Failed to fetch quantity IDs');
    }
  }

  Future<void> fetchRates(int productCardId, String productId, String unitId,
      String quantityId) async {
    String rate = '';
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
        // rateList.clear();

        final rateData = response["productrateList"];
        if (rateData is Map<String, dynamic>) {
          rate = ProductrateList.fromJson(rateData).rate;
        }
        rateDataMap[productCardId] = rate;
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
        idList.clear();
        amountList.clear();
        nameList.clear();

        final otherChargesData = response["othercharges"];
        print('Other Charges: $otherChargesData');
        otherCharges.clear();
        for (var otherCharge in otherChargesData) {
          otherCharges.add(Othercharge.fromJson(otherCharge));
        }
        // Save lists to SharedPreferences
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setStringList('otherChargesIds', idList);
        pref.setStringList('otherChargesAmounts', amountList);
        pref.setStringList('otherChargesNames', nameList);

        print('Saved Ids: ${pref.getStringList('otherChargesIds')}');
        print('Saved Amounts: ${pref.getStringList('otherChargesAmounts')}');
        print('Saved Names: ${pref.getStringList('otherChargesNames')}');

        notifyListeners();
      } else {
        throw Exception('Failed to fetch other charges');
      }
    } catch (e) {
      throw Exception('Failed to fetch other charges');
    }
  }

  Future<void> submit(String userId, String customerId) async {
    try {
      Dio dio = Dio();
      Map<String, dynamic> remainingParam = {
        // without list parametr
        "staff_id": userId,
      };
      Map<String, dynamic> allParams = {
        // all parameter
        "staff_id": userId,
        "product_id[]": productCards.map((e) => e.productId).toList(),
        "unit_id[]": productCards.map((e) => e.unitId).toList(),
        "qnt[]": productCards.map((e) => e.quantity).toList(),
        "rate[]": productCards.map((e) => e.rate).toList(),
        "other_charges[]": otherCharge,
        "other_id[]": otherId,
        "customer_id": customerId,
      };

      allParams.addAll(remainingParam);
      // allParams.addAll(listParam);
      FormData formData = FormData.fromMap(allParams);
      print("all params: ${allParams}");
      // return;
      print("FormData Values : ${formData.fields}");
      final response = await dio.post(
        'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedProduct',
        data: formData,
        options: Options(
          headers: {'X-API-KEY': 'amritmayamilk050512'},
        ),
      );
      print("hello response");
      print(response);
      Map<String, dynamic> res = (response.data);
      print("Response Success: ${res['Success']}");
      Fluttertoast.showToast(
          msg: 'Daily Need have been save Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    } catch (e) {
      print('Error during data submission 1: $e');
      Fluttertoast.showToast(
          msg: 'Failed to submit data',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  void setSelectedRateId(String rate) {
    selectedRate = rate;
    notifyListeners();
  }
}
