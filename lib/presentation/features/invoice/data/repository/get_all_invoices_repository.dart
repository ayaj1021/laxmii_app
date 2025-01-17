import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_all_invoice_response.dart';

class GetAllInvoicesRepository {
  GetAllInvoicesRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetAllInvoiceResponse>> getAllInvoices() async {
    try {
      final res = await _restClient.getAllInvoices();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getAllInvoicesRepositoryProvider = Provider<GetAllInvoicesRepository>(
  (ref) => GetAllInvoicesRepository(
    ref.read(restClientProvider),
  ),
);
