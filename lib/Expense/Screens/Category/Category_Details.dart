import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/Expense/BLoC/Category/Category_BloC.dart';
import 'package:tracker_ui/Expense/Common/Constants.dart';

import '../../Models/Category/CategoryPodo.dart';
import '../../Widgets/color_radio_button.dart';
import '../../Widgets/snackbar.dart';
import '../../Common/theme.dart';
import '../../Models/Category/CategoryListPodo.dart';
import 'Category.dart';

class CategoryDetails extends StatefulWidget {
  final int screen;

  //  0 = edit, 1 = add

  const CategoryDetails({Key key, this.screen}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final catbloc = CategoryBloC();
  Stream<CategoryPodo> _getCat;

  bool showSave = true, showUpdate = true, showDel = true;
  String id;
  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController amtController = new TextEditingController();
  int radioButtonValue = 0;

  @override
  void initState() {
    super.initState();
    getPrefs();

    _getCat = catbloc.cat_by_id;
  }

  void getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    //  0 = edit, 1 = add

    if (widget.screen == 0) {
      setState(() {
        showSave = false;
        showUpdate = true;
        showDel = true;
        id = prefs.getString(CONST.categoryId);
        titleController.text = prefs.getString(CONST.title);
        descController.text = prefs.getString(CONST.desc);
        amtController.text = prefs.getString(CONST.amount);
        print("id:  $id ");
      });
    } else if (widget.screen == 1) {
      setState(() {
        showSave = true;
        showUpdate = false;
        showDel = false;
        id = "";
        titleController.text = "";
        descController.text = "";
        amtController.text = "";
        print("screen:  ${widget.screen}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final catbloc = Provider.of<CategoryBloC>(context, listen: true);

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomTheme.grey,
          title: Text(
          (widget.screen == 0) ? 'Edit' : 'Save',
            style: TextStyle(
              color: CustomTheme.pink2,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: CustomTheme.pink2,
            ),
            onPressed: () {
              print("back");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Category()));
            },
          ),
        ),
        body:
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
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
              StreamBuilder<String>(
                stream: catbloc.title,
                builder: (context, AsyncSnapshot<String> snapshot) =>
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      alignment: Alignment.centerRight,
                      child: TextFormField(
                        onChanged: catbloc.changedTitle,
                        controller: titleController,
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20),
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          errorText: snapshot.error,
                          errorStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
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
              ),

              //  desc
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
              StreamBuilder<String>(
                stream: catbloc.desc,
                builder: (context, AsyncSnapshot<String> snapshot) =>
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      alignment: Alignment.centerRight,
                      child: TextFormField(
                        onChanged: catbloc.changedDesc,
                        controller: descController,
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        maxLines: 5,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200),
                        ],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          errorText: snapshot.error,
                          errorStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
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
              ),

              //  amt
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
              StreamBuilder<String>(
                stream: catbloc.amt,
                builder: (context, AsyncSnapshot<String> snapshot) =>
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextFormField(
                        onChanged: catbloc.changedAmt,
                        controller: amtController,
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return 'Please enter expense';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(7),
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        decoration: InputDecoration(
                          errorText: snapshot.error,
                          errorStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
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
            Visibility(
              visible: showSave,
              child: StreamBuilder(
                stream: catbloc.isValid,
                builder: (context, snapshot) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: CustomTheme.coral2)
                  ),
                  height: 45,
                  width: 110,
                  child: FloatingActionButton.extended(
                    heroTag: UniqueKey(),
                    icon: const Icon(
                      CupertinoIcons.checkmark_alt,
                      size: 20,
                      color: CustomTheme.pink2,
                    ),
                    label: const Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomTheme.pink2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      print("save");
                      if (snapshot.hasData) {
                        catbloc.savecategory(context);
                      } else if (snapshot.hasError) {
                        return CustomSnackBar(context, Text(snapshot.error));
                      }
                      return Text('');
                    },
                    elevation: 5,
                    backgroundColor: CustomTheme.grey,
                    splashColor: Colors.white,
                    extendedIconLabelSpacing: 5,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: showUpdate,
              child: StreamBuilder(
                stream: catbloc.isValid,
                builder: (context, snapshot) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: CustomTheme.coral2)
                  ),
                  height: 45,
                  width: 110,
                  child: FloatingActionButton.extended(
                    heroTag: UniqueKey(),
                    icon: const Icon(
                      CupertinoIcons.up_arrow,
                      size: 18,
                      color: CustomTheme.pink2,
                    ),
                    label: const Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomTheme.pink2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      print(snapshot.error);
                      print(snapshot.hasData);
                      print("update");
                      if (snapshot.hasData) {
                        catbloc.updatecategory(context);
                      } else if (snapshot.hasError) {
                        return CustomSnackBar(context, Text(snapshot.error));
                      }
                      return Text('');
                    },
                    elevation: 5,
                    backgroundColor: CustomTheme.grey,
                    splashColor: Colors.white,
                    extendedIconLabelSpacing: 3,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: showDel,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: CustomTheme.coral2)
                ),
                height: 45,
                width: 110,
                child: FloatingActionButton.extended(
                  heroTag: UniqueKey(),
                  icon: const Icon(
                    CupertinoIcons.delete,
                    size: 17,
                    color: CustomTheme.pink2,
                  ),
                  label: const Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 16,
                      color: CustomTheme.pink2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Delete category?',
                          style: TextStyle(
                            fontSize: 17,
                            color: CustomTheme.grey2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.alphaBlend(const Color
                                (0xAAFFFFFF), CustomTheme.coral2),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 17,
                                color: CustomTheme.grey2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          StreamBuilder(
                              stream: catbloc.isValid,
                              builder: (context, snapshot) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomTheme.grey2,
                                  ),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: CustomTheme.pink2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () async {
                                    print(snapshot.error);
                                    print(snapshot.hasData);
                                    print("delete");
                                    if (snapshot.hasData) {
                                      catbloc.deletecategory(context);
                                    } else if (snapshot.hasError) {
                                      return CustomSnackBar(
                                          context, Text(snapshot.error));
                                    }
                                    return Text('');
                                  },
                                );
                              }),
                        ],
                      );
                    },
                  ),
                  elevation: 5,
                  backgroundColor: CustomTheme.grey,
                  splashColor: Colors.white,
                  extendedIconLabelSpacing: 5,
                ),
              ),
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

  Widget old() {
    return StreamBuilder(
          stream: _getCat,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              CategoryPodo catpodo = snapshot.data;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
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
                    StreamBuilder<String>(
                      stream: catbloc.title,
                      builder: (context, AsyncSnapshot<String> snapshot) =>
                          Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        alignment: Alignment.centerRight,
                        child: TextFormField(
                          onChanged: catbloc.changedTitle,
                          controller: titleController,
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Please enter title';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          maxLines: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                            FilteringTextInputFormatter.singleLineFormatter,
                          ],
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            errorText: snapshot.error,
                            errorStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
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
                    ),

                    //  desc
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
                    StreamBuilder<String>(
                      stream: catbloc.desc,
                      builder: (context, AsyncSnapshot<String> snapshot) =>
                          Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        alignment: Alignment.centerRight,
                        child: TextFormField(
                          onChanged: catbloc.changedDesc,
                          controller: descController,
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Please enter description';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          maxLines: 5,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(200),
                          ],
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            errorText: snapshot.error,
                            errorStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
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
                    ),

                    //  amt
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
                    StreamBuilder<String>(
                      stream: catbloc.amt,
                      builder: (context, AsyncSnapshot<String> snapshot) =>
                          Container(
                        alignment: Alignment.centerRight,
                        child: TextFormField(
                          onChanged: catbloc.changedAmt,
                          controller: amtController,
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'Please enter expense';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(7),
                            FilteringTextInputFormatter.singleLineFormatter,
                          ],
                          decoration: InputDecoration(
                            errorText: snapshot.error,
                            errorStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('There was an error : ${snapshot.error}');
            }
            return Text('There was an error : ${snapshot.data}');
          },
        );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
