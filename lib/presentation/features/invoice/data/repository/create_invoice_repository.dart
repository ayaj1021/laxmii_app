import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/create_invoice_request.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/create_invoice_response.dart';

class CreateInvoiceRepository {
  CreateInvoiceRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<CreateInvoiceResponse>> createInvoice(
      CreateInvoiceRequest request) async {
    try {
      final res = await _restClient.createInvoice(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final createInvoiceRepositoryProvider = Provider<CreateInvoiceRepository>(
  (ref) => CreateInvoiceRepository(
    ref.read(restClientProvider),
  ),
);
