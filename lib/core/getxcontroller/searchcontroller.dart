import 'package:get/get.dart';
import 'package:intershalla_task_app/core/api/repository/searchrepo.dart';
import 'package:intershalla_task_app/core/model/intershipmodel.dart';
import 'package:intershalla_task_app/core/model/searchmodel.dart';

class GetSearchController extends GetxController {
  var getsearchmodel = SearchModel().obs; // Observable for the search model
  var isLoading = false.obs; // Observable for loading state
  var errorMessage = ''.obs; // Observable for error messages
  var filteredInternships = <InternshipsMeta>[].obs; // Observable for filtered internships

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
        filteredInternships.value = response.internshipsMeta?.values.toList() ?? [];
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
      fetchsearch(); // Reset to show all data
    } else {
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

  void filterInternships(List<String> filters) {
    if (filters.isEmpty) {
      filteredInternships.value = getsearchmodel.value.internshipsMeta?.values.toList() ?? [];
    } else {
      var filtered = getsearchmodel.value.internshipsMeta?.values.where((internship) {
        return filters.any((filter) {
          var trimmedFilter = filter.replaceAll(RegExp(r'[\[\]]'), '').trim().toLowerCase();
          return internship.title?.toLowerCase().contains(trimmedFilter) == true ||
              internship.ppoLabelValue?.name?.toLowerCase().contains(trimmedFilter) == true ||
              internship.stipend?.salary?.toLowerCase().contains(trimmedFilter) == true ||
              internship.companyName?.toLowerCase().contains(trimmedFilter) == true ||
              internship.startDate.toString()?.toLowerCase().contains(trimmedFilter) == true ||
              internship.postedByLabel.toString()?.toLowerCase().contains(trimmedFilter) == true ||// Assuming startDate is a string. Adjust if necessary.
              internship.locationNames?.any((location) => location.toLowerCase().contains(trimmedFilter)) == true;
        });
      }).toList();
      filteredInternships.value = filtered ?? [];
    }
  }
}
