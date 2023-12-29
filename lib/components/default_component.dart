import 'package:flutter/material.dart';
import '../cubit/cubit.dart';

Widget defaultButton ({
  double width = double.infinity,
  Color background = Colors.blue,
  required void Function()? todofunction,
  required String text,
  bool isUpperCase = true,
}) =>  Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed: todofunction,
    child:  Text(
      isUpperCase ? text.toUpperCase(): text,
      style: const TextStyle(
        color: Colors.white,
      ),
      
    ),
  ),
);

Widget defaultFormField ({

  required TextEditingController controller,
  required TextInputType  type,
  void  Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  required String label,
  bool isClickable = true,
  IconData? prefix,
  IconData? suffix,
  required   dynamic  validate,
  bool isPassword = false,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  obscureText: isPassword,
  enabled: isClickable,
  onTap : onTap,
  validator: validate,
  decoration:  InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),

    suffixIcon:Icon(suffix),
    border: const OutlineInputBorder(),
  ),
);

Widget buildTaskItem(Map model , context) =>  Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child:  Row(
  
      children: [
  
        CircleAvatar(
  
          backgroundColor: Colors.black45,
  
          radius: 40.0,
  
          child: Text(
  
              '${model['time']}',
  
          ),
  
  
  
  
  
  
  
        ),
  
        const SizedBox(
  
          width: 5,
  
  
  
        ),
  
        Expanded(
  
          child: Column(
  
            crossAxisAlignment: CrossAxisAlignment.start ,
  
            mainAxisSize: MainAxisSize.min,
  
            children: [
  
  
  
              Text(
  
          '${model['title']}',
  
                style: const TextStyle(
  
                  fontSize: 18.0,
  
                  fontWeight: FontWeight.bold,
  
  
  
                ),
  
  
  
              ),
  
              Text(
  
                '${model['date']}',
  
  
  
                style: const TextStyle(
  
                  fontSize: 15.0,
  
                  color: Colors.grey,
  
  
  
                ),
  
  
  
              ),
  
  
  
            ],
  
  
  
          ),
  
        ),
  
        const SizedBox(
  
          width: 5,
  
  
  
        ),
  
        IconButton(onPressed: ()
  
        {
  
          AppCubit.get(context).updateData(status: 'done', id: model['id']);
  
        },
  
            icon: const Icon(
  
                Icons.check_box,
  
              color: Colors.teal,
  
            )),
  
        IconButton(onPressed: ()
  
        {
  
          AppCubit.get(context).updateData(status: 'archived', id: model['id']);
  
        },
  
            icon: const Icon(
  
  
  
                Icons.archive,
  
              color: Colors.blueGrey,
  
            )
  
  
  
        ),
  
  
  
      ],
  
  
  
  
  
  
  
    ),
  
  ),
  onDismissed: (direction){
AppCubit.get(context).deleteData(id:model['id'] );

  },
);

