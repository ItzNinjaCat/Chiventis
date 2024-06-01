import 'package:flutter/material.dart';

import 'api_service.dart';

class WalletService {
  static Future<int?> getWalletBalance() async {
    try {
      final response = await ApiService.get('/wallet/balance');
      if (response['success'] == false) {
        return null;
      }
      final balance = response['wallet']['amount'] as int;
      return balance;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool?> sendWalletOtp(BuildContext context) async {
    try {
      final response = await ApiService.post(
          context, '/mobile/send-otp', {}, 'Error sending OTP');
      if (response['success'] == false) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>> verifyWalletOtp(
      BuildContext context, String email, String otp) async {
    try {
      final response = await ApiService.post(context, '/verify-otp',
          {'code': otp, 'email': email}, 'Invalid or expired OTP');

      return response;
    } catch (e) {
      print(e);
      return {};
    }
  }

  static Future<Map<String, dynamic>> createEWalletPin(
      BuildContext context, String otp) async {
    try {
      final response = await ApiService.post(
          context,
          '/wallet/create',
          {'pin': otp, 'currency': 'N'},
          'An error has occured while creating your e-Wallet');
      return response;
    } catch (e) {
      print(e);
      return {};
    }
  }

  static Future<Map<String, dynamic>?> topupAirtimeWithWallet(
      BuildContext context,
      String mobileNumber,
      String networkProvider,
      double rechargeAmount,
      String pin) async {
    try {
      final response = await ApiService.post(
          context,
          '/topup/airtime/wallet',
          {
            'mobile_number': mobileNumber,
            'network_provider': networkProvider,
            'recharge_amount': rechargeAmount,
            'pin': pin
          },
          'An error has occured while paying with your e-Wallet');
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> topupDataWithWallet(BuildContext context,
      String mobileNumber, int productId, String pin) async {
    try {
      final response = await ApiService.post(
          context,
          '/topup/data/wallet',
          {'mobile_number': mobileNumber, 'product_id': productId, 'pin': pin},
          'An error has occured while paying with your e-Wallet');
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> topupElectricityWithWallet(
      BuildContext context,
      String meterNumber,
      String disco,
      double amount,
      String meterType,
      String pin) async {
    try {
      final response = await ApiService.post(
          context,
          '/topup/electricity/wallet',
          {
            'meter': meterNumber,
            'disco': disco,
            'amount': amount,
            'pin': pin,
            'meterType': meterType
          },
          'An error has occured while paying with your e-Wallet');
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> topupCableTvWithWallet(
      BuildContext context,
      String smartCardNumber,
      String disco,
      String bouquet,
      double amount,
      String pin) async {
    try {
      final response = await ApiService.post(
          context,
          '/topup/cable-tv/wallet',
          {
            'smart_card_number': smartCardNumber,
            'bouquet': bouquet,
            'disco': disco,
            'amount': amount,
            'pin': pin
          },
          'An error has occured while paying with your e-Wallet');
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> topupSmeDataWithWallet(
      BuildContext context,
      String mobileNumber,
      int productId,
      String pin) async {
    try {
      final response = await ApiService.post(
          context,
          '/topup/sme-data/wallet',
          {'mobile_number': mobileNumber, 'product_id': productId, 'pin': pin},
          'An error has occured while paying with your e-Wallet');
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<String?> topupWallet(
      BuildContext context, double amount) async {
    try {
      final response = await ApiService.post(
          context,
          '/wallet/top-up',
          {'amount': amount},
          'An error has occured while topping up your e-Wallet');
      final url = response['url'] as String;

      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }
}



// Path: lib/services/api_service.dart