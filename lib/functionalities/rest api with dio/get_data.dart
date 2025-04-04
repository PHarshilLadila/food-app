// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/functionalities/rest%20api%20with%20dio/add_demo_data_in_model.dart';
import 'package:food_app/functionalities/rest%20api%20with%20dio/provider/rest_demo.dart';
import 'package:provider/provider.dart';

class Getdata extends StatefulWidget {
  const Getdata({super.key});

  @override
  State<Getdata> createState() => _GetdataState();
}

class _GetdataState extends State<Getdata> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<RestDemo>(context, listen: false).getDemoData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Demo Data"),
      ),
      body: Consumer<RestDemo>(
        builder: (BuildContext context, RestDemo value, Widget? child) {
          if (value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (value.errorMessage != null) {
            return Center(child: Text("Error: ${value.errorMessage}"));
          }

          final data = value.demodata;
          if (data.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          return ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final employee = data[index];

              return ListTile(
                title: Text(employee.employeeName ?? "No Name"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Salary: \$${employee.employeeSalary.toString()}"),
                    Text("Age: ${employee.employeeAge.toString()}"),
                  ],
                ),
                leading: CircleAvatar(
                  child: employee.profileImage != null &&
                          employee.profileImage!.isNotEmpty
                      ? Image.network(employee.profileImage!)
                      : Icon(Icons.person),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, shape: const CircleBorder()),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddDemoDataInModel(),
                    ));
              },
              child: FaIcon(FontAwesomeIcons.add),
            ),
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, shape: const CircleBorder()),
              onPressed: () {},
              child: FaIcon(FontAwesomeIcons.remove),
            ),
          ),
        ],
      ),
    );
  }
}
