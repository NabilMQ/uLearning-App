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

  static Future <BaseResponseEntityXendit> coursePay({
    required int courseId,
    required int userId,
    required double amount,
    required userEmail,
    required courseName,
  }) async {
    var response = await HttpUtil().post(
      '/api/checkout/xendit',
      queryParameters: {
        "package_id": courseId,
        "user_id": userId,
        "amount": amount,
        "payer_email": userEmail,
        "description": courseName,
      },
    );

    return BaseResponseEntityXendit.fromJson(response);
  }
}