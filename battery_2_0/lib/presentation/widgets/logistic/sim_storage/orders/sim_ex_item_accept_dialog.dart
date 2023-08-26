import 'package:flutter/material.dart';
import '../../../app_text_styles.dart';


simExItemAcceptDialog(BuildContext mainContext, Map item){
  return showDialog(
    context: mainContext,
    builder: (context) {

      return AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text('Принять ${item['category']} ${item['name']} ${item['color']}', textAlign: TextAlign.center, style: firm14),
            Text('в количестве ${item['fact_quant']} ${item['unit']}?', textAlign: TextAlign.center, style: firm14),
            const SizedBox(height: 10),
            Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  // Map acceptData = {'data': item, 'author': author};
                  Navigator.pop(context, 'yes');
                }, child: Text('принять', textAlign: TextAlign.center, style: firm12)),
                const SizedBox(width: 10),
                TextButton(onPressed: (){ 
                  Navigator.pop(context, 'no'); 
                }, child: Text('отмена', textAlign: TextAlign.center, style: firm12))
              ],
            )),
          ],
        ),
      );
    });
}