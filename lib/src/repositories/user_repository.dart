import 'dart:io';

import 'package:dio/dio.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/models/request/login_request_model.dart';
import 'package:entrance_test/src/models/request/update_profile_request_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/routes/route_name.dart';
import '../constants/endpoint.dart';
import '../models/response/user_response_model.dart';
import '../utils/networking_util.dart';

class UserRepository {
  final Dio _client;
  final GetStorage _local;

  UserRepository({required Dio client, required GetStorage local})
      : _client = client,
        _local = local;

  Future<void> login(LoginRequestModel request) async {
    try {
      final responseJson = await _client.post(
        Endpoint.login,
        data: request,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      final token = responseJson.data['data']['token'];
      _local.write(LocalDataKey.token, token);

      Get.offAllNamed(RouteName.dashboard);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    //Artificial delay to simulate logging out process
    await Future.delayed(const Duration(seconds: 2));
    await _local.remove(LocalDataKey.token);
  }

  Future<UserResponseModel> getUser() async {
    try {
      final responseJson = await _client.get(
        Endpoint.getUser,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      final model = UserResponseModel.fromJson(responseJson.data);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  Future<void> testUnauthenticated() async {
    try {
      final realToken = _local.read<String?>(LocalDataKey.token);
      await _local.write(
          LocalDataKey.token, '619|kM5YBY5yM15KEuSmSMaEzlfv0lWs83r4cp4oty2T');
      getUser();
      //401 not caught as exception
      await _local.write(LocalDataKey.token, realToken);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<void> downloadFile(String url, String name) async {
    await Permission.storage.request();

    const String downloadsDir = '/storage/emulated/0/Download';

    final String filePath = '$downloadsDir/$name';

    try {
      await _client.download(
        url,
        filePath,
        options: Options(
          headers: {HttpHeaders.acceptEncodingHeader: '*'},
        ),
        onReceiveProgress: (received, total) {
          if (total <= 0) return;
          print('percentage: ${(received / total * 100).toStringAsFixed(0)}%');
        },
      );
      print('File downloaded to: $filePath');
    } on DioError catch (e) {
      print('Error downloading file: $e');
      throw Exception('Error downloading file: $e');
    }
  }

  Future<void> updateProfile(UpdateProfileRequestModel request) async {
    try {
      await _client.put(
        Endpoint.updateUser,
        data: request,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
    } on DioException catch (_) {
      rethrow;
    }
  }
}
