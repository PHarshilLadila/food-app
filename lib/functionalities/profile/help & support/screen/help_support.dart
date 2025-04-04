// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/profile/help%20&%20support/model/query_model.dart';
import 'package:food_app/functionalities/profile/help%20&%20support/provider/query_provider.dart';
import 'package:food_app/functionalities/profile/help%20&%20support/widget/contactus_tab.dart';
import 'package:food_app/functionalities/profile/help%20&%20support/widget/faq_tab.dart';
import 'package:food_app/functionalities/profile/help%20&%20support/widget/raised_complain_tab.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  TextEditingController queryController = TextEditingController();

  String myTicketId = "0";
  String getRandomNumber() {
    final r = Random();
    var data = List<int>.generate(6, (index) => r.nextInt(10))
        .fold<String>("", (prev, i) => prev += i.toString());

    setState(() {
      myTicketId = data;
      debugPrint(data);
      debugPrint(myTicketId);
    });

    return myTicketId;
  }

  Future<void> addQuery() async {
    final databaseBox = Hive.box('userProfile');
    var userId = await databaseBox.get('userid');
    final provider = Provider.of<QueryProvider>(context, listen: false);
    final query = QueryModel(
      ticketId: myTicketId,
      userId: userId,
      query: queryController.text.trim(),
    );
    provider.addQueries(query);
    queryController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Ticket Id : $myTicketId, Your Complaint is Registered. Our Team will contact you as soon as possible.",
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QueryProvider>(context, listen: false).loadQueries();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          toolbarHeight: 70,
          flexibleSpace: const Image(
            image: AssetImage('assets/images/Pattern.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: GradientText(
            "Raised Your Query Here",
            // AppLocalizations.of(context)!.helpAndSupportTitle,
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w400),
            gradient: const LinearGradient(
              colors: [
                AppColors.lightGreen,
                AppColors.darkGreen,
              ],
            ),
          ),
          bottom: TabBar(
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            indicator: BoxDecoration(
              color: const Color.fromARGB(54, 8, 133, 12),
              borderRadius: BorderRadius.circular(12),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.blackColor,
            indicatorColor: AppColors.darkGreen,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Raised Complains"),
              Tab(text: "Contact Us"),
              Tab(text: "FAQ"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RaisedComplainTab(
              height: height,
              width: width,
              queryController: queryController,
              addQuery: addQuery,
              getRandomNumber: getRandomNumber,
            ),
            const ContactUsTab(),
            const FAQTab(),
          ],
        ),
      ),
    );
  }
}
