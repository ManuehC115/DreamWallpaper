import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> fetchWallpapers(String query) async {
  final String apiKey =
      '46579709-aa22b529c342de8e16d6a5b39'; // Reemplaza esto con tu clave
  final String url =
      'https://pixabay.com/api/?key=$apiKey&q=$query&image_type=photo&per_page=10';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<String> imageUrls = [];
    for (var hit in data['hits']) {
      imageUrls.add(hit['webformatURL']); // URL de la imagen
    }
    return imageUrls;
  } else {
    throw Exception('Error al cargar las imágenes');
  }
}
