// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// import '../../../../data/bloc/logistic/sim_items_bloc.dart';
// import '../../../../data/providers/logistic/sim/sim_items_provider.dart';
// import '../../../widgets/app_colors.dart';
// import '../../../widgets/app_text_styles.dart';

// class SimSearch extends ConsumerStatefulWidget {
//   const SimSearch({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _SimSearchState();
// }

// class _SimSearchState extends ConsumerState<SimSearch> {
//   final TextEditingController searchController = TextEditingController();
//   String result = '';

//   @override
//   void dispose(){
//     searchController.clear();
//     searchController.dispose();
//     super.dispose();
//   }



//   @override
//   Widget build(BuildContext context) {
    
//     // ignore: unused_local_variable
//     final allSimItems = ref.watch(simItemsProvider);

//     return BlocProvider<SimItemsBloc>(
//       create: (context) => SimItemsBloc(),
//       child: Builder(
//         builder: (context) {

//           bool keyboard = MediaQuery.of(context).viewInsets.bottom > 100 ? true : false;
//           double imageSize = keyboard ? 8.0 : 4.0;

//           return Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
//               ),
//               iconTheme: IconThemeData(color: firmColor),
//               backgroundColor: Colors.green.shade100,
//               title: Text('поиск на складе СиМ', style: firm14,),
//             ),
//             body: Stack(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: const AssetImage('lib/images/tunglogo.png'), 
//                       opacity: 0.2, 
//                       scale: imageSize, 
//                       alignment: const Alignment(0, -0.7),
//                     )
//                   ),
//                 ),
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 15, right: 15),
//                     child: TextField(
//                       autofocus: true,
//                       controller: searchController,
//                       style: const TextStyle(fontSize: 15, color: Color(0xFF095D82), overflow: TextOverflow.ellipsis),
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: 'поиск',
//                         contentPadding: const EdgeInsets.only(bottom: 15.0, left: 25),
//                         isDense: true,
//                         hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
//                         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: firmColor.withOpacity(0.8), width: 3,), borderRadius: const BorderRadius.all(Radius.circular(20.0))),
//                         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: firmColor.withOpacity(0.8), width: 2,), borderRadius: const BorderRadius.all(Radius.circular(20.0))),
//                         prefixIcon: Icon(MdiIcons.magnify, size: 25, color: firmColor,),
//                         suffixIcon: searchController.text.isEmpty ? const SizedBox.shrink() :
//                           IconButton(splashRadius: 20, onPressed: (){ 
//                             // context.read<AllItemsBloc>().add(SimStorageClearSearchEvent());
//                             searchController.clear(); 
//                             setState(() {});
//                           }, icon: const Icon(Icons.clear, color: Color(0xFF095D82)))
//                       ),
                  
//                     ),
//                   ),
//                 )


//               ],
//             ),
//           );
//         }
//       ),
//     );
//   }
// }
