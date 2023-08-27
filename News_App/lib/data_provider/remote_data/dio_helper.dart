
    import 'package:dio/dio.dart';

    class DioHelper {
      final Dio dio = Dio();

      Future<List> getNews(
          {required String path,
          required Map<String, dynamic> queryParameters}) async {

        Response response = await dio.get(path, queryParameters: queryParameters);
        return response.data["articles"];
      }
    }
