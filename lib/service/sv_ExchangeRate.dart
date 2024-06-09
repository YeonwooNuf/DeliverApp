import 'package:http/http.dart' as http;
import 'dart:convert';


//서버에서 환율 받아오는 코드
class ExchangeRate {
  final int result;
  final String curUnit;
  final String curName;
  final String ttb;
  final String tts;
  final String dealBasisRate;
  final String bookPrice;
  final String yearlyExchangeFeeRate;
  final String tenDayExchangeFeeRate;
  final String kftcDealBasisRate;
  final String kftcBookPrice;

  ExchangeRate({
    required this.result,
    required this.curUnit,
    required this.curName,
    required this.ttb,
    required this.tts,
    required this.dealBasisRate,
    required this.bookPrice,
    required this.yearlyExchangeFeeRate,
    required this.tenDayExchangeFeeRate,
    required this.kftcDealBasisRate,
    required this.kftcBookPrice,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
  return ExchangeRate(
    result: json['result'] ?? 0,
    curUnit: json['cur_unit'] ?? '',
    curName: json['cur_nm'] ?? '',
    ttb: json['ttb'] ?? '',
    tts: json['tts'] ?? '',
    dealBasisRate: json['deal_bas_r'] ?? '',
    bookPrice: json['bkpr'] ?? '',
    yearlyExchangeFeeRate: json['yy_efee_r'] ?? '',
    tenDayExchangeFeeRate: json['ten_dd_efee_r'] ?? '',
    kftcDealBasisRate: json['kftc_deal_bas_r'] ?? '',
    kftcBookPrice: json['kftc_bkpr'] ?? '',
  );
}

}

Future<List<ExchangeRate>> getExchangeRate() async {
  final response = await http.get(Uri.parse('http://localhost:8080/exchange-rate'));

  if (response.statusCode == 200) {
    final List<dynamic> responseData = json.decode(response.body);
    //print('Response data: $responseData'); // 서버로부터 받은 응답 출력
    final List<ExchangeRate> exchangeRates = responseData.map((data) {
      return ExchangeRate.fromJson(data);
    }).toList();
    return exchangeRates;
  } else {
    print('Failed to load exchange rate: ${response.statusCode}');
    throw Exception('Failed to load exchange rate');
  }
}


// void main() async {
//   try {
//     final List<ExchangeRate> exchangeRates = await getExchangeRate();
//     // for (var exchangeRate in exchangeRates) {
//     //   print('Currency: ${exchangeRate.curName}, TTB: ${exchangeRate.ttb}, TTS: ${exchangeRate.tts}');
//     // }
//   } catch (e) {
//     print('Error: $e');
//   }
// }