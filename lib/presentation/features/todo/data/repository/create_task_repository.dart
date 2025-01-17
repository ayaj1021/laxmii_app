import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/create_task_response.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/create_tasks_request.dart';

class CreateTaskRepository {
  CreateTaskRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<CreateTaskResponse>> createTasks(
      CreateTaskRequest request) async {
    try {
      final res = await _restClient.createTasks(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final createTasksRepositoryProvider = Provider<CreateTaskRepository>(
  (ref) => CreateTaskRepository(
    ref.read(restClientProvider),
  ),
);
