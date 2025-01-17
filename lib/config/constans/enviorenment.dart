

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviorenment {
  static initEnviroment() async {
    await dotenv.load(fileName: ".env");
  }
  static String apiUrl = dotenv.env['API_URL'] ?? 'NO ESTA CONFIGURADO LA URL';
}