import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/component/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: defaultTextForm(
                   onChange: (value){
                     NewsCubit.get(context).getsearch(value!);
                   },
                  controller: searchController,
                  label: 'search',
                  hintText: 'type here',
                  type: TextInputType.text,
                  isPassword: false,
                  prefixicon: CupertinoIcons.search,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return ' search must no be null';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Expanded(
                  child:
                  buildArticleItem(
                      list,
                      context,
                  isSearch: true)
              ),


            ],

          ),


        );
      },
    );
  }
}
