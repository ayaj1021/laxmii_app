import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_invoice_by_name_request.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_invoice_by_name_response.dart';

class GetInvoiceByNameRepository {
  GetInvoiceByNameRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetInvoiceByNameResponse>> getInvoiceByName(
      GetInvoiceByNameRequest request) async {
    try {
      final res = await _restClient.getInvoiceByName(request);
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getInvoiceByNameRepositoryProvider = Provider<GetInvoiceByNameRepository>(
  (ref) => GetInvoiceByNameRepository(
    ref.read(restClientProvider),
  ),
);
