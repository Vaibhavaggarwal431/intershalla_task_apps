import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intershalla_task_app/core/getxcontroller/searchcontroller.dart';

class BottomSheetScreen extends StatefulWidget {
  final String? name;
  final Function(String) onFilterAdded;

  const BottomSheetScreen({super.key, this.name, required this.onFilterAdded});

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  int? selectedIndex1;
  int? selectedIndex2;
  int? selectedIndex3;
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetSearchController());
    var internshipEntries = controller.getsearchmodel.value.internshipsMeta?.entries.toList() ?? [];
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset("assets/images/back.png",color: Colors.white,),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Intershala ",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Mulish",
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: swidth * 0.15,),
                ElevatedButton(onPressed: () {
                  String selectedValue = '';
                  if (widget.name == "profile" && selectedIndex1 != null) {
                    selectedValue = internshipEntries[selectedIndex1!].value.title ?? '';
                    print("title value ****${selectedValue}");
                  } else if (widget.name == "city" && selectedIndex2 != null) {
                    selectedValue = internshipEntries[selectedIndex2!].value.locationNames?.join(', ') ?? '';
                  } else if (widget.name == "company" && selectedIndex3 != null) {
                    selectedValue = internshipEntries[selectedIndex3!].value.companyName ?? '';
                  }

                  widget.onFilterAdded(selectedValue);
                  print("in sheet screen*******8= ${selectedValue}");
                  Navigator.pop(context);
                }, child: const Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 14,
                      fontFamily: "Mulish",
                      fontWeight: FontWeight.w600),
                ))
              ],
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
      body: widget.name == "profile" ?
      ListView.builder(
          itemCount: controller.getsearchmodel.value.internshipsMeta?.length,
          itemBuilder: (BuildContext context, int i) {
            var internship = internshipEntries[i].value;
            return Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 8,
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: selectedIndex1 == i,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedIndex1 = i;
                        } else {
                          selectedIndex1 = null;
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: swidth * 0.5,
                      maxWidth: swidth * 0.6,
                    ),
                    child: Text(
                      "${internship?.title}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: "Mulish",
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            );
          }) :
      widget.name == "city" ?
      ListView.builder(
          itemCount: controller.getsearchmodel.value.internshipsMeta?.length,
          itemBuilder: (BuildContext context, int i) {
            var internship = internshipEntries[i].value;
            return Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 8,
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: selectedIndex2 == i,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedIndex2 = i;
                        } else {
                          selectedIndex2 = null;
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: swidth * 0.5,
                      maxWidth: swidth * 0.6,
                    ),
                    child: Text(
                      "${internship?.locationNames}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: "Mulish",
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            );
          }) :
      widget.name == "company" ?
      ListView.builder(
          itemCount: controller.getsearchmodel.value.internshipsMeta?.length,
          itemBuilder: (BuildContext context, int i) {
            var internship = internshipEntries[i].value;
            return Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 8,
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: selectedIndex3 == i,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedIndex3 = i;
                        } else {
                          selectedIndex3 = null;
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: swidth * 0.5,
                      maxWidth: swidth * 0.6,
                    ),
                    child: Text(
                      "${internship?.companyName ?? 'google'}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: "Mulish",
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            );
          }) : const SizedBox(),
    );
  }
}
