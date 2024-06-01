import 'package:flutter/material.dart';
import 'api_service.dart';

class FinanceService {
  static Future<String?> airtimePaystack(BuildContext context, String phone,
      String provider, double amount) async {
    try {
      final response = await ApiService.post(
          context,
          '/topup/airtime/paystack',
          {
            'mobile_number': phone,
            'network_provider': provider,
            'recharge_amount': amount
          },
          'Failed to pay with Paystack');
      final url = response['url'] as String;

      return url;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> electricityPaystack(BuildContext context, String meter,
      String disco, double amount, String meterType) async {
    try {
      final response = await ApiService.post(
          context,
          '/topup/electricity/paystack',
          {
            'meter': meter,
            'disco': disco,
            'amount': amount,
            'meterType': meterType
          },
          'Failed to pay with Paystack');
      final url = response['url'] as String;

      return url;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> cablePaystack(BuildContext context, String smartcard,
      String bouquet, String disco, double amount) async {
    try {
      final response = await ApiService.post(
          context,
          '/topup/cable-tv/paystack',
          {
            'smartcard_number': smartcard,
            'bouquet': bouquet,
            'disco': disco,
            'amount': amount
          },
          'Failed to pay with Paystack');
      final url = response['url'] as String;

      return url;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> verifyMeterNumber(
      String meterNumber, String provider, String vertical) async {
    try {
      final response =
          await ApiService.get("/check-meter/$meterNumber/$provider/$vertical");
      if (response['name'] == null) {
        return null;
      }
      final name = response['name'] as String;

      return name;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> dataPaystack(
      BuildContext context, String phone, int productId) async {
    try {
      final response = await ApiService.post(
          context,
          '/topup/data/paystack',
          {
            'mobile_number': phone,
            'product_id': productId,
          },
          'Failed to pay with Paystack');
      final url = response['url'] as String;

      return url;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> smeDataPaystack(
      BuildContext context, String phone, int productId) async {
    try {
      final response = await ApiService.post(
          context,
          '/topup/sme-data/paystack',
          {
            'mobile_number': phone,
            'product_id': productId,
          },
          'Failed to pay with Paystack');
      final url = response['url'] as String;

      return url;
    } catch (e) {
      return null;
    }
  }
}
