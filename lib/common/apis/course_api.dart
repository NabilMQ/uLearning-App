import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/utils/http_util.dart';

class CourseAPI {  
  static Future <CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().get(
      '/api/courseList',
    ); 
    return CourseListResponseEntity.fromJson(response);
  }

  static Future <CourseDetailResponseEntity> courseDetail(int id) async {
    var response = await HttpUtil().get(
      '/api/courseDetail',
      queryParameters: {
        'id': id,
      }
    );
    
    return CourseDetailResponseEntity.fromJson(response);
  }

  static Future <BaseResponseEntity> coursePay({CourseRequestEntity? params}) async {
    var response = await HttpUtil().post(
      '/api/checkout',
      queryParameters: params?.toJson(),
    );

    return BaseResponseEntity.fromJson(response);
  }
}