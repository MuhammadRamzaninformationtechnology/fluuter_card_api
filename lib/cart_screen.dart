import 'package:cart_api/Cart_model.dart';
import 'package:cart_api/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart'as badge;




class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart =  Provider.of<CartProvider>(context);
    return Scaffold(
      appBar:  AppBar(
        title: const Center(
            child: Text('My Product')),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: badge.Badge(

              badgeContent:Consumer<CartProvider>(
                builder: (context, value, child){
                  return Text(value.getCounter().toString(),style:TextStyle(color:Colors.white),);
                },

              ),
              child:Icon(Icons.shopping_bag_outlined),
            ),
          ),



          SizedBox(width: 25.0),
        ],

      ),
      body: Column(
       children: [
         FutureBuilder(
           future: cart.getData(),
             builder: (context ,AsyncSnapshot<List<Cart>> snapshot){
             if(snapshot.hasData) {
               return Expanded(
                 child: ListView.builder(
                   itemCount: snapshot.data!.length,
                   itemBuilder: (context, index) {
                     return Card(
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisSize: MainAxisSize.max,
                               children: [
                                 Image(
                                     height: 100,
                                     width: 100,
                                     image:
                                     NetworkImage(snapshot.data![index].image
                                         .toString())),
                                 const SizedBox(
                                   width: 10,
                                 ),
                                 Expanded(
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment
                                         .start,
                                     children: [
                                       Text(
                                         snapshot.data![index].productName
                                             .toString(),
                                         style: const TextStyle(
                                             fontSize: 16,
                                             fontWeight: FontWeight.w600),
                                       ),
                                       const SizedBox(
                                         height: 5,
                                       ),
                                       Text(
                                         snapshot.data![index].unitTag
                                             .toString() +
                                             " " +
                                             r"$" +
                                             snapshot.data![index].productPrice
                                                 .toString(),
                                         style: const TextStyle(
                                             fontSize: 16,
                                             fontWeight: FontWeight.w600),
                                       ),
                                       SizedBox(
                                         height: 5,
                                       ),
                                       Align(
                                         alignment: Alignment.centerRight,
                                         child: InkWell(
                                           onTap: () {

                                           },
                                           child: Container(
                                             height: 35,
                                             width: 100,
                                             decoration: BoxDecoration(
                                               color: Colors.green,
                                               borderRadius: BorderRadius
                                                   .circular(8),
                                             ),
                                             child: const Center(
                                               child: Text(
                                                 'Add To Card',
                                                 style: TextStyle(
                                                     fontSize: 12,
                                                     fontWeight: FontWeight
                                                         .w500,
                                                     color: Colors.white),
                                               ),
                                             ),
                                           ),
                                         ),
                                       )
                                     ],
                                   ),
                                 )
                               ],
                             )
                           ],
                         ),
                       ),
                     );
                   },
                 ),
               );
             }else{
               return Text('');
             }

             })
       ],
      ),
    );
  }
}
