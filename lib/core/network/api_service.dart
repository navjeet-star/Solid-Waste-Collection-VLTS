import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vlts_swc/models/requestParams/auth_params.dart';
import '../../features/login/models/login_model.dart';
part 'api_service.g.dart';

//flutter pub run build_runner build

@RestApi()
abstract class ApiService {
  factory ApiService({required Dio dio, required String baseUrl}) {
    return _ApiService(dio, baseUrl: baseUrl);
  }

  // DummyJSON POST endpoint for testing (https://dummyjson.com/posts/add)
  @POST("DepartmentUserAuthentication")
  Future<HttpResponse<LoginModel>> isAppActive(
    @Body() AuthParams authParams,
  );



}
