// import 'package:dio/dio.dart';
// import 'package:my_app/src/config/constants/endpoints.dart';
// import 'package:my_app/src/network/data_sources/base_data_source.dart';
// import 'package:my_app/src/network/model/attendance/attendance_information_model.dart';
// import 'package:my_app/src/network/model/attendance/qr_code_model.dart';
// import 'package:my_app/src/network/model/attendance/student_by_course_model.dart';
// import 'package:my_app/src/network/model/common/base_model.dart';
// import 'package:my_app/src/network/model/common/result.dart';
// import 'package:my_app/src/network/repositories/attendance/attendance_repository.dart';
// import 'package:my_app/src/utils/helper/logger.dart';
// import 'package:printer/src/config/constants/endpoints.dart';
// import 'package:printer/src/network/data_sources/base_data_source.dart';

// class AttendanceRepositoryImpl extends AttendanceRepository {
//   @override
//   Future<XResult<BaseModel<QRCodeModel>>> getqrcodeattendance({
//     required String semesterId,
//     required String courseId,
//     required String expiredTime,
//     required String token,
//   }) async {
//     try {
//       final response = await BaseDataSource().get(
//         "${Endpoints.getqrcodeattendance}/${semesterId.toString()}/${courseId.toString()}/${expiredTime.toString()}",
//         options: Options(headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//         }),
//       );
//       final result = BaseModel.fromMap(
//         response.data,
//         (p0) => QRCodeModel.fromMap(p0),
//       );

//       return result.success && result.statusCode == 200
//           ? XResult.success(result)
//           : XResult.error(result.message);
//     } catch (e, a) {
//       LoggerHelper.error('> GET getqrcodeattendance CATCH Error< $e $a');

//       return XResult.exception(e);
//     }
//   }

//   @override
//   Future<XResult<BaseModel<List<StudentByCourseModel>>>> getliststudentbycourse(
//       {required String semesterId,
//       required String courseId,
//       required String token}) async {
//     try {
//       final response = await BaseDataSource().get(
//         "${Endpoints.getliststudentbycourse}/${semesterId.toString()}/${courseId.toString()}",
//         options: Options(headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//         }),
//       );
//       final result = BaseModel.fromMap(response.data, (p0) {
//         final List<StudentByCourseModel> list = [];
//         p0['list'].forEach((v) {
//           list.add(StudentByCourseModel.fromMap(v));
//         });

//         return list;
//       });

//       return result.success && result.statusCode == 200
//           ? XResult.success(result)
//           : XResult.error(result.message);
//     } catch (e) {
//       LoggerHelper.error('> GET getliststudentbycourse CATCH Error< $e');

//       return XResult.exception(e);
//     }
//   }

//   @override
//   Future<XResult<BaseModel<List<AtterndanceInfomationModel>>>>
//       getattendanceinformation({
//     required String semesterId,
//     required String courseId,
//     required String token,
//     required String date,
//     required String status,
//   }) async {
//     try {
//       final response = await BaseDataSource().get(
//         "${Endpoints.getattendanceinformation}?semester_id=$semesterId&course_id=$courseId&status=$status&date=$date",
//         options: Options(headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//         }),
//       );
//       final result = BaseModel.fromMap(response.data, (p0) {
//         final List<AtterndanceInfomationModel> list = [];
//         try {
//           p0['list'].forEach((v) {
//             list.add(AtterndanceInfomationModel.fromMap(v));
//           });
//         } catch (_) {}

//         return list;
//       });

//       return result.success && result.statusCode == 200
//           ? XResult.success(result)
//           : XResult.error(result.message);
//     } catch (e) {
//       LoggerHelper.error('> GET getattendanceinformation CATCH Error< $e');

//       return XResult.exception(e);
//     }
//   }

//   @override
//   Future<XResult<bool>> teachertakeattendance(
//       {required String semesterId,
//       required String courseId,
//       required String token,
//       required String date,
//       required String status,
//       required String studentId}) async {
//     try {
//       final response = await BaseDataSource().post(
//         Endpoints.teachertakeattendance,
//         options: Options(headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//         }),
//         data: {
//           "semester_id": semesterId,
//           "course_id": courseId,
//           "student_id": studentId,
//           "status": status,
//           "date": date,
//         },
//       );
//       final result = BaseModel.fromMap(response.data);

//       return result.success && result.statusCode == 200
//           ? XResult.success(true)
//           : XResult.error(result.message);
//     } catch (e) {
//       LoggerHelper.error('> GET teachertakeattendance CATCH Error< $e');

//       return XResult.exception(e);
//     }
//   }
// }
