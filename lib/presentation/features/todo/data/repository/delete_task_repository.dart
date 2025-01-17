import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/delete_task_response.dart';

class DeleteTaskRepository {
  DeleteTaskRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<DeleteTaskResponse>> deleteTask(
      {required String taskId}) async {
    try {
      final res = await _restClient.deleteTask(taskId: taskId);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final deleteTaskRepositoryProvider = Provider<DeleteTaskRepository>(
  (ref) => DeleteTaskRepository(
    ref.read(restClientProvider),
  ),
);
