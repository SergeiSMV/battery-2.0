

import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';

simElementsDialog(BuildContext context, String title, List elements){
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context, 
    builder: (context){
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          color: Colors.white
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const SizedBox(height: 20),
            Text(title, style: firm16, textAlign: TextAlign.center,),
            const SizedBox(height: 5),

            Divider(color: firmColor, indent: 30, endIndent: 30,),
            
            Flexible(
              child: Container(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: elements.length,
                  itemBuilder: (contex, index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: ListTile(
                        visualDensity: const VisualDensity(vertical: -3),
                        title: Text(elements[index], textAlign: TextAlign.center, style: firm14),
                        onTap: (){
                          Navigator.pop(context, elements[index]);
                        },
                      ),
                    );
                  }
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }
  );
}