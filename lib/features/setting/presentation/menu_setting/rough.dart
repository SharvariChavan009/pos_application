// import 'package:flutter/material.dart';
// import 'package:pos_application/core/common/colors.dart';
// import 'package:pos_application/core/common/label.dart';
//
// class DiscountGrid extends StatelessWidget {
//   const DiscountGrid({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 3.2,
//       ),
//       itemCount: 10, // Change this according to your data
//       itemBuilder: (context, index) {
//         return const DiscountCard();
//       },
//     );
//   }
// }
//
// class DiscountCard extends StatefulWidget {
//   const DiscountCard({super.key});
//
//   @override
//   State<DiscountCard> createState() => _DiscountCardState();
// }
//
// class _DiscountCardState extends State<DiscountCard> {
//   bool value = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.darkColor.withOpacity(1),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       margin: const EdgeInsets.all(8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               const Text(
//                 'Women\'s Day Special Discount',
//                 style: TextStyle(
//                     fontSize: 14,
//                     fontFamily: CustomLabels.primaryFont,
//                     color: AppColors.whiteColor,
//                     fontWeight: FontWeight.bold),
//               ),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: 'Discount:',
//                       style: CustomLabels.body1TextStyle(
//                           fontFamily: CustomLabels.primaryFont,
//                           color: AppColors.iconColor,
//                           letterSpacing: 0,
//                           fontSize: 13),
//                     ),
//                     const TextSpan(text: '    '),
//                     TextSpan(
//                       text: '20%',
//                       style: CustomLabels.body1TextStyle(
//                           fontFamily: CustomLabels.primaryFont,
//                           letterSpacing: 0,
//                           fontSize: 13),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const Spacer(),
//           Container(
//             decoration: const BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 const Text(
//                   'Active',
//                   style: TextStyle(
//                       color: AppColors.whiteColor,
//                       fontFamily: CustomLabels.primaryFont,
//                       fontSize: 14),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Transform.scale(
//                   scale: .8,
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         value = !value;
//                       });
//                     },
//                     child: Switch.adaptive(
//                       value: value,
//                       inactiveThumbColor: AppColors.iconColor,
//                       activeColor: AppColors.secondaryColor,
//                       inactiveTrackColor: AppColors.primaryColor,
//                       onChanged: null,
//                     ),
//                   ),
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   icon: const Icon(
//                     Icons.edit,
//                     color: AppColors.secondaryColor,
//                   ),
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => const EditDiscountDialog(),
//                     );
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.delete_forever,
//                     color: AppColors.errorColor.withOpacity(.6),
//                   ),
//                   onPressed: () {
//                     // Show delete discount dialog
//                     showDialog(
//                       context: context,
//                       builder: (context) => const DeleteDiscountDialog(),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ItemSelectionDialog extends StatefulWidget {
//   final List<String> allItems;
//
//   const ItemSelectionDialog({super.key, required this.allItems});
//
//   @override
//   _ItemSelectionDialogState createState() => _ItemSelectionDialogState();
// }
//
// class _ItemSelectionDialogState extends State<ItemSelectionDialog> {
//   List<String> selectedItems = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Select Items'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const TextField(
//             decoration: InputDecoration(
//               labelText: 'Search',
//               prefixIcon: Icon(Icons.search),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.allItems.length,
//               itemBuilder: (context, index) {
//                 final item = widget.allItems[index];
//                 return ListTile(
//                   title: Text(item),
//                   onTap: () {
//                     setState(() {
//                       if (selectedItems.contains(item)) {
//                         selectedItems.remove(item);
//                       } else {
//                         selectedItems.add(item);
//                       }
//                     });
//                   },
//                   trailing: selectedItems.contains(item)
//                       ? const Icon(Icons.check_box)
//                       : const Icon(Icons.check_box_outline_blank),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context, selectedItems);
//           },
//           child: const Text('Done'),
//         ),
//       ],
//     );
//   }
// }
//
// class DeleteDiscountDialog extends StatelessWidget {
//   const DeleteDiscountDialog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Delete Discount?'),
//       content: const Text('Are you sure you want to delete this discount?'),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context); // Close the dialog
//           },
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () {
//             // Perform delete action
//             Navigator.pop(context); // Close the dialog
//           },
//           child: const Text('Delete'),
//         ),
//       ],
//     );
//   }
// }
//
// class EditDiscountDialog extends StatefulWidget {
//   const EditDiscountDialog({super.key});
//
//   @override
//   _EditDiscountDialogState createState() => _EditDiscountDialogState();
// }
//
// class _EditDiscountDialogState extends State<EditDiscountDialog> {
//   DateTime? _startDate;
//   DateTime? _endDate;
//
//   Future<void> _selectDate(BuildContext context, bool isStartDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStartDate) {
//           _startDate = picked;
//         } else {
//           _endDate = picked;
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Edit Discount'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const TextField(
//             decoration: InputDecoration(labelText: 'Discount Name'),
//           ),
//           const TextField(
//             decoration: InputDecoration(labelText: 'Percentage'),
//           ),
//           Row(
//             children: [
//               const Text('Start Date: '),
//               if (_startDate != null)
//                 Text(_startDate!.toString())
//               else
//                 TextButton(
//                   onPressed: () => _selectDate(context, true),
//                   child: const Text('Select Date'),
//                 ),
//             ],
//           ),
//           Row(
//             children: [
//               const Text('End Date: '),
//               if (_endDate != null)
//                 Text(_endDate!.toString())
//               else
//                 TextButton(
//                   onPressed: () => _selectDate(context, false),
//                   child: const Text('Select Date'),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context); // Close the dialog
//             },
//             child: const Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
// }
