import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/update_task_request.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/update_task_response.dart';

class UpdateTaskRepository {
  UpdateTaskRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<UpdateTaskResponse>> updateTask(UpdateTaskRequest request,
      {required String taskId}) async {
    try {
      final res = await _restClient.updateTask(request, taskId: taskId);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final updateTaskRepositoryProvider = Provider<UpdateTaskRepository>(
  (ref) => UpdateTaskRepository(
    ref.read(restClientProvider),
  ),
);
