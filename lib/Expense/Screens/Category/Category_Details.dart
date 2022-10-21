import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/Expense/Common/Constants.dart';
import '../../Common/Helper.dart';
import '../../Common/theme.dart';
import '../../Service/Category/Category_Api.dart';
import 'Category.dart';

class CategoryDetails extends StatefulWidget {
  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  String id;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  void getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString(CONST.categoryId);
    titleController.text = prefs.getString(CONST.title);
    descController.text = prefs.getString(CONST.desc);
    amtController.text = prefs.getString(CONST.amount);
    print(id);
  }

  void updatecategory() async {
    try {
      showProgress(context, 'Please wait...', true);
      final prefs = await SharedPreferences.getInstance();

      var title = titleController.text;
      var description = descController.text;
      var amount = amtController.text;

      APIService apiService = new APIService();
      apiService.update_category(title, description, amount).then((value) {
        setState(() {
          if (value != null) {
            hideProgress();
            print("add_category ${value.status}");
            if (value.status == 200) {
              print("$title  $description  $amount");

              ScaffoldMessenger(child: Text(value.message));

              Navigator.of(context).pushReplacement(new MaterialPageRoute
                (builder: (context) => Category()));
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

  void reload() {
    showProgress(context, 'Please wait...', true);
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => Category()));
    print("refresh");
  }

  void deletecategory() async {
    try {
      showProgress(context, 'Please wait...', true);
      final prefs = await SharedPreferences.getInstance();

      APIService apiService = new APIService();
      apiService.delete_category().then((value) {
        setState(() {
          if (value != null) {
            hideProgress();
            print("delete_category ${value.status}");
            if (value.status.contains("200")) {
              print(value.message);
              ScaffoldMessenger(child: Text(value.message));
              Navigator.of(context).pushReplacement(new MaterialPageRoute
                (builder: (context) => Category()));
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

  showDeleteConfirmation() {
    AlertDialog alert = AlertDialog(
      title: const Text(
        'Delete category?',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomTheme.Blue3,
          ),
          child: const Text(
            'Delete',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => deletecategory(),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomTheme.Grey2,
          title: const Text(
            'CATEGORY DETAILS',
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
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                alignment: Alignment.centerRight,
                child: TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value.isEmpty || value == null) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  // autofocus: true,
                  textInputAction: TextInputAction.newline,
                  // minLines: 1,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
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
                        color: Colors.grey,
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

              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                alignment: Alignment.centerRight,
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
                  textInputAction: TextInputAction.newline,
                  // minLines: 1,
                  maxLines: 5,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
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
                        color: Colors.grey,
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

              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'Total Expense',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextFormField(
                  controller: amtController,
                  validator: (value) {
                    if (value.isEmpty || value == null) {
                      return 'Please enter expense';
                    }
                    return null;
                  },
                  // autofocus: true,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.newline,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
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
                        color: Colors.grey,
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
        floatingActionButton: Wrap(
          direction: Axis.vertical,
          spacing: 10,
          children: [
            FloatingActionButton.extended(
              heroTag: UniqueKey(),
              icon: Icon(Icons.arrow_upward),
              label: const Text(
                "Update",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => updatecategory(),
              elevation: 10,
              backgroundColor: CustomTheme.Grey2,
              splashColor: CustomTheme.Blue3,
              hoverColor: CustomTheme.Blue3,
            ),
            FloatingActionButton.extended(
              heroTag: UniqueKey(),
              icon: Icon(Icons.delete),
              label: const Text(
                "Delete",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => showDeleteConfirmation(),
              elevation: 10,
              backgroundColor: CustomTheme.Grey2,
              splashColor: CustomTheme.Blue3,
              hoverColor: CustomTheme.Blue3,
            ),
          ],
        ),
      ),
      onWillPop: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return Category();
      })),
    );
  }



}
