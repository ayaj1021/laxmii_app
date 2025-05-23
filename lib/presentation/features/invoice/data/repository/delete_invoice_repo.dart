import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/delete_invoice_response.dart';

class DeleteInvoiceRepository {
  DeleteInvoiceRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<DeleteInvoiceResponse>> deleteInvoice(
      String invoiceId) async {
    try {
      final res = await _restClient.deleteInvoice(invoiceId: invoiceId);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final deleteInvoiceRepositoryProvider = Provider<DeleteInvoiceRepository>(
  (ref) => DeleteInvoiceRepository(
    ref.read(restClientProvider),
  ),
);
