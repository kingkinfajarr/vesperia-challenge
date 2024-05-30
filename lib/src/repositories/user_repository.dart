import 'package:dio/dio.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/endpoint.dart';
import '../models/response/user_response_model.dart';
import '../utils/networking_util.dart';

class UserRepository {
  final Dio _client;
  final GetStorage _local;

  UserRepository({required Dio client, required GetStorage local})
      : _client = client,
        _local = local;

  Future<void> login() async {
    //Artificial delay to simulate logging in process
    await Future.delayed(const Duration(seconds: 2));
    //Placeholder token. DO NOT call real logout API using this token
    _local.write(
        LocalDataKey.token, "621|DBiUBMfsEtX01tbdu4duNRCNMTt7PV5blr6zxTvq");
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
}
