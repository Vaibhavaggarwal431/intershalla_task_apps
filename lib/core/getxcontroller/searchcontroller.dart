import 'package:get/get.dart';
import 'package:intershalla_task_app/core/api/repository/searchrepo.dart';
import 'package:intershalla_task_app/core/model/searchmodel.dart';

class GetSearchController extends GetxController {
  var getsearchmodel = SearchModel().obs; // Observable for a single VideoCountModel
  var isLoading = false.obs; // Observable for loading state
  var errorMessage = ''.obs; // Observable for error messages

  @override
  void onInit() {
    super.onInit();
    fetchsearch();
  }

  void fetchsearch() async {
    isLoading.value = true;
    try {
      var response = await Apitimeline.getsearch();
      if (response != null) {
        getsearchmodel.value = response;
      } else {
        errorMessage.value = 'Failed to load data';
      }
    } catch (error) {
      errorMessage.value = 'Error: $error';
    } finally {
      isLoading.value = false;
    }
  }
  void searchTenantData(String query) {
    if (query.isEmpty) {
      // Reset to show all data
      fetchsearch();
    } else {
      // Implement the search logic here to filter the data based on the search query
      var filteredInternships = getsearchmodel.value.internshipsMeta?.entries
          .where((entry) {
        var internship = entry.value;
        return (internship.title?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
            (internship.ppoLabelValue?.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
            (internship.stipend?.salary?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
            (internship.companyName?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
            (internship.startDate.toString()?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
            (internship.postedByLabel.toString()?.toLowerCase().contains(query.toLowerCase()) ?? false) ||// Assuming startDate is a string. Adjust if necessary.
            (internship.locationNames?.any((location) => location.toLowerCase().contains(query.toLowerCase())) ?? false) ||
            false; // Add more properties as needed
      }).toList();

      if (filteredInternships != null) {
        getsearchmodel.update((model) {
          model?.internshipsMeta = Map.fromEntries(filteredInternships);
        });
      }
    }
  }



}
