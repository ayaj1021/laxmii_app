import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/env/base_env.dart';
import 'package:laxmii_app/core/config/env/prod_env.dart';
import 'package:laxmii_app/core/config/interceptors/header_interceptor.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/logout_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/logout_response.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/model/change_password_request.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/model/change_password_response.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/model/forgot_password_request.dart';
import 'package:laxmii_app/presentation/features/forgot_password/data/model/forgot_password_response.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/add_report_to_favorite_request.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/add_report_to_favorite_response.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/delete_favorite_response.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/delete_report_favorite_request.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_all_favorite_response.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_all_report_response.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_single_report_request.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/get_single_report_response.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/create_inventory_request.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/create_inventory_response.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/delete_inventory_response.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_all_inventory_response.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_single_inventory_response.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/update_inventory_request.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/update_inventory_response.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/create_invoice_request.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/create_invoice_response.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_all_invoice_response.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/update_invoice_request.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/update_invoice_response.dart';
import 'package:laxmii_app/presentation/features/login/data/model/get_access_token_request.dart';
import 'package:laxmii_app/presentation/features/login/data/model/get_access_token_response.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_request.dart';
import 'package:laxmii_app/presentation/features/login/data/model/login_response.dart';
import 'package:laxmii_app/presentation/features/sign_up/data/model/sign_up_request.dart';
import 'package:laxmii_app/presentation/features/sign_up/data/model/sign_up_response.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/create_task_response.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/create_tasks_request.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/delete_task_response.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/get_all_tasks_response.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/update_task_request.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/update_task_response.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_expense_request.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_expense_response.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_sales_request.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/create_sales_response.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/get_all_expenses_response.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/get_all_sales_response.dart';
import 'package:laxmii_app/presentation/features/transactions/data/model/get_all_transactions_response.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/model/resend_otp_request.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/model/resend_otp_response.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/model/verify_email_otp_request.dart';
import 'package:laxmii_app/presentation/features/verify_email/data/model/verify_email_otp_response.dart';

import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/auth/signup/')
  Future<SignUpResponse> signUp(
    @Body() SignUpRequest signUpRequest,
  );

  @POST('/auth/verify-otp/')
  Future<VerifyEmailOtpResponse> verifyEmailOtp(
    @Body() VerifyEmailOtpRequest verifyEmailOtpRequest,
  );

  @POST('/auth/resend-otp/')
  Future<ResendOtpResponse> resendOtp(
    @Body() ResendOtpRequest resendOtpRequest,
  );

  @POST('/auth/forgot-password/')
  Future<ForgotPasswordResponse> forgotPassword(
    @Body() ForgotPasswordRequest forgotPasswordRequest,
  );

  @POST('/auth/reset-password/')
  Future<ChangePasswordResponse> changePassword(
    @Body() ChangePasswordRequest changePasswordRequest,
  );

  @POST('/auth/login/')
  Future<LoginResponse> login(
    @Body() LoginRequest loginRequest,
  );

  @POST('/api/inventory/create')
  Future<CreateInventoryResponse> createInventory(
    @Body() CreateInventoryRequest createInventoryRequest,
  );

  @POST('/api/invoices/create')
  Future<CreateInvoiceResponse> createInvoice(
    @Body() CreateInvoiceRequest createInvoiceRequest,
  );

  @POST('/api/sales/create')
  Future<CreateSalesResponse> createSales(
    @Body() CreateSalesRequest createSalesRequest,
  );

  @POST('/api/expenses/create')
  Future<CreateExpenseResponse> createExpenses(
    @Body() CreateExpenseRequest createExpensesRequest,
  );

  @POST('/api/tasks/create')
  Future<CreateTaskResponse> createTasks(
    @Body() CreateTaskRequest createTasksRequest,
  );

  @POST('/api/favourites/add/')
  Future<AddReportToFavoriteResponse> addReportToFavorite(
    @Body() AddReportToFavoriteRequest addReportToFavoriteRequest,
  );

  @DELETE('/api/favourites/')
  Future<DeleteFavoriteReportResponse> deleteReportFavorite(
    @Body() DeleteReportFavoriteRequest deleteReportFavoriteRequest,
  );

  @POST('/auth/get-access-token')
  Future<GetAccessTokenResponse> getAccessToken(
    @Body() GetAccessTokenRequest getAccessTokenRequest,
  );

  @POST('/auth/logout')
  Future<LogoutResponse> logout(
    @Body() LogoutRequest request,
    // @Queries() Map<String, dynamic> queries,
  );

  @PUT('/api/invoices/{invoiceId}/status')
  Future<UpdateInvoiceResponse> updateInvoice(
    @Body() UpdateInvoiceRequest request, {
    @Path() required String invoiceId,
  });

  @PUT('/api/tasks/update/{taskId}')
  Future<UpdateTaskResponse> updateTask(
    @Body() UpdateTaskRequest request, {
    @Path() required String taskId,
  });

  @PUT('/api/inventory/update/{inventoryId}')
  Future<UpdateInventoryResponse> updateInventory(
    @Body() UpdateInventoryRequest request, {
    @Path() required String inventoryId,
  });

  @DELETE('/api/inventory/delete/{inventoryId}')
  Future<DeleteInventoryResponse> deleteInventory({
    @Path() required String inventoryId,
  });

  @DELETE('/api/tasks/delete/{taskId}')
  Future<DeleteTaskResponse> deleteTask({
    @Path() required String taskId,
  });

  @GET('/api/inventory/{inventoryId}')
  Future<GetSingleInventoryResponse> getSingleInventory({
    @Path() required String inventoryId,
  }
      // @Queries() Map<String, dynamic> queries,
      );

  @GET('/api/inventory')
  Future<GetInventoryResponse> getAllInventory(
      // @Queries() Map<String, dynamic> queries,
      );

  @GET('/api/sales')
  Future<GetAllSalesResponse> getAllSales();

  @GET('/api/reports')
  Future<GetSingleReportResponse> getSingleReport(
    @Body() GetSingleReportRequest request,
  );

  @GET('/api/reports/all')
  Future<GetAllReportsResponse> getAllReports();

  @GET('/api/favourites/')
  Future<GetAllFavoriteResponse> getAllFavoritesReports();

  @GET('/api/tasks')
  Future<GetAllTasksResponse> getAllTasks();

  @GET('/api/transactions')
  Future<GetAllTransactionsResponse> getAllTransactions();

  @GET('/api/expenses')
  Future<GetAllExpensesResponse> getAllExpenses();

  @GET('/api/invoices')
  Future<GetAllInvoiceResponse> getAllInvoices();

  //       @GET('/user')
  // Future<GetAllUserDetailsResponse> getTransaction(
  //     // @Queries() Map<String, dynamic> queries,
  //     );
}

ProviderFamily<Dio, BaseEnv> _dio = Provider.family<Dio, BaseEnv>(
  (ref, env) {
    final dio = Dio();
    // dio.options.baseUrl = 'http://10.0.2.2';
    dio.options.baseUrl = 'http://localhost:3000';
    // dio.options.baseUrl = 'https://abakon.onrender.com/api/users';

    dio.options.headers = {
      'Content-Type': 'application/json',

      // 'Authorization': 'Bearer ${ref.read(tokenProvider)}',
      // 'accept': 'application/json',
    };

    dio.interceptors.add(
      HeaderInterCeptor(
        dio: dio,
        secureStorage: ref.read(localStorageProvider),
        onTokenExpired: () async {
          // await ref.read(localStorageProvider).logout(partialLogout: true);
          //  await ref.read(logOutNotifer.notifier).expireLogOut();
          // ref.read(logOutNotifer.notifier).state = ActivityStatus.loggedOut;
        },
      ),
    );
    return dio;
  },
);

final restClientProvider = Provider((_) {
  final env = switch (F.appFlavor) {
    Flavor.prod => ProdEnv(),
    // Flavor.staging => StagingEnv(),
    //Flavor.dev => DevEnv(),
  };
  // ignore: no_wildcard_variable_uses
  return RestClient(_.read(_dio.call(env)));
});
