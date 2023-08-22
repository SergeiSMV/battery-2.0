import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../data/departments/logistic/sim_items_impl.dart';
import '../../../../../domain/models/accesses/accesses.dart';

Widget simItemImage(BuildContext motherContext, Accesses? allAccesses, List imageLinks, Map itemData, Function refresh){

  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: CarouselSlider.builder(
      itemCount: imageLinks.length, 
      options: CarouselOptions(
        reverse: true,
        enableInfiniteScroll: imageLinks.length == 1 ? false : true,
        autoPlay: false,
        enlargeCenterPage: true,
      ),
      itemBuilder: (BuildContext context, int index, int pageViewIndex){
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Stack(
            children: [
              
              GestureDetector(
                child: SizedBox(height: 300, width: 1000, child: Image.network(imageLinks[index], fit: BoxFit.cover, width: 1000.0)),
                onTap: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemImagesFullScreen(imageUrl: imageLinks[index].toString(),)));
                },
              ),
              
              SimItemsImpl().imageDeleteButton(allAccesses) ? 
              Positioned(
                right: 20,
                top: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.red, 
                  radius: 20, 
                  child: IconButton(
                    onPressed: () async {
                      ProgressHUD.of(motherContext)?.showWithText('удаляем фото');
                      String delLink = imageLinks[index];
                      await SimItemsImpl().deletePhoto(itemData, delLink).then((value) {
                        ProgressHUD.of(motherContext)?.dismiss();
                        value == 'done' ? refresh() : null;
                      });
                    }, 
                    icon: Icon(MdiIcons.delete, color: Colors.white, size: 25,),
                  )
                )
              ) : const SizedBox.shrink()

            ],
          ));
        },
    )
  );

}