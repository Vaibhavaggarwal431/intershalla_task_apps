import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intershalla_task_app/core/getxcontroller/searchcontroller.dart';
import 'package:intershalla_task_app/screens/filterscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController searchquery = TextEditingController();
  Timer? _debounce;
  List<String> appliedFilters = [];
  String? scan;

  _onSearchChanged(String query) {
    final controller = Get.put(GetSearchController());
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      // Trim extra characters from query
      final trimmedQuery = query.trim();
      setState(() {
        scan = trimmedQuery; // Update scan with trimmed query
      });
      controller.searchTenantData(trimmedQuery);
    });
  }

  void _applyFilters(List<String> filters) {
    setState(() {
      appliedFilters = filters;
      print("appliedFilters********${appliedFilters.toString()}");
    });
    // Trigger the search logic with the applied filters

  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetSearchController());
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;


    return Obx(() {
      var internshipEntries = controller.getsearchmodel.value.internshipsMeta?.entries.toList() ?? [];
      var filteredEntries = internshipEntries.where((entry) {
        for (var filter in appliedFilters) {
          // Remove square brackets and trim filter for exact match
          var trimmedFilter = filter.replaceAll(RegExp(r'[\[\]]'), '').trim();
          print("trim value ******8 = ${trimmedFilter}");
          if (entry.toString().trim() != trimmedFilter) {
            return false;
          }
        }
        return true;
      }).toList();

      print("filter entries value ** ${filteredEntries}");



      return Scaffold(
        backgroundColor: const Color(0xffEEEEEE),
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              print("Ldkfjf***${controller.getsearchmodel.value.internshipIds?.length}");
            },
            child: const Text("Searchbar"),
          ),
        ),
        body: Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
              child: Container(
                height: sheight * 0.1,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Filterscreens(onFiltersApplied: _applyFilters,)
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              color: Colors.blue.withOpacity(.2),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.filter_alt_outlined,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Add Filters",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${controller.getsearchmodel.value.internshipsMeta?.length} total internships",
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black87),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
                top: 8,
              ),
              child: Container(
                height: 55,
                width: swidth,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: TextFormField(
                  controller: searchquery,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Filterscreens(
                              onFiltersApplied: (filters) {
                                _applyFilters(filters);
                              },
                            ),
                          ));
                        },
                        child: Icon(Icons.search)),
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      color: Colors.grey,
                    ),
                    hintText: "Search here..",
                    hintStyle: const TextStyle(
                        fontFamily: "Mulish", fontSize: 17),
                  ),
                ),
              ),
            ),
            // Display applied filters
            if (appliedFilters.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Wrap(
                  spacing: 8.0,
                  children: appliedFilters
                      .map((filter) => Chip(
                    label: Text(filter),
                    onDeleted: () {
                      setState(() {
                        appliedFilters.remove(filter);
                        // Trigger the search logic again with updated filters
                        _onSearchChanged(searchquery.text);
                      });
                    },
                  ))
                      .toList(),
                ),
              ),
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Text(
                " Saved Searches",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: "Mulish",
                    fontWeight: FontWeight.w700),
              ),
            ),
           /*filteredEntries.isEmpty*/
      controller.getsearchmodel.value.internshipsMeta?.length == 0
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView.builder(
                itemCount: controller.getsearchmodel.value.internshipsMeta?.length,
                itemBuilder: (BuildContext context, int i) {
                  var internshipKey = internshipEntries[i].key;
                  var internship = internshipEntries[i].value;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          internship.isActive == true
                              ? Padding(
                            padding: const EdgeInsets.only(top: 12, left: 16, bottom: 12),
                            child: Container(
                              width: swidth * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1, color: Colors.green)),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.auto_graph_sharp,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Actively hiring",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          )
                              : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print("8888888888****= ${internship?.title}");
                                      },
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: swidth * 0.5,
                                          maxWidth: swidth * 0.6,
                                        ),
                                        child: Text(
                                          internship?.title ?? 'data',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: swidth * 0.5,
                                        maxWidth: swidth * 0.6,
                                      ),
                                      child: Text(
                                        "${internship?.companyName}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black38),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.flutter_dash,
                                    size: 50,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${internship?.locationNames ?? 'delhi'}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.slow_motion_video,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  internship?.startDate?.name.capitalizeFirst ?? '',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${internship?.stipend?.salary}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.blue.withOpacity(.2)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 3),
                                child: Text(
                                  "Internship ${internship?.ppoLabelValue?.name.capitalizeFirst}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              width: swidth * 0.35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.blue.withOpacity(.1)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4, top: 4),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.watch_later_outlined,
                                      color: Colors.black38,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${internship?.postedByLabel}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}