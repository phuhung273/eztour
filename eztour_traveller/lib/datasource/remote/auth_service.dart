import 'package:dio/dio.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/auth/basic_login_request.dart';
import 'package:eztour_traveller/schema/auth/credential_login_request.dart';
import 'package:eztour_traveller/schema/auth/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: "$HOST_URL/api/login")
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/basic')
  Future<LoginResponse> basicLogin(@Body() BasicLoginRequest request);

  @POST('/credential')
  Future<LoginResponse> credentialLogin(@Body() CredentialLoginRequest request);
}