import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/web_view/web_view.dart';

Widget defaultTextForm(
    {required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData prefixicon,
    required TextInputType type,
    bool isPassword = false,
    IconData? suffixicon,
    required String? validate(String? value),
    required onChange(String? value)}) {
  return TextFormField(
    controller: controller,
    validator: validate,
    onChanged: onChange,
    cursorColor: Colors.blueAccent,
    obscureText: isPassword,
    keyboardType: type,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(prefixicon),
        suffixIcon: IconButton(
          icon: Icon(isPassword ? suffixicon : null),
          onPressed: () {},
        )),
  );
}

Widget buildArticleItem(list, context, {isSearch = false}) =>
    ConditionalBuilder(
        condition: list.length > 0,
        builder: (context2) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context2, index) => InkWell(
                onTap: () {
                  navigateTo(context2, WebViewScreen(list[index]['url']));
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      list[index]['urlToImage'] != null
                          ? Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${list[index]['urlToImage']}'),
                                  )),
                            )
                          : Container(
                              width: 120,
                              height: 120,
                              padding: EdgeInsetsDirectional.all(40),
                              child: Icon(
                                Icons.file_download_off,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          height: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    '${list[index]['title']}'),
                              ),
                              Text(
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                  '${list[index]['publishedAt']}')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: list.length),
        fallback: (context) => isSearch
            ? Container()
            : Center(
                child: CircularProgressIndicator(color: Colors.orange),
              ));

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function() function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );
void ShowToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state: state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor({required ToastStates state}) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}
