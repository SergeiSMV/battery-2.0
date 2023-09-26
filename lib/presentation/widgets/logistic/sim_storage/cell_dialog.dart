import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';


String funcDescription = 'Выберите ячейку или зону, где будет хранится ТМЦ, из доступных ниже';

cellDialog(BuildContext motherContext, List cells) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: motherContext,
    builder: (context) {
      
      final List markers = [];
      List cellsDisplay = cells.length > 30 ? cells.where((cell) => cell.contains(cells[0][0])).toList() : cells;

      return StatefulBuilder(
          builder: (context, setState) {
          
          for (var ch in cells) {
            List marker = ch.split('-');
            marker.length > 2 ? markers.contains(marker[0]) ? null : markers.add(marker[0]) : markers.add(ch);
          }

          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)), color: Colors.white),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(funcDescription, style: firm14, textAlign: TextAlign.center),
                  ),

                  const SizedBox(height: 20),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Container(
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
                        child: Center(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 100,
                              childAspectRatio: 4 / 2,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2
                            ),
                            itemCount: cellsDisplay.length,
                            itemBuilder: (contex, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5.0)), color: Colors.green.shade50),
                                  child: ListTile(
                                    visualDensity: const VisualDensity(vertical: -4),
                                    title: Text(cellsDisplay[index], textAlign: TextAlign.center, style: TextStyle(color: firmColor, fontSize: 12)),
                                    onTap: () {
                                      Navigator.pop(context, cellsDisplay[index]);
                                    },
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    ),
                  ),

                  Divider(indent: 10, endIndent: 15, thickness: 1.0, color: firmColor.withOpacity(0.4),),
                  
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 15),
                    child: cells.length > 30 ? 
                      Center(child: Text('выбрать ряд',style: firm14))
                      : const SizedBox.shrink()
                  ),
                  
                  const SizedBox(height: 10),
                  cells.length > 30 ? 
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        height: 30,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children:
                            List.generate(markers.length, (int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5.0)), color: Colors.blue.shade400),
                                  constraints: const BoxConstraints(maxWidth: 100),
                                  child: TextButton(
                                    onPressed: () {
                                      markers[index].length == 1 ? 
                                      setState(() { cellsDisplay = cells.where((cell) => cell.contains(markers[index])).toList(); }) 
                                      : Navigator.pop(context, markers[index]);
                                    },
                                    child: Text(markers[index], style: const TextStyle(fontSize: 12, color: Colors.white))
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    )
                    : const SizedBox.shrink(),
                
                  const SizedBox(height: 10),
                ],
              )
            ),
          );
        }
      );
    }
  );
}
