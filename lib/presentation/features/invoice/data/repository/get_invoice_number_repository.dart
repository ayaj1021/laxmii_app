import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_invoice_number_response.dart';

class GetInvoiceNumberRepository {
  GetInvoiceNumberRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetInvoiceNumberResponse>> getInvoiceNumberRepo() async {
    try {
      final res = await _restClient.getInvoiceNumber();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getInvoiceNumberRepositoryProvider = Provider<GetInvoiceNumberRepository>(
  (ref) => GetInvoiceNumberRepository(
    ref.read(restClientProvider),
  ),
);
