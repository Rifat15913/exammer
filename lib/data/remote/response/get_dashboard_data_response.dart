import 'package:exammer/data/remote/model/dashboard/dashboard_data.dart';
import 'package:exammer/data/remote/response/base_response.dart';

class GetDashboardDataResponse extends BaseResponse {
  late DashboardData dashboardData;

  GetDashboardDataResponse.fromJson(Map<String, dynamic> json) : super(json) {
    dashboardData = DashboardData.fromJson(
      data as Map<String, dynamic>,
    );
  }
}
