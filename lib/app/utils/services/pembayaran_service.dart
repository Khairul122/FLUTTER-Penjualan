import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/model/products.dart';

class PembayaranService {
  static const String url = 'http://10.0.2.2/backend-penjualan/GetOrderAPI.php';

  Future<List<Pembayaran>> fetchPembayaran(int idPengguna) async {
    final response = await http.get(Uri.parse('$url?id_pengguna=$idPengguna'));

    if (response.statusCode == 200) {
      try {
        List jsonResponse = json.decode(response.body);
        print('Response from API: $jsonResponse'); // Logging response
        return jsonResponse.map((data) => Pembayaran.fromJson(data)).toList();
      } catch (e) {
        print('Error parsing JSON: $e'); // Logging parsing error
        print('Raw response: ${response.body}'); // Logging raw response
        throw Exception('Failed to parse JSON');
      }
    } else {
      print('Error: ${response.statusCode} - ${response.body}'); // Logging error
      throw Exception('Failed to load pembayaran');
    }
  }
}
