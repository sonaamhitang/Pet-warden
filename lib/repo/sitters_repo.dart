import 'dart:convert';

import 'package:petwarden/model/sitters_model.dart';
import 'package:petwarden/utils/constants/api.dart';
import 'package:petwarden/utils/helper/log_helper.dart';
import 'package:http/http.dart' as http;
import 'package:petwarden/utils/helper/request_helper.dart';

class SittersRepo {
  static Future<void> getPetSitters({
    required Function(List<Sitters> sitters) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getSitters;
      http.Response response = await PetRequest.get(url);
      dynamic data = json.decode(response.body);
      if (data['status']) {
        var sitters = sittersFromJson(data["data"]);
        onSuccess(sitters);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getSitters, error: e, stackTrace: s);
      onError("Error when fetching sitters");
    }
  }
}
