// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_app/functionalities/rest%20api%20with%20dio/demo%20service/rest_api_service.dart';
import 'package:food_app/functionalities/rest%20api%20with%20dio/get_data.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_textform_field.dart';

class AddDemoDataInModel extends StatefulWidget {
  const AddDemoDataInModel({super.key});

  @override
  State<AddDemoDataInModel> createState() => _AddDemoDataInModelState();
}

class _AddDemoDataInModelState extends State<AddDemoDataInModel> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController profileController = TextEditingController();
  final apiService = RestApiService();

  bool isLoading = false;

  void _addEmployee() async {
    if (idController.text.isEmpty ||
        nameController.text.isEmpty ||
        salaryController.text.isEmpty ||
        ageController.text.isEmpty ||
        profileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      bool isSuccess = await apiService.addData(
        idController.text,
        nameController.text,
        salaryController.text,
        ageController.text,
        profileController.text,
      );

      setState(() => isLoading = false);

      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data added successfully!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Getdata()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to add data. Try again!")),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Data")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomeTextFormField(
                textEditingController: idController,
                hintText: "Enter Id",
                maxline: 1,
                obscureText: false,
                fillColor: const Color.fromARGB(255, 252, 255, 252),
                borderColor: const Color.fromARGB(255, 252, 255, 252),
                disabledColor: const Color.fromARGB(255, 252, 255, 252),
                enabledColor: AppColors.darkGreen,
                focusedColor: AppColors.darkGreen,
                hintcolors: const Color(
                  0xff3B3B3B,
                ),
                keyboradType: TextInputType.name,
              ),
              const SizedBox(height: 15),
              CustomeTextFormField(
                textEditingController: nameController,
                hintText: "Enter Name",
                maxline: 1,
                obscureText: false,
                fillColor: const Color.fromARGB(255, 252, 255, 252),
                borderColor: const Color.fromARGB(255, 252, 255, 252),
                disabledColor: const Color.fromARGB(255, 252, 255, 252),
                enabledColor: AppColors.darkGreen,
                focusedColor: AppColors.darkGreen,
                hintcolors: const Color(
                  0xff3B3B3B,
                ),
                keyboradType: TextInputType.name,
              ),
              const SizedBox(height: 15),
              CustomeTextFormField(
                textEditingController: salaryController,
                hintText: "Enter Salary",
                maxline: 1,
                obscureText: false,
                fillColor: const Color.fromARGB(255, 252, 255, 252),
                borderColor: const Color.fromARGB(255, 252, 255, 252),
                disabledColor: const Color.fromARGB(255, 252, 255, 252),
                enabledColor: AppColors.darkGreen,
                focusedColor: AppColors.darkGreen,
                hintcolors: const Color(
                  0xff3B3B3B,
                ),
                keyboradType: TextInputType.name,
              ),
              const SizedBox(height: 15),
              CustomeTextFormField(
                textEditingController: ageController,
                hintText: "Enter Age",
                maxline: 1,
                obscureText: false,
                fillColor: const Color.fromARGB(255, 252, 255, 252),
                borderColor: const Color.fromARGB(255, 252, 255, 252),
                disabledColor: const Color.fromARGB(255, 252, 255, 252),
                enabledColor: AppColors.darkGreen,
                focusedColor: AppColors.darkGreen,
                hintcolors: const Color(
                  0xff3B3B3B,
                ),
                keyboradType: TextInputType.name,
              ),
              const SizedBox(height: 15),
              CustomeTextFormField(
                textEditingController: profileController,
                hintText: "Enter Valid Image URL",
                maxline: 1,
                obscureText: false,
                fillColor: const Color.fromARGB(255, 252, 255, 252),
                borderColor: const Color.fromARGB(255, 252, 255, 252),
                disabledColor: const Color.fromARGB(255, 252, 255, 252),
                enabledColor: AppColors.darkGreen,
                focusedColor: AppColors.darkGreen,
                hintcolors: const Color(
                  0xff3B3B3B,
                ),
                keyboradType: TextInputType.name,
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: isLoading ? null : _addEmployee,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Add Data"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
