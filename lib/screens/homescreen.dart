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
    final controller = Get.put(GetSearchController());
    controller.filterInternships(filters);
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
      var filteredEntries = controller.filteredInternships;

      return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: InkWell(
            onTap: () {
              print("check the value ***${controller.getsearchmodel.value.internshipIds?.length}");
            },
            child: const Text("Internshala",style: TextStyle(color: Colors.white),),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Container(
                height: sheight * 0.1,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  color: Colors.white.withOpacity(.2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Filterscreens(onFiltersApplied: _applyFilters,)
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              color: Colors.white.withOpacity(.2),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.filter_alt_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Add Filters",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
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
                          color: Colors.white),
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
                      color: Colors.white,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: TextFormField(
                  controller: searchquery,
                  cursorColor: Colors.white,
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
                        child: const Icon(Icons.search,color: Colors.white,)),
                    border: InputBorder.none,
                    hintText: " Search here..",
                    hintStyle: const TextStyle(
                      color: Colors.white,
                        fontFamily: "Mulish", fontSize: 17),

                  ),
                  style: const TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),

            if (appliedFilters.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Wrap(
                  spacing: 8.0,
                  children: appliedFilters
                      .map((filter) => Chip(
                    label: Text(filter,style: const TextStyle(color: Colors.black),),
                    onDeleted: () {
                      setState(() {
                        appliedFilters.remove(filter);

                        _onSearchChanged(searchquery.text);
                      });
                    },
                  ))
                      .toList(),
                ),
              ),


            Expanded(
              child: ListView.builder(
                itemCount: filteredEntries.length,
                itemBuilder: (context, index) {
                  if (index >= internshipEntries.length || index >= filteredEntries.length) {
                    return const SizedBox(); // or some other placeholder widget
                  }

                  var internshipKey = internshipEntries[index].key;
                  var internship = filteredEntries[index];
                  return Padding(
                    padding:  const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: Colors.white.withOpacity(.2),),
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
                                  Padding(
                                    padding: EdgeInsets.only(left: 8,bottom: 4,top: 4,),
                                    child: Icon(
                                      Icons.auto_graph_sharp,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Actively hiring",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
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
                                        print("8888888888****= ${internship.title}");
                                      },
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: swidth * 0.5,
                                          maxWidth: swidth * 0.6,
                                        ),
                                        child: Text(
                                          internship.title ?? 'data',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
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
                                        "${internship.companyName}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white38),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.flutter_dash,
                                    color: Colors.white,
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
                                  color: Colors.white,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${internship.locationNames ?? 'delhi'}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
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
                                  color: Colors.white,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  internship.startDate?.name.capitalizeFirst ?? '',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
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
                                  color: Colors.white,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${internship.stipend?.salary}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white.withOpacity(.2)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 3),
                                child: Text(
                                  "Internship ${internship.ppoLabelValue?.name.capitalizeFirst}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
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
                                  color: Colors.white.withOpacity(.1)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 0, bottom: 4, top: 4),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.watch_later_outlined,
                                      color: Colors.white38,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${internship.postedByLabel}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
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
