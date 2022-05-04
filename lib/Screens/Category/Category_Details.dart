import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_ui/Common/Constants.dart';
import 'package:tracker_ui/Models/Category/CategoryModel.dart';
import 'package:tracker_ui/Models/Category/Model2.dart';
import '../../BLoC/Category/Category_BloC.dart';
import '../../Common/theme.dart';
import '../../Service/Category/Category_Api.dart';
import 'Category.dart';

class CategoryDetails extends StatefulWidget {
  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catbloc = Provider.of<CategoryBloC>(context, listen: false);

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
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Category())),
          ),
        ),
        body: StreamBuilder(
          stream: catbloc.catList,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Text('There was an error : ${snapshot.error}');
            List<Model2> users = snapshot.data;

            return ListView.separated(
              itemCount: users?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Model2 _user = users[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'ID :   ${_user.categoryId}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Title :    ${_user.title}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Description :    ${_user.description}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Total Expense :    ${_user.totalexpense}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Divider(),
            );
          },
        ),
      ),
      onWillPop: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return Category();
      })),
    );
  }
}
