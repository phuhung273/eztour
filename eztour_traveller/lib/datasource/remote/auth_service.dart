import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/auth/login_request.dart';
import 'package:eztour_traveller/schema/auth/login_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: "$HOST_URL/api/")
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/login')
  Future<LoginResponse> login(@Body() LoginRequest request);
}