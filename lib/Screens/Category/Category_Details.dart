import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tracker_ui/Common/Constants.dart';
import 'package:tracker_ui/Common/Prefs.dart';
import 'package:tracker_ui/Models/Category/Model2.dart';

import '../../BLoC/Category/Category_BloC.dart';
import '../../Common/theme.dart';
import '../../Models/Category/CategoryModel.dart';
import '../../Service/Category/Category_Api.dart';
import 'Category.dart';

class CategoryDetails extends StatefulWidget {

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  @override
  void initState() {
    getData();
    // bloc.getCategory();
    super.initState();
  }

  @override
  void dispose() {
    // bloc.dispose();
    super.dispose();
  }

  var datalength = 0;
  List<CategoryModel> data = [];
  var cId, title, description, total;

  void getData() {
    try {
      ApiService apiService = new ApiService();
      apiService.get_CategoryByID().then((value) {
        if(value != null) {
          cId = data[0].categoryId;
          title = data[0].title;
          description = data[0].description;
          total = data[0].totalexpense;
          print('title = $title');
          print('title = ${data[0].title}');
        }
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CategoryBloC>(context, listen: false);

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomTheme.Grey2,
          title: const Text(
            'CATEGORY',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => Category())),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  child: Text(
                    'Category Id :  $cId',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Text(
                    'Title :  $title',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Text(
                    'Description :  $description',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Text(
                    'Total Expense :  $total',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
      onWillPop: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {return Category();})),
    );
  }
}
