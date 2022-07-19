import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../BLoC/Category/Category_BloC.dart';
import '../../Common/Constants.dart';
import '../../Common/Prefs.dart';
import '../../Common/theme.dart';
import '../../Models/Category/CategoryModel.dart';
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

  Widget addcategories(BuildContext context) {
    final bloc = Provider.of<CategoryBloC>(context, listen: false);

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
          height: MediaQuery.of(context).size.height * 0.47,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Form(
            key: formKeys,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                // user id
                const SizedBox(
                  height: 25,
                  child: Text(
                    'User Id : ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),

                //  category id
                const SizedBox(
                  height: 27,
                  child: Text(
                    'Category Id :  ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),

                //  title
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Category Name :',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                StreamBuilder<String>(
                  stream: bloc.title,
                  builder: (context, AsyncSnapshot<String> snapshot) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: TextFormField(
                      //  to set entered title
                      onChanged: bloc.changedTitle,
                      controller: titleController,
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                      autofocus: true,
                      textInputAction: TextInputAction.newline,
                      // minLines: 1,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 17),
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
                ),

                const SizedBox(height: 10),

                //  description
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Category Description :',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                StreamBuilder(
                  stream: bloc.desc,
                  builder: (context, AsyncSnapshot<String> snapshot) => Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 0),
                    child: TextFormField(
                      //  to set entered desc
                      onChanged: bloc.changedDesc,
                      controller: descController,
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      // minLines: 1,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 17),
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
                ),

                const SizedBox(height: 10),

                //  totalexpense
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Total Expense :',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                /*StreamBuilder<String>(
                  stream: bloc.title,
                  builder: (context, AsyncSnapshot<String> snapshot) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: TextFormField(
                      //  to set entered title
                      // onChanged: bloc.changedTitle,
                      controller: expenseController,
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'Please enter expense';
                        }
                        return null;
                      },
                      autofocus: true,
                      textInputAction: TextInputAction.newline,
                      // minLines: 1,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 17),
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
                ),*/
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
                child: FlatButton(
                  color: CustomTheme.Grey2,
                  splashColor: CustomTheme.Blue3,
                  hoverColor: CustomTheme.Blue3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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
              StreamBuilder(
                stream: bloc.isValid,
                builder: (context, snapshot) => SizedBox(
                  height: 40,
                  width: 100,
                  child: FlatButton(
                    color: CustomTheme.Grey2,
                    splashColor: CustomTheme.Blue3,
                    hoverColor: CustomTheme.Blue3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      // setState(() {
                      if (formKeys.currentState.validate()) {
                        formKeys.currentState.save();
                        Prefs.instance.getStringValue(CONST.token);
                        bloc.submit(context);
                        Navigator.of(buildContext).pop(false);
                      }
                      // });
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
  void initState() {
    setNames();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var _uID;
  Future<void> setNames() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var uID = await prefs.getString(CONST.userId);
    setState(() => _uID = uID);
    print('user = $_uID');
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
          actions: [
            IconButton(
              alignment: const Alignment(0, 0),
              icon: const Icon(Icons.logout),
              splashColor: Colors.white,
              onPressed: () {
                Prefs.instance.removeAll();
                print("user logged out");
                Navigator.popAndPushNamed(context, '/myapp');
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: catbloc.usersList,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Text('There was an error : ${snapshot.error}');
            List<CategoryModel> users = snapshot.data;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 15, 10, 5),
                  child: Text(
                    'User Id :  ${_uID}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: users?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      CategoryModel _user = users[index];
                      return GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          var catID = prefs.setString(CONST.categoryId, _user.categoryId);
                          print('cid = $catID');
                          _user.categoryId;
                          Navigator.of(context).push(MaterialPageRoute
                            (builder: (context) => CategoryDetails()));
                        },
                        child: ListTile(
                          leading: Text(
                            _user.categoryId,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: Text(
                            _user.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            _user.description,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Text(
                            _user.totalexpense,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
                ),
              ],
            );
            },
        ),

        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: 10),
          child: FloatingActionButton(
            child: const Text(
              "+ Add",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              addcategories(context);
            },
            elevation: 10,
            backgroundColor: CustomTheme.Grey2,
            splashColor: CustomTheme.Blue3,
            hoverColor: CustomTheme.Blue3,
          ),
        ),
      ),
      onWillPop: () => SystemNavigator.pop(),
    );
  }
}
