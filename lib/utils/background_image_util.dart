import 'package:dio/dio.dart';

// Future<void> fetchBackgroundImage() async {
//   try {
//     Dio dio = new Dio();
//     // 请求图片地址
//     final response = await dio.get("https://www.dmoe.cc/random.php?return=json");
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         backgroundUrl = data['imgurl'];
//       });
//     } else {
//       debugPrint('Failed to fetch image: ${response.statusCode}');
//     }
//   } catch (e) {
//     debugPrint('Error fetching image: $e');
//   }
// }