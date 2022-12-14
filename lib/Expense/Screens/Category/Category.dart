import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/Expense/BLoC/Category/Category_BloC.dart';
import 'package:tracker_ui/Expense/Screens/Registration/Login.dart';

import '../../Common/Constants.dart';
import '../../Common/Prefs.dart';
import '../../Common/theme.dart';
import '../../Models/Category/CategoryListPodo.dart';
import 'Category_Details.dart';

class Category extends StatefulWidget {
  @override
  State<Category> createState() => podoState();
}

class podoState extends State<Category> {
  final catbloc = CategoryBloC();
  Stream<CategoryListPodo> _getCat;

  final formKeys = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController expenseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCat = catbloc.catList;
  }

  @override
  Widget build(BuildContext context) {
    final catbloc = Provider.of<CategoryBloC>(context, listen: false);

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomTheme.Grey2,
          title: const Text(
            'CATEGORY',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              alignment: const Alignment(0, 0),
              icon: const Icon(Icons.refresh),
              splashColor: Colors.white,
              onPressed: () => refreshCall(),
            ),
            IconButton(
              alignment: const Alignment(0, 0),
              icon: const Icon(Icons.logout),
              splashColor: Colors.white,
              onPressed: () {
                Prefs.instance.removeAll();
                print("user logged out");
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => Loginpg()));
              },
            ),
          ],
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: _getCat,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              CategoryListPodo catList = snapshot.data;
              print(catList.data.length);
              return RefreshIndicator(
                onRefresh: () async {
                  // _getCat;
                  catbloc.catList;
                },
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            "NO.",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: Text(
                            "NAME",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Text(
                            "AMOUNT",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          tileColor: CustomTheme.Blue4,
                          visualDensity: VisualDensity.compact,
                        ),
                        Divider(
                          color: CustomTheme.Grey2,
                          height: 0,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: catList.data.length ?? 0,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(CONST.categoryId,
                                      catList.data[index].categoryId);
                                  prefs.setString(
                                      CONST.title, catList.data[index].title);
                                  prefs.setString(CONST.desc,
                                      catList.data[index].description);
                                  prefs.setString(
                                      CONST.amount, catList.data[index].amount);
                                  Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new CategoryDetails(screen: 0)));
                                },
                                child: ListTile(
                                  leading: Text(
                                    (index + 1).toString(),
                                    // _categoryList[index].categoryId,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  title: Text(
                                    catList.data[index].title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    catList.data[index].description,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: Text(
                                    catList.data[index].amount,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                Divider(color: CustomTheme.Grey2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('There was an error : ${snapshot.error}');
            }
            return Text('There was an error : ${snapshot.data}');
          },
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: 10),
          child: FloatingActionButton.extended(
            heroTag: UniqueKey(),
            label: const Text(
              "+ Add",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Navigator.of(context).pushReplacement(
                new MaterialPageRoute(
                    builder: (context) => new CategoryDetails(screen: 1))),
            // onPressed: () => addcategories(),
            elevation: 10,
            backgroundColor: CustomTheme.Grey2,
            splashColor: CustomTheme.Blue3,
            hoverColor: CustomTheme.Blue3,
          ),
        ),
      ),
      onWillPop: () => _onWillPop(),
    );
  }

  void refreshCall() async {
    await catbloc.catList;
    print("refresh");
  }

  Future<bool> _onWillPop() async {
    showRoundedModalBottomSheet(
        radius: 15,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 180,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      'Exit?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Do you want to exit an App',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.close,
                        color: CustomTheme.Blue1,
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                        primary: CustomTheme.Blue4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: CustomTheme.Blue4)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 8),
                      ),
                      label: new Text(
                        'No',
                        style: TextStyle(
                          color: CustomTheme.Blue1,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FingerprintPage())),
                      onPressed: () => SystemNavigator.pop(),
                      style: ElevatedButton.styleFrom(
                        primary: CustomTheme.Blue1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: CustomTheme.Blue1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 8),
                      ),
                      label: new Text('Yes'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
