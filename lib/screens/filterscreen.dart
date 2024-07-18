import 'package:flutter/material.dart';
import 'package:intershalla_task_app/widgets/custombottomsheet.dart';

class Filterscreens extends StatefulWidget {
  final Function(List<String>) onFiltersApplied;

  const Filterscreens({super.key, required this.onFiltersApplied});

  @override
  State<Filterscreens> createState() => _FilterscreensState();
}

class _FilterscreensState extends State<Filterscreens> {
  List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset("assets/images/back.png"),
        ),
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filters",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Mulish",
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 20,
              bottom: 8,
            ),
            child: Text(
              "PROFILE",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: "Mulish",
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 8,
              bottom: 8,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BottomSheetScreen(
                        name: "profile",
                        onFilterAdded: (value) {
                          setState(() {
                            selectedFilters.add(value);
                          });
                        },
                      ),
                    ));
                  },
                  child: const Text(
                    "Add Profile",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 17,
                        fontFamily: "Mulish",
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 20,
              bottom: 8,
            ),
            child: Text(
              "CITY",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: "Mulish",
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 8,
              bottom: 8,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BottomSheetScreen(
                        name: "city",
                        onFilterAdded: (value) {
                          setState(() {
                            selectedFilters.add(value);
                          });
                        },
                      ),
                    ));
                  },
                  child: const Text(
                    "Add City",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 17,
                        fontFamily: "Mulish",
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 20,
              bottom: 8,
            ),
            child: Text(
              "COMPANY",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: "Mulish",
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 8,
              bottom: 8,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BottomSheetScreen(
                        name: "company",
                        onFilterAdded: (value) {
                          setState(() {
                            selectedFilters.add(value);
                          });
                        },
                      ),
                    ));
                  },
                  child: const Text(
                    "Add Company",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 17,
                        fontFamily: "Mulish",
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          // Display selected filters
          const Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 20,
              bottom: 8,
            ),
            child: Text(
              "SELECTED FILTERS",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: "Mulish",
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8.0,
              children: selectedFilters
                  .map((filter) => Chip(
                label: Text(filter),
                onDeleted: () {
                  setState(() {
                    selectedFilters.remove(filter);
                  });
                },
              ))
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 8,
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedFilters.clear();
                      Navigator.pop(context);
                      setState(() {
                        widget.onFiltersApplied([]);

                      });
                    });
                  },
                  child: const Text(
                    "Clear All",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 17,
                        fontFamily: "Mulish",
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onFiltersApplied(selectedFilters);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Add Filter",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 17,
                        fontFamily: "Mulish",
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
