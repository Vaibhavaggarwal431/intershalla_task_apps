import 'package:intershalla_task_app/core/api/api_interface.dart';
import 'package:intershalla_task_app/core/model/searchmodel.dart';

class Apitimeline
{

static final ApiInterface apiInterface = ApiInterface();
static Future<SearchModel?> getsearch() async {
  try {
    var response = await apiInterface.search();

    if (response.internshipsMeta != null) {
      print('data******: ${response.toJson().toString()}');
      // Return the CountGoModel object
      return response;
    } else {
      print('status****: "inside else block"');
      // Handle error scenario and return null
      return null;
    }
  } catch (error) {
    // Handle exceptions and return null
    print('Error: $error');
    return null;
  }

}

}