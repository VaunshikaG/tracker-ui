import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
import '../../Widgets/CustomScreenRoute.dart';
import 'Category_Details.dart';

class Category extends StatefulWidget {
  @override
  State<Category> createState() => CategoryState();
}

class CategoryState extends State<Category> {
  final catbloc = CategoryBloC();
  Stream<CategoryListPodo> _getCat;
  CategoryListPodo catList;

  List<Data> _categoryList = [];
  final formKeys = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController expenseController = TextEditingController();

  bool _appBar = true, _isSearching = false;
  Icon customIcon = const Icon(CupertinoIcons.search, color: CustomTheme.pink2);
  Widget customSearchBar = Center(
    child: Text(
      'Expensify',
      style: TextStyle(
        fontSize: 30,
        color: CustomTheme.pink2,
        fontWeight: FontWeight.w600,
        fontFamily: "Sacramento",
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _getCat = catbloc.catList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final catbloc = Provider.of<CategoryBloC>(context, listen: false);

    return WillPopScope(
      child: Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomTheme.grey,
          leadingWidth: double.infinity,
          leading: customSearchBar,
          actions: [
            Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: -10,
              children: [
                /*IconButton(
                  alignment: const Alignment(0, 0),
                  icon: customIcon,
                  splashColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      if (this.customIcon.icon == CupertinoIcons.search) {
                        this.customIcon = const Icon(Icons.cancel_outlined, color: CustomTheme.pink2);
                        this.customSearchBar = SizedBox(
                          width: 200,
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(CupertinoIcons.search, color: CustomTheme.pink2),
                              hintText: 'Search your note...',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        this.customIcon = const Icon(CupertinoIcons.search, color: CustomTheme.pink2);
                        this.customSearchBar = Center(
                          child: Text(
                            'Expensify',
                            style: TextStyle(
                              fontSize: 30,
                              color: CustomTheme.pink2,
                              fontWeight: FontWeight.w600,

                            ),
                          ),
                        );
                      }
                    });
                    // setState(() => _isSearching = true);
                    // search();
                  },
                ),*/
                IconButton(
                  alignment: const Alignment(0, 0),
                  icon: const Icon(
                    CupertinoIcons.refresh,
                    color: CustomTheme.pink2,
                  ),
                  splashColor: Colors.white,
                  onPressed: () => refreshCall(),
                ),
                IconButton(
                  alignment: const Alignment(0, 0),
                  icon: const Icon(
                    Icons.logout,
                    color: CustomTheme.pink2,
                  ),
                  splashColor: Colors.white,
                  onPressed: () {
                    Prefs.instance.removeAll();
                    print("user logged out");
                    Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(builder: (context) => Loginpg()));
                  },
                ),
              ],
            ),
          ],
        ),
        body: StreamBuilder(
          stream: _getCat,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              catList = snapshot.data;
              print(catList.data.length);
              if (catList.data.length == 0)
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Color.alphaBlend(const Color(0xAAFFFFFF), CustomTheme.coral2),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    'Get started by clicking the below button',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 1,
                      color: CustomTheme.grey,
                      fontWeight: FontWeight.normal,

                    ),
                  ),
                );

              return Container(
                margin: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.builder(
                  itemCount: catList.data.length ?? 0,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final note = catList.data[index];
                    return GestureDetector(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(CONST.categoryId, note.categoryId);
                        prefs.setString(CONST.title, note.title);
                        prefs.setString(CONST.desc, note.description);
                        prefs.setString(CONST.amount, note.amount);

                        await Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (context) =>
                                new CategoryDetails(screen: 0)));
                        refreshCall();
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CustomTheme.grey,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          color: Color.alphaBlend(Color(0xAAFFFFFF),
                              CustomTheme.coral2),
                          // color: Color.alphaBlend(Color(0xAAFFFFFF), colorList[index]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                note.title ?? "",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: CustomTheme.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              note.description ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                color: CustomTheme.grey,
                              ),
                            ),
                            Text(
                              note.amount ?? "",
                              style: const TextStyle(
                                fontSize: 15,
                                color: CustomTheme.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );

            } else if (snapshot.hasError) {
              return Text('There was an error : ${snapshot.error}');
            }
            return const Center(
              child: Text(
                'Get started by clicking the below button',
                style: TextStyle(
                  fontSize: 30,
                  color: CustomTheme.pink2,
                  fontWeight: FontWeight.w600,

                ),
              ),
            );
          },
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: CustomTheme.coral2)
          ),
          child: FloatingActionButton.extended(
            heroTag: UniqueKey(),
            label: const Text(
              "+ Add",
              style: TextStyle(
                fontSize: 16,
                color: CustomTheme.pink2,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Navigator.of(context).pushReplacement(
                new MaterialPageRoute(
                    builder: (context) => new CategoryDetails(screen: 1))),
            // onPressed: () => addcategories(),
            elevation: 10,
            backgroundColor: CustomTheme.grey,
            splashColor: Colors.white,
          ),
        ),
      ),
      onWillPop: () => _onWillPop(),
    );
  }

  Widget search() {
    print('searching..');

    return  Container(
      padding: const EdgeInsets.fromLTRB(1, 3, 1, 3),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          hintText: "Search Mutual Fund..",
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFFB3B1B1),
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 26,
            color: Colors.black54,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45.0),
            borderSide: const BorderSide(
              width: 1.0,
              color: Color(0xFFFF0000),
            ), // BorderSide
          ), // OutlineInputBorder
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45.0),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.grey,
            ), // BorderSide
          ), // OutlineInputBorder
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45.0),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.grey,
            ), // BorderSide
          ), // OutlineInputBorder
        ), // InputDecoration
      ),
    );
  }


  /*Widget old() {
    final catbloc = Provider.of<CategoryBloC>(context, listen: false);
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomTheme.grey2,
          leadingWidth: 150,
          leading: GestureDetector(
            onTap: () => _scaffoldkey.currentState.openDrawer(),
            child:
            Padding(
              padding: EdgeInsets.only(left: 15, top: 9),
              child: Text(
                'Expensify',
                style: TextStyle(
                  fontSize: 30,
                  color: CustomTheme.pink2,
                  fontWeight: FontWeight.w600,

                ),
              ),
            ),

            // Image.asset(
            //   'assets/img/logo02.png',
            //   width: 100,
            // ),
          ),
          actions: [
            IconButton(
              alignment: const Alignment(0, 0),
              icon: const Icon(
                Icons.refresh,
                color: CustomTheme.pink2,
              ),
              splashColor: Colors.white,
              onPressed: () => refreshCall(),
            ),
            IconButton(
              alignment: const Alignment(0, 0),
              icon: const Icon(
                Icons.logout,
                color: CustomTheme.pink2,
              ),
              splashColor: Colors.white,
              onPressed: () {
                Prefs.instance.removeAll();
                print("user logged out");
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => Loginpg()));
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: _getCat,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              catList = snapshot.data;
              print(catList.data.length);

              return Container(
                margin: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.builder(
                  itemCount: catList.data.length ?? 0,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final note = catList.data[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      dismissThresholds: const {
                        DismissDirection.startToEnd: 0.25
                      },
                      movementDuration: const Duration(milliseconds: 800),
                      resizeDuration: const Duration(milliseconds: 600),
                      onDismissed: (direction) async {
                        final prefs = await SharedPreferences.getInstance();

                        prefs.setString(CONST.title, note.title);
                        prefs.setString(CONST.desc, note.description);
                        prefs.setString(CONST.amount, note.amount);
                        await catbloc.deletecategory(context);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('You just deleted a note'),
                          action: SnackBarAction(
                            onPressed: () async {
                              final prefs = await SharedPreferences.getInstance();

                              note.title = prefs.getString(CONST.title);
                              note.description = prefs.getString(CONST.desc);
                              note.amount = prefs.getString(CONST.amount);

                              await catbloc.savecategory(context);
                              refreshCall();
                            },
                            label: "UNDO",
                          ),
                          duration: const Duration(milliseconds: 2000),
                        ));
                      },
                      background: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red[400],
                        ),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString(CONST.categoryId, note.categoryId);
                          prefs.setString(CONST.title, note.title);
                          prefs.setString(CONST.desc, note.description);
                          prefs.setString(CONST.amount, note.amount);

                          await Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (context) =>
                                  new CategoryDetails(screen: 0)));
                          refreshCall();
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CustomTheme.grey2,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            color: Color.alphaBlend(Color(0xAAFFFFFF),
                                CustomTheme.coral2),
                            // color: Color.alphaBlend(Color(0xAAFFFFFF), colorList[index]),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  note.title ?? "",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: CustomTheme.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                note.description ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: CustomTheme.grey,
                                ),
                              ),
                              Text(
                                note.amount ?? "",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: CustomTheme.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );

            } else if (snapshot.hasError) {
              return Text('There was an error : ${snapshot.error}');
            }
            return const Text('');
          },
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: CustomTheme.coral2)
          ),
          child: FloatingActionButton.extended(
            heroTag: UniqueKey(),
            label: const Text(
              "+ Add",
              style: TextStyle(
                fontSize: 16,
                color: CustomTheme.pink2,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Navigator.of(context).pushReplacement(
                new MaterialPageRoute(
                    builder: (context) => new CategoryDetails(screen: 1))),
            // onPressed: () => addcategories(),
            elevation: 10,
            backgroundColor: CustomTheme.grey2,
            splashColor: Colors.white,
          ),
        ),
      ),
      onWillPop: () => _onWillPop(),
    );
  }*/


  Future<void> refreshCall() async {
    // await catbloc.catList;
    WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.push(context, new MaterialPageRoute(builder: (context) => new Category())));
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
                        color: CustomTheme.grey2,
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                        primary: Color.alphaBlend(const Color(0xAAFFFFFF),
                            CustomTheme.coral2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 8),
                      ),
                      label: new Text(
                        'No',
                        style: TextStyle(
                          fontSize: 17,
                          color: CustomTheme.grey2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.check,
                        color: CustomTheme.pink2,
                      ),
                      // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FingerprintPage())),
                      onPressed: () => SystemNavigator.pop(),
                      style: ElevatedButton.styleFrom(
                        primary: CustomTheme.grey2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 8),
                      ),
                      label: new Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: 17,
                          color: CustomTheme.pink2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
