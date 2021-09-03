import 'package:eztour_traveller/schema/auth/login_request.dart';
import 'package:eztour_traveller/schema/auth/login_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8000/api/")
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/login')
  Future<LoginResponse> login(@Body() LoginRequest request);
}