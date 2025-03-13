// final dio Dio();
// final response =await dio.get('https://dart.dev');
//Log(response.toString());
// Response response;
//1
// response =await dis.get('/test?id=12&name=dio');
// response await dio.get('/test', queryParameters: (
// 'id': 12,
// });

//2

// response =await dio.post('/test', data: {
// 'id': 12,
// 'name': 'wendu',
// });
//3
// response (await Future.wait([dio.post('/info'), dio.get('/token'111)])) as Response;

//4
// response await dio.download(
// https://pub.dev/,
// (await getTemporaryDirectory()).path 'pub.html',
//);
//5
// final rs avait dio.get(
// https://pub.dev/,
// options: Options(responseType: ResponseType.stream),
// );

//6
// final rs await dio.get<List<int>>(
// https://pub.dev/,
// options: Options(responseType: ResponseType.bytes),
// );

//7
// final formData FormData.froeMap((
// 'name': 'wendu',
// 'data': DateTime.now().to Iso86@15tring(),
// ));
// response await dio.posti/info, data: formData);

//8
// final formData = FormData.fromMap({
//   'name': 'wendu',
//   'date': DateTime.now().toIso8601String(),
// 'file': await MultipartFile.fromFile(
// './text.txt',
// filename: 'upload.txt',
// ),
// 'file': [
//   await MultipartFile.fromFile('./text1.txt', filename: 'upload1.txt'),
//   await MultipartFile.fromFile('./text2.txt', filename: 'upload2.txt'),
// ],
// });
// response await dio.post('/info', data: formData);

//9
// response await dio.post(
//   '/info',
//   data: {
//     'name': 'wendu',
//     'age': 25,
//   },
// onSendProgress: count, total) (int count, int total) {
//   print('$count $total');
// },
// );

//10
// final postData = [0, 1, 2);
// avait dio.post(
//   '/info',
//   data : Stream.fromIterable(postData.map((e) => [e])),
//OPTIONS: Options( headers:
//    {

//Headers.contentLengthHeader: postData.length,
// );







