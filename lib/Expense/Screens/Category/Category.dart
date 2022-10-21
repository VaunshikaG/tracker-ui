import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/Expense/Screens/Registration/Login.dart';

import '../../Common/Constants.dart';
import '../../Common/Helper.dart';
import '../../Common/Prefs.dart';
import '../../Common/theme.dart';
import '../../Models/Category/CategoryListPodo.dart';
import '../../Service/Category/Category_Api.dart';
import 'Category_Details.dart';

class Category extends StatefulWidget {
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  //  add categories
  final formKeys = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController expenseController = TextEditingController();

  bool _showData = false, _hideData = false;

@override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, this.categoryList);
  categoryList();
  }

  int categoryLength = 0;
  List<Data> _categoryList = [];
  void categoryList() async {
    showProgress(context, 'Please wait...', true);
    try {
      final prefs = await SharedPreferences.getInstance();
      print("login = ${prefs.getBool(CONST.LoggedIn)}");

      APIService apiService = new APIService();
      apiService.category_by_user().then((value) {
        if (value != null) {
          hideProgress();
          print("get_Allcategories ${value.status}");
          if (value.status == 200) {
            hideProgress();
            categoryLength = value.data.length;
            print(value.data.length);

            if (value.data.length == 0) {
              _hideData = true;
              _showData = false;
            } else {
              _hideData = false;
              _showData = true;
            }

            _categoryList = value.data;
            _categoryList.sort((a, b) {
              return a.categoryId.compareTo(b.categoryId);
            });
          } else {
            return "Failed to load data!";
          }
        }
      });
    } catch (e) {
      print('cart exception = $e');
    }
  }

  void addcategory() async {
    try {
      showProgress(context, 'Please wait...', true);
      final prefs = await SharedPreferences.getInstance();

      var title = titleController.text;
      var description = descController.text;
      var amount = expenseController.text;

      APIService apiService = new APIService();
      apiService.add_category(title, description, amount).then((value) {
        setState(() {
          if (value != null) {
            hideProgress();
            print("add_category ${value.status}");
            if (value.status == 200) {
              reload();
              print("$title  $description  $amount");
              ScaffoldMessenger(child: Text(value.message));
            } else {
              return "Failed to load data!";
            }
          }
        });
      });
    } catch (e) {
      print('cart exception = $e');
    }
  }

  Widget addcategories() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext buildContext) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        title: const Text(
          'Add Category',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: CustomTheme.Grey1,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Form(
            key: formKeys,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  title
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Name :',
                    style: TextStyle(
                      // fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                    // autofocus: true,
                    textInputAction: TextInputAction.next,
                    // minLines: 1,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                //  description
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Description :',
                    style: TextStyle(
                      // fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7, bottom: 0),
                  child: TextFormField(
                    controller: descController,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                    // autofocus: true,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    maxLines: 3,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                //  totalexpense
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Total Expense :',
                    style: TextStyle(
                      // fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: TextFormField(
                    controller: expenseController,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Please enter expense';
                      }
                      return null;
                    },
                    // autofocus: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          //  submit
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomTheme.Grey2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Navigator.of(buildContext).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomTheme.Grey2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    setState(() {
                    if (formKeys.currentState.validate()) {
                      formKeys.currentState.save();
                      addcategory();
                    }
                    });
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => reload(),
            ),
            IconButton(
              alignment: const Alignment(0, 0),
              icon: const Icon(Icons.logout),
              splashColor: Colors.white,
              onPressed: () {
                Prefs.instance.removeAll();
                print("user logged out");
                Navigator.of(context).pushReplacement(new MaterialPageRoute
                  (builder: (context) => Loginpg()));
              },
            ),
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: _hideData,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 150,
                      child: Text(
                        'No Data Found',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/img/no-data.jpg',
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _showData,
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
                          itemCount: categoryLength ?? 0,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setString(
                                    CONST.categoryId, _categoryList[index].categoryId);
                                prefs.setString(
                                    CONST.title, _categoryList[index].title);
                                prefs.setString(
                                    CONST.desc, _categoryList[index].description);
                                prefs.setString(
                                    CONST.amount, _categoryList[index].amount);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CategoryDetails()));
                              },
                              child: ListTile(
                                leading: Text(
                                  (index+1).toString(),
                                  // _categoryList[index].categoryId,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                title: Text(
                                  _categoryList[index].title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  _categoryList[index].description,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  _categoryList[index].amount.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: CustomTheme.Grey2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
            onPressed: () => addcategories(),
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

  void reload() {
    showProgress(context, 'Please wait...', true);
    Navigator.of(context).pushReplacement(new MaterialPageRoute
      (builder: (context) => Category()));
    hideProgress();
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
                        style: TextStyle(fontSize: 16,
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
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
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
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
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
  void dispose() {
    super.dispose();
  }

}
