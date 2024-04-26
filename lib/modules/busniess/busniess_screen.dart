import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/component/components.dart';


class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener

      },
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
         return buildArticleItem(list,context);
        // return ConditionalBuilder(
        //     condition: list.length>0,
        //     builder: (context)=>ListView.separated(
        //       physics: BouncingScrollPhysics(),
        //         itemBuilder: (context,index)=>
        //
        // Padding(
        //       padding: const EdgeInsets.all(15.0),
        //       child: Row(
        //         children: [
        //           article['urlToImage'] != null
        //               ? Container(
        //                   width: 120,
        //                   height: 120,
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(15),
        //                       image: DecorationImage(
        //                         fit: BoxFit.cover,
        //                         image: NetworkImage('${article['urlToImage']}'),
        //                       )),
        //                 )
        //               : Container(
        //                   width: 120,
        //                   height: 120,
        //                   padding: EdgeInsetsDirectional.all(40),
        //                   child: Icon(
        //                     Icons.error,
        //                     color: Colors.grey,
        //                     size: 30,
        //                   ),
        //                 ),
        //           SizedBox(
        //             width: 20,
        //           ),
        //           Expanded(
        //             child: Container(
        //               height: 120,
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Expanded(
        //                     child: Text(
        //                         style: Theme.of(context).textTheme.displayMedium,
        //                         maxLines: 3,
        //                         overflow: TextOverflow.ellipsis,
        //                         '${article['title']}'),
        //                   ),
        //                   Text(
        //                       style: TextStyle(
        //                         color: Colors.grey,
        //                         fontWeight: FontWeight.w400,
        //                         fontSize: 15,
        //                       ),
        //                       '${article['publishedAt']}')
        //                 ],
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //         separatorBuilder: (context,index)=>myDivider(),
        //         itemCount: list.length),
        //     fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.orange),));
      },
    );
  }
}
