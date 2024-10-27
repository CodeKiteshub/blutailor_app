import 'package:bluetailor_app/common/entities/date_entity.dart';
import 'package:bluetailor_app/core/api/api_client.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AppointmentDataSource {
  Future<QueryResult> saveAppointment(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String countryCode,
      required String appointmentType,
      required DateEntity appointmentDate,
      required String appointmentSelectedTime,
      required String lookingFor});
  Future<QueryResult> fetchAppointments();
}

class AppointmentDataSourceImpl implements AppointmentDataSource {
  final ApiClient apiClient;

  AppointmentDataSourceImpl({required this.apiClient});

  @override
  Future<QueryResult<Object?>> saveAppointment(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String countryCode,
      required String appointmentSelectedTime,
      required String appointmentType,
      required DateEntity appointmentDate,
      required String lookingFor}) async {
    String saveAppointmentSchema = r"""
mutation SaveAppointment($body: AppointmentInput!) {
  saveAppointment(body: $body) {
    _id
  }
}
""";

    final variables = {
      "body": {
        "userId": sl<SharedPreferences>().getString("userId"),
        "phone": phone,
        "lastName": lastName,
        "firstName": firstName,
        "email": email,
        "countryCode": countryCode,
        "cityName": null,
        "appointmentType": appointmentType,
        "appointmentDate": appointmentDate.toJson(),
        "appointmentSelectedTimestamp": appointmentSelectedTime,
        "lookingFor": lookingFor
      }
    };

    return await apiClient.mutateData(
        query: saveAppointmentSchema, variable: variables);
  }

  @override
  Future<QueryResult<Object?>> fetchAppointments() async {
    String appointmentSchema = r"""
query GetAllAppointments($params: AppointmentFilterInput!) {
  getAllAppointments(params: $params) {
    appointments {
      appointmentDate {
        day
        month
        year
        hour
        minute
        datestamp
        timestamp
      }
      appointmentId
      _id
      appointmentSelectedTimestamp
      appointmentType
      lookingFor
      dateRecorded {
        day
        month
        year
        hour
        minute
        datestamp
        timestamp
      }
      stylist {
        name
        _id
      }
    }
  }
}
""";

    final variable = {
      "params": {
        "userId": sl<SharedPreferences>().getString("userId"),
      }
    };

    return await apiClient.queryData(
        query: appointmentSchema, variable: variable);
  }
}
