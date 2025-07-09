// // // wp.dart:

// // import 'package:flutter/material.dart';
// // import 'package:fl_chart/fl_chart.dart';

// // class WhatsAppInsightsPage extends StatefulWidget {
// //   final int timeUsed; // Time used in minutes
  
// //   const WhatsAppInsightsPage({
// //     Key? key, 
// //     required this.timeUsed,
// //   }) : super(key: key);

// //   @override
// //   _WhatsAppInsightsPageState createState() => _WhatsAppInsightsPageState();
// // }

// // class _WhatsAppInsightsPageState extends State<WhatsAppInsightsPage> {
// //   String selectedTimeframe = 'Week';
// //   final List<String> timeframes = ['Day', 'Week', 'Month'];
  
// //   // Sample hourly usage data for the current day
// //   final List<double> hourlyUsage = [
// //     0.0, 0.0, 0.0, 0.0, 0.0, 0.0, // 12am-6am
// //     0.2, 0.5, 0.8, 0.4, 0.3, 0.6, // 6am-12pm
// //     0.9, 0.7, 0.3, 0.5, 0.8, 1.2, // 12pm-6pm
// //     1.5, 1.0, 0.6, 0.3, 0.1, 0.0  // 6pm-12am
// //   ];
  
// //   // Sample daily usage data for the week
// //   final List<double> dailyUsage = [35, 42, 28, 45, 32, 48, 30];
  
// //   // Sample most messaged contacts
// //   final List<ContactData> topContacts = [
// //     ContactData("Alex Smith", 48, Colors.blue),
// //     ContactData("Work Group", 32, Colors.green),
// //     ContactData("Family Group", 25, Colors.orange),
// //     ContactData("Chris Johnson", 18, Colors.purple),
// //     ContactData("Sarah Wilson", 12, Colors.pink),
// //   ];
  
// //   // Sample chat categories
// //   final List<ChartData> chatCategories = [
// //     ChartData("Personal", 45, Colors.blue),
// //     ChartData("Work", 30, Colors.green),
// //     ChartData("Family", 15, Colors.orange),
// //     ChartData("Other", 10, Colors.purple),
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         title: Text(
// //           "WhatsApp Insights",
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         backgroundColor: Colors.grey[900],
// //         iconTheme: IconThemeData(color: Colors.white),
// //         elevation: 0,
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // App header with icon and usage time
// //               _buildAppHeader(),
// //               SizedBox(height: 24),
              
// //               // Time frame selector
// //               _buildTimeframeSelector(),
// //               SizedBox(height: 24),
              
// //               // Usage chart
// //               _buildUsageChart(),
// //               SizedBox(height: 24),
              
// //               // Stats overview
// //               _buildStatsOverview(),
// //               SizedBox(height: 24),
              
// //               // Top contacts
// //               _buildTopContacts(),
// //               SizedBox(height: 24),
              
// //               // Chat categories
// //               _buildChatCategories(),
// //               SizedBox(height: 24),
              
// //               // Suggested limits
// //               _buildSuggestedLimits(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
  
// //   Widget _buildAppHeader() {
// //     return Container(
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.grey[900],
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Row(
// //         children: [
// //           CircleAvatar(
// //             radius: 30,
// //             backgroundColor: Colors.green.withOpacity(0.2),
// //             child: Icon(
// //               Icons.chat_bubble,
// //               color: Colors.green,
// //               size: 30,
// //             ),
// //           ),
// //           SizedBox(width: 16),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "WhatsApp",
// //                   style: TextStyle(
// //                     fontSize: 22,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 SizedBox(height: 4),
// //                 Text(
// //                   "Social Messaging",
// //                   style: TextStyle(
// //                     fontSize: 14,
// //                     color: Colors.grey[400],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Container(
// //             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //             decoration: BoxDecoration(
// //               color: Colors.green.withOpacity(0.2),
// //               borderRadius: BorderRadius.circular(12),
// //             ),
// //             child: Text(
// //               _formatMinutes(widget.timeUsed),
// //               style: TextStyle(
// //                 color: Colors.green,
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 16,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
  
// //   Widget _buildTimeframeSelector() {
// //     return Container(
// //       height: 40,
// //       child: ListView.builder(
// //         scrollDirection: Axis.horizontal,
// //         itemCount: timeframes.length,
// //         itemBuilder: (context, index) {
// //           final isSelected = timeframes[index] == selectedTimeframe;
// //           return Padding(
// //             padding: const EdgeInsets.only(right: 12),
// //             child: GestureDetector(
// //               onTap: () {
// //                 setState(() {
// //                   selectedTimeframe = timeframes[index];
// //                 });
// //               },
// //               child: Container(
// //                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
// //                 decoration: BoxDecoration(
// //                   color: isSelected ? Colors.green : Colors.grey[900],
// //                   borderRadius: BorderRadius.circular(20),
// //                 ),
// //                 child: Text(
// //                   timeframes[index],
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                     fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
  
// //   Widget _buildUsageChart() {
// //     return Container(
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.grey[900],
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             "Usage Patterns",
// //             style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.white,
// //             ),
// //           ),
// //           SizedBox(height: 8),
// //           Text(
// //             selectedTimeframe == "Day" ? "Hourly usage today" :
// //             selectedTimeframe == "Week" ? "Daily usage this week" : "Weekly usage this month",
// //             style: TextStyle(
// //               fontSize: 14,
// //               color: Colors.grey[400],
// //             ),
// //           ),
// //           SizedBox(height: 16),
// //           SizedBox(
// //             height: 200,
// //             child: BarChart(
// //               BarChartData(
// //                 alignment: BarChartAlignment.spaceAround,
// //                 maxY: selectedTimeframe == "Day" ? 2 : 60,
// //                 barTouchData: BarTouchData(
// //                   enabled: true,
// //                   touchTooltipData: BarTouchTooltipData(
// //                     tooltipBgColor: Colors.grey[800]!,
// //                     getTooltipItem: (group, groupIndex, rod, rodIndex) {
// //                       String label = '';
// //                       double value = 0;
                      
// //                       if (selectedTimeframe == "Day") {
// //                         int hour = group.x.toInt();
// //                         String timeFormat = hour < 12 ? "AM" : "PM";
// //                         int displayHour = hour % 12 == 0 ? 12 : hour % 12;
// //                         label = "$displayHour $timeFormat";
// //                         value = hourlyUsage[hour];
// //                         return BarTooltipItem(
// //                           "$label: ${value.toStringAsFixed(1)} min",
// //                           TextStyle(color: Colors.white),
// //                         );
// //                       } else {
// //                         String day = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][group.x.toInt()];
// //                         value = dailyUsage[group.x.toInt()];
// //                         return BarTooltipItem(
// //                           "$day: ${value.toInt()} min",
// //                           TextStyle(color: Colors.white),
// //                         );
// //                       }
// //                     },
// //                   ),
// //                 ),
// //                 titlesData: FlTitlesData(
// //                   show: true,
// //                   bottomTitles: AxisTitles(
// //                     sideTitles: SideTitles(
// //                       showTitles: true,
// //                       getTitlesWidget: (value, meta) {
// //                         String text;
// //                         if (selectedTimeframe == "Day") {
// //                           // Show fewer hour labels to avoid overcrowding
// //                           if (value % 6 == 0) {
// //                             int hour = value.toInt();
// //                             String timeFormat = hour < 12 ? "AM" : "PM";
// //                             int displayHour = hour % 12 == 0 ? 12 : hour % 12;
// //                             text = "$displayHour$timeFormat";
// //                           } else {
// //                             text = "";
// //                           }
// //                         } else {
// //                           // For week view
// //                           text = ["M", "T", "W", "T", "F", "S", "S"][value.toInt() % 7];
// //                         }
// //                         return Padding(
// //                           padding: const EdgeInsets.only(top: 8.0),
// //                           child: Text(
// //                             text,
// //                             style: TextStyle(color: Colors.white, fontSize: 12),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                   leftTitles: AxisTitles(
// //                     sideTitles: SideTitles(
// //                       showTitles: true,
// //                       reservedSize: 30,
// //                       getTitlesWidget: (value, meta) {
// //                         if (selectedTimeframe == "Day") {
// //                           if (value % 0.5 == 0) {
// //                             return Text(
// //                               "${value.toInt()}m",
// //                               style: TextStyle(color: Colors.white, fontSize: 10),
// //                             );
// //                           }
// //                         } else {
// //                           if (value % 15 == 0) {
// //                             return Text(
// //                               "${value.toInt()}m",
// //                               style: TextStyle(color: Colors.white, fontSize: 10),
// //                             );
// //                           }
// //                         }
// //                         return Text('');
// //                       },
// //                     ),
// //                   ),
// //                   topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
// //                   rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
// //                 ),
// //                 gridData: FlGridData(
// //                   show: true,
// //                   drawVerticalLine: false,
// //                   getDrawingHorizontalLine: (value) {
// //                     return FlLine(
// //                       color: Colors.grey[800]!,
// //                       strokeWidth: 1,
// //                     );
// //                   },
// //                 ),
// //                 borderData: FlBorderData(show: false),
// //                 barGroups: selectedTimeframe == "Day" 
// //                   ? hourlyUsage.asMap().entries.map((entry) {
// //                       return BarChartGroupData(
// //                         x: entry.key,
// //                         barRods: [
// //                           BarChartRodData(
// //                             toY: entry.value,
// //                             color: Colors.green,
// //                             width: 8,
// //                             borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
// //                           ),
// //                         ],
// //                       );
// //                     }).toList()
// //                   : dailyUsage.asMap().entries.map((entry) {
// //                       return BarChartGroupData(
// //                         x: entry.key,
// //                         barRods: [
// //                           BarChartRodData(
// //                             toY: entry.value,
// //                             color: Colors.green,
// //                             width: 12,
// //                             borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
// //                           ),
// //                         ],
// //                       );
// //                     }).toList(),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
  
// //   Widget _buildStatsOverview() {
// //     return Container(
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.grey[900],
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             "Stats Overview",
// //             style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.white,
// //             ),
// //           ),
// //           SizedBox(height: 16),
// //           Row(
// //             children: [
// //               _buildStatCard("Messages Sent", "248", Icons.send, Colors.blue),
// //               SizedBox(width: 12),
// //               _buildStatCard("Messages Received", "326", Icons.message, Colors.green),
// //             ],
// //           ),
// //           SizedBox(height: 12),
// //           Row(
// //             children: [
// //               _buildStatCard("Media Shared", "18", Icons.image, Colors.purple),
// //               SizedBox(width: 12),
// //               _buildStatCard("Voice Messages", "5", Icons.mic, Colors.orange),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
  
// //   Widget _buildStatCard(String title, String value, IconData icon, Color color) {
// //     return Expanded(
// //       child: Container(
// //         padding: EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           color: Colors.grey[800],
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               children: [
// //                 Icon(icon, color: color, size: 18),
// //                 SizedBox(width: 8),
// //                 Text(
// //                   title,
// //                   style: TextStyle(
// //                     fontSize: 12,
// //                     color: Colors.grey[400],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 8),
// //             Text(
// //               value,
// //               style: TextStyle(
// //                 fontSize: 20,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.white,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
  
// //   Widget _buildTopContacts() {
// //     return Container(
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.grey[900],
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             "Most Messaged Contacts",
// //             style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.white,
// //             ),
// //           ),
// //           SizedBox(height: 16),
// //           ...topContacts.map((contact) => _buildContactItem(contact)).toList(),
// //         ],
// //       ),
// //     );
// //   }
  
// //   Widget _buildContactItem(ContactData contact) {
// //     // Calculate percentage based on highest contact (which is the first one)
// //     double percentage = contact.messageCount / topContacts.first.messageCount;
    
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 12),
// //       child: Row(
// //         children: [
// //           CircleAvatar(
// //             radius: 18,
// //             backgroundColor: contact.color.withOpacity(0.2),
// //             child: Text(
// //               contact.name[0],
// //               style: TextStyle(
// //                 color: contact.color,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //           SizedBox(width: 12),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   contact.name,
// //                   style: TextStyle(
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 SizedBox(height: 6),
// //                 Stack(
// //                   children: [
// //                     Container(
// //                       height: 6,
// //                       decoration: BoxDecoration(
// //                         color: Colors.grey[800],
// //                         borderRadius: BorderRadius.circular(3),
// //                       ),
// //                     ),
// //                     FractionallySizedBox(
// //                       widthFactor: percentage,
// //                       child: Container(
// //                         height: 6,
// //                         decoration: BoxDecoration(
// //                           color: contact.color,
// //                           borderRadius: BorderRadius.circular(3),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(width: 12),
// //           Text(
// //             "${contact.messageCount} msgs",
// //             style: TextStyle(
// //               fontSize: 14,
// //               color: Colors.white,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
  
// //   Widget _buildChatCategories() {
// //     return Container(
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.grey[900],
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             "Chat Categories",
// //             style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.white,
// //             ),
// //           ),
// //           SizedBox(height: 16),
// //           SizedBox(
// //             height: 180,
// //             child: PieChart(
// //               PieChartData(
// //                 sectionsSpace: 4,
// //                 centerSpaceRadius: 40,
// //                 sections: chatCategories.map((item) {
// //                   return PieChartSectionData(
// //                     color: item.color,
// //                     value: item.value,
// //                     title: "${item.value.toInt()}%",
// //                     radius: 80,
// //                     titleStyle: TextStyle(
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white,
// //                     ),
// //                   );
// //                 }).toList(),
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: 16),
// //           Wrap(
// //             spacing: 16,
// //             runSpacing: 12,
// //             children: chatCategories.map((item) {
// //               return Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Container(
// //                     width: 12,
// //                     height: 12,
// //                     decoration: BoxDecoration(
// //                       color: item.color,
// //                       shape: BoxShape.circle,
// //                     ),
// //                   ),
// //                   SizedBox(width: 6),
// //                   Text(
// //                     item.name,
// //                     style: TextStyle(
// //                       fontSize: 14,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                 ],
// //               );
// //             }).toList(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
  
// //   Widget _buildSuggestedLimits() {
// //     return Container(
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.grey[900],
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             "Suggested Time Limits",
// //             style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.white,
// //             ),
// //           ),
// //           SizedBox(height: 16),
// //           _buildLimitOption("Healthy Limit", "30 min", true),
// //           SizedBox(height: 12),
// //           _buildLimitOption("Moderate Limit", "45 min", false),
// //           SizedBox(height: 12),
// //           _buildLimitOption("Custom Limit", widget.timeUsed > 45 ? "${widget.timeUsed} min" : "60 min", false),
// //         ],
// //       ),
// //     );
// //   }
  
// //   Widget _buildLimitOption(String title, String time, bool recommended) {
// //     return Container(
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: recommended ? Colors.green.withOpacity(0.2) : Colors.grey[800],
// //         borderRadius: BorderRadius.circular(12),
// //         border: recommended ? Border.all(color: Colors.green, width: 1) : null,
// //       ),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   title,
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 if (recommended)
// //                   Padding(
// //                     padding: const EdgeInsets.only(top: 4),
// //                     child: Text(
// //                       "Recommended",
// //                       style: TextStyle(
// //                         fontSize: 12,
// //                         color: Colors.green,
// //                       ),
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ),
// //           Text(
// //             time,
// //             style: TextStyle(
// //               fontSize: 16,
// //               fontWeight: FontWeight.bold,
// //               color: recommended ? Colors.green : Colors.white,
// //             ),
// //           ),
// //           SizedBox(width: 12),
// //           Icon(
// //             recommended ? Icons.check_circle : Icons.radio_button_unchecked,
// //             color: recommended ? Colors.green : Colors.grey,
// //             size: 22,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
  
// //   String _formatMinutes(int minutes) {
// //     int hours = minutes ~/ 60;
// //     int remainingMinutes = minutes % 60;

// //     if (hours > 0) {
// //       return "$hours h $remainingMinutes min";
// //     } else {
// //       return "$minutes min";
// //     }
// //   }
// // }

// // class ContactData {
// //   final String name;
// //   final int messageCount;
// //   final Color color;
  
// //   ContactData(this.name, this.messageCount, this.color);
// // }

// // class ChartData {
// //   final String name;
// //   final double value;
// //   final Color color;
  
// //   ChartData(this.name, this.value, this.color);
// // }

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class WhatsAppInsightsPage extends StatefulWidget {
//   final int timeUsed; // Time used in minutes
  
//   const WhatsAppInsightsPage({
//     Key? key, 
//     required this.timeUsed,
//   }) : super(key: key);

//   @override
//   _WhatsAppInsightsPageState createState() => _WhatsAppInsightsPageState();
// }

// class _WhatsAppInsightsPageState extends State<WhatsAppInsightsPage> {
//   String selectedTimeframe = 'Week';
//   final List<String> timeframes = ['Day', 'Week', 'Month'];
  
//   // Sample hourly usage data for the current day
//   final List<double> hourlyUsage = [
//     0.0, 0.0, 0.0, 0.0, 0.0, 0.0, // 12am-6am
//     0.2, 0.5, 0.8, 0.4, 0.3, 0.6, // 6am-12pm
//     0.9, 0.7, 0.3, 0.5, 0.8, 1.2, // 12pm-6pm
//     1.5, 1.0, 0.6, 0.3, 0.1, 0.0  // 6pm-12am
//   ];
  
//   // Sample daily usage data for the week
//   final List<double> dailyUsage = [35, 42, 28, 45, 32, 48, 30];
  
//   // Sample chat categories
//   final List<ChartData> chatCategories = [
//     ChartData("Personal", 45, Colors.blue),
//     ChartData("Work", 30, Colors.green),
//     ChartData("Family", 15, Colors.orange),
//     ChartData("Other", 10, Colors.purple),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           "WhatsApp Insights",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.grey[900],
//         iconTheme: IconThemeData(color: Colors.white),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // App header with icon and usage time
//               _buildAppHeader(),
//               SizedBox(height: 24),
              
//               // Time frame selector
//               _buildTimeframeSelector(),
//               SizedBox(height: 24),
              
//               // Usage chart
//               _buildUsageChart(),
//               SizedBox(height: 24),
              
//               // Chat categories
//               _buildChatCategories(),
//               SizedBox(height: 24),
              
//               // Suggested limits
//               _buildSuggestedLimits(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
  
//   Widget _buildAppHeader() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundColor: Colors.green.withOpacity(0.2),
//             child: Icon(
//               Icons.chat_bubble,
//               color: Colors.green,
//               size: 30,
//             ),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "WhatsApp",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Social Messaging",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[400],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.green.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               _formatMinutes(widget.timeUsed),
//               style: TextStyle(
//                 color: Colors.green,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildTimeframeSelector() {
//     return Container(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: timeframes.length,
//         itemBuilder: (context, index) {
//           final isSelected = timeframes[index] == selectedTimeframe;
//           return Padding(
//             padding: const EdgeInsets.only(right: 12),
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedTimeframe = timeframes[index];
//                 });
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.green : Colors.grey[900],
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   timeframes[index],
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
  
//   Widget _buildUsageChart() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Usage Patterns",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             selectedTimeframe == "Day" ? "Hourly usage today" :
//             selectedTimeframe == "Week" ? "Daily usage this week" : "Weekly usage this month",
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[400],
//             ),
//           ),
//           SizedBox(height: 16),
//           SizedBox(
//             height: 200,
//             child: BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.spaceAround,
//                 maxY: selectedTimeframe == "Day" ? 2 : 60,
//                 barTouchData: BarTouchData(
//                   enabled: true,
//                   touchTooltipData: BarTouchTooltipData(
//                     tooltipBgColor: Colors.grey[800]!,
//                     getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                       String label = '';
//                       double value = 0;
                      
//                       if (selectedTimeframe == "Day") {
//                         int hour = group.x.toInt();
//                         String timeFormat = hour < 12 ? "AM" : "PM";
//                         int displayHour = hour % 12 == 0 ? 12 : hour % 12;
//                         label = "$displayHour $timeFormat";
//                         value = hourlyUsage[hour];
//                         return BarTooltipItem(
//                           "$label: ${value.toStringAsFixed(1)} min",
//                           TextStyle(color: Colors.white),
//                         );
//                       } else {
//                         String day = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][group.x.toInt()];
//                         value = dailyUsage[group.x.toInt()];
//                         return BarTooltipItem(
//                           "$day: ${value.toInt()} min",
//                           TextStyle(color: Colors.white),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         String text;
//                         if (selectedTimeframe == "Day") {
//                           // Show fewer hour labels to avoid overcrowding
//                           if (value % 6 == 0) {
//                             int hour = value.toInt();
//                             String timeFormat = hour < 12 ? "AM" : "PM";
//                             int displayHour = hour % 12 == 0 ? 12 : hour % 12;
//                             text = "$displayHour$timeFormat";
//                           } else {
//                             text = "";
//                           }
//                         } else {
//                           // For week view
//                           text = ["M", "T", "W", "T", "F", "S", "S"][value.toInt() % 7];
//                         }
//                         return Padding(
//                           padding: const EdgeInsets.only(top: 8.0),
//                           child: Text(
//                             text,
//                             style: TextStyle(color: Colors.white, fontSize: 12),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 30,
//                       getTitlesWidget: (value, meta) {
//                         if (selectedTimeframe == "Day") {
//                           if (value % 0.5 == 0) {
//                             return Text(
//                               "${value.toInt()}m",
//                               style: TextStyle(color: Colors.white, fontSize: 10),
//                             );
//                           }
//                         } else {
//                           if (value % 15 == 0) {
//                             return Text(
//                               "${value.toInt()}m",
//                               style: TextStyle(color: Colors.white, fontSize: 10),
//                             );
//                           }
//                         }
//                         return Text('');
//                       },
//                     ),
//                   ),
//                   topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 ),
//                 gridData: FlGridData(
//                   show: true,
//                   drawVerticalLine: false,
//                   getDrawingHorizontalLine: (value) {
//                     return FlLine(
//                       color: Colors.grey[800]!,
//                       strokeWidth: 1,
//                     );
//                   },
//                 ),
//                 borderData: FlBorderData(show: false),
//                 barGroups: selectedTimeframe == "Day" 
//                   ? hourlyUsage.asMap().entries.map((entry) {
//                       return BarChartGroupData(
//                         x: entry.key,
//                         barRods: [
//                           BarChartRodData(
//                             toY: entry.value,
//                             color: Colors.green,
//                             width: 8,
//                             borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
//                           ),
//                         ],
//                       );
//                     }).toList()
//                   : dailyUsage.asMap().entries.map((entry) {
//                       return BarChartGroupData(
//                         x: entry.key,
//                         barRods: [
//                           BarChartRodData(
//                             toY: entry.value,
//                             color: Colors.green,
//                             width: 12,
//                             borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
//                           ),
//                         ],
//                       );
//                     }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildChatCategories() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Usage Categories",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 16),
//           SizedBox(
//             height: 180,
//             child: PieChart(
//               PieChartData(
//                 sectionsSpace: 4,
//                 centerSpaceRadius: 40,
//                 sections: chatCategories.map((item) {
//                   return PieChartSectionData(
//                     color: item.color,
//                     value: item.value,
//                     title: "${item.value.toInt()}%",
//                     radius: 80,
//                     titleStyle: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           Wrap(
//             spacing: 16,
//             runSpacing: 12,
//             children: chatCategories.map((item) {
//               return Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     width: 12,
//                     height: 12,
//                     decoration: BoxDecoration(
//                       color: item.color,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   SizedBox(width: 6),
//                   Text(
//                     item.name,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildSuggestedLimits() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Suggested Time Limits",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 16),
//           _buildLimitOption("Healthy Limit", "30 min", true),
//           SizedBox(height: 12),
//           _buildLimitOption("Moderate Limit", "45 min", false),
//           SizedBox(height: 12),
//           _buildLimitOption("Custom Limit", widget.timeUsed > 45 ? "${widget.timeUsed} min" : "60 min", false),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildLimitOption(String title, String time, bool recommended) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: recommended ? Colors.green.withOpacity(0.2) : Colors.grey[800],
//         borderRadius: BorderRadius.circular(12),
//         border: recommended ? Border.all(color: Colors.green, width: 1) : null,
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 if (recommended)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 4),
//                     child: Text(
//                       "Recommended",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           Text(
//             time,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: recommended ? Colors.green : Colors.white,
//             ),
//           ),
//           SizedBox(width: 12),
//           Icon(
//             recommended ? Icons.check_circle : Icons.radio_button_unchecked,
//             color: recommended ? Colors.green : Colors.grey,
//             size: 22,
//           ),
//         ],
//       ),
//     );
//   }
  
//   String _formatMinutes(int minutes) {
//     int hours = minutes ~/ 60;
//     int remainingMinutes = minutes % 60;

//     if (hours > 0) {
//       return "$hours h $remainingMinutes min";
//     } else {
//       return "$minutes min";
//     }
//   }
// }

// class ChartData {
//   final String name;
//   final double value;
//   final Color color;
  
//   ChartData(this.name, this.value, this.color);
// }




//apr3 morning


// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';

// class AppInsightsPage extends StatefulWidget {
//   final String appName;
//   final String appIcon;

//   const AppInsightsPage({
//     Key? key,
//     required this.appName,
//     required this.appIcon,
//   }) : super(key: key);

//   @override
//   _AppInsightsPageState createState() => _AppInsightsPageState();
// }

// class _AppInsightsPageState extends State<AppInsightsPage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
  
//   // Mock data - replace with actual data in your implementation
//   final List<double> weeklyUsage = [1.5, 2.3, 1.8, 3.2, 2.7, 4.1, 3.6];
//   final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//   final int dailyLimit = 180; // 3 hours in minutes
//   final int currentUsage = 142; // in minutes
  
//   // Mock hourly usage data
//   final Map<int, int> hourlyUsage = {
//     7: 12, 8: 25, 9: 18, 12: 15, 13: 20, 17: 30, 18: 25, 19: 15, 22: 7
//   };

//   // Usage spikes data
//   final List<Map<String, dynamic>> usageSpikes = [
//     {'day': 'Monday', 'time': '5:30 PM', 'duration': '45 min'},
//     {'day': 'Wednesday', 'time': '1:15 PM', 'duration': '38 min'},
//     {'day': 'Saturday', 'time': '9:20 PM', 'duration': '62 min'},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(widget.appName),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'Overview'),
//             Tab(text: 'Detailed'),
//             Tab(text: 'Settings'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildOverviewTab(),
//           _buildDetailedTab(),
//           _buildSettingsTab(),
//         ],
//       ),
//     );
//   }

//   Widget _buildOverviewTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildAppHeader(),
//           const SizedBox(height: 24),
//           _buildTodayUsage(),
//           const SizedBox(height: 24),
//           _buildWeeklyChart(),
//           const SizedBox(height: 24),
//           _buildUsagePatterns(),
//         ],
//       ),
//     );
//   }

//   Widget _buildAppHeader() {
//     return Row(
//       children: [
//         Container(
//           width: 60,
//           height: 60,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             image: DecorationImage(
//               image: AssetImage(widget.appIcon),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.appName,
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'Social Media',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTodayUsage() {
//     final double percentage = currentUsage / dailyLimit;
//     final String timeLeft = _formatMinutes(dailyLimit - currentUsage);
    
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Today\'s Usage',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     _formatMinutes(currentUsage),
//                     style: const TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '${(percentage * 100).toInt()}%',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: _getColorForPercentage(percentage),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               LinearProgressIndicator(
//                 value: percentage,
//                 backgroundColor: Colors.grey[200],
//                 valueColor: AlwaysStoppedAnimation<Color>(_getColorForPercentage(percentage)),
//                 minHeight: 8,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Daily limit: ${_formatMinutes(dailyLimit)}',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   Text(
//                     'Time left: $timeLeft',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildWeeklyChart() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Weekly Overview',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           height: 220,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: BarChart(
//             BarChartData(
//               alignment: BarChartAlignment.spaceAround,
//               maxY: 5,
//               barTouchData: BarTouchData(
//                 enabled: true,
//                 touchTooltipData: BarTouchTooltipData(
//                   tooltipBgColor: Colors.blueAccent,
//                   getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                     return BarTooltipItem(
//                       '${weekDays[groupIndex]}: ${rod.toY.toStringAsFixed(1)} hrs',
//                       const TextStyle(color: Colors.white),
//                     );
//                   },
//                 ),
//               ),
//               titlesData: FlTitlesData(
//                 show: true,
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, meta) {
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         child: Text(weekDays[value.toInt()]),
//                       );
//                     },
//                     reservedSize: 30,
//                   ),
//                 ),
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, meta) {
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         child: Text('${value.toInt()} h'),
//                       );
//                     },
//                     reservedSize: 30,
//                   ),
//                 ),
//                 topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               ),
//               borderData: FlBorderData(show: false),
//               gridData: FlGridData(
//                 show: true,
//                 horizontalInterval: 1,
//                 getDrawingHorizontalLine: (value) => FlLine(
//                   color: Colors.grey[300]!,
//                   strokeWidth: 1,
//                 ),
//               ),
//               barGroups: weeklyUsage.asMap().entries.map((entry) {
//                 final int index = entry.key;
//                 final double value = entry.value;
//                 return BarChartGroupData(
//                   x: index,
//                   barRods: [
//                     BarChartRodData(
//                       toY: value,
//                       color: index == weeklyUsage.indexOf(weeklyUsage.reduce((a, b) => a > b ? a : b))
//                           ? Colors.redAccent
//                           : Colors.blueAccent,
//                       width: 22,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ],
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildUsagePatterns() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Usage Insights',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildInsightItem(
//                 icon: Icons.access_time,
//                 title: 'Peak Usage Time',
//                 description: '5 PM - 7 PM',
//               ),
//               const Divider(),
//               _buildInsightItem(
//                 icon: Icons.calendar_today,
//                 title: 'Most Active Day',
//                 description: 'Saturday',
//               ),
//               const Divider(),
//               _buildInsightItem(
//                 icon: Icons.timelapse,
//                 title: 'Average Session',
//                 description: '24 minutes',
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildInsightItem({
//     required IconData icon,
//     required String title,
//     required String description,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(
//               icon,
//               color: Colors.blue,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey,
//                 ),
//               ),
//               Text(
//                 description,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailedTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildHourlyUsageChart(),
//           const SizedBox(height: 24),
//           _buildUsageSpikes(),
//           const SizedBox(height: 24),
//           _buildMonthlyComparison(),
//         ],
//       ),
//     );
//   }

//   Widget _buildHourlyUsageChart() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Hourly Usage Pattern',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           height: 220,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: LineChart(
//             LineChartData(
//               lineTouchData: LineTouchData(
//                 enabled: true,
//                 touchTooltipData: LineTouchTooltipData(
//                   tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
//                   getTooltipItems: (touchedSpots) {
//                     return touchedSpots.map((touchedSpot) {
//                       return LineTooltipItem(
//                         '${touchedSpot.x.toInt()}:00: ${touchedSpot.y.toInt()} min',
//                         const TextStyle(color: Colors.white),
//                       );
//                     }).toList();
//                   },
//                 ),
//               ),
//               gridData: FlGridData(
//                 show: true,
//                 drawVerticalLine: false,
//                 horizontalInterval: 10,
//                 getDrawingHorizontalLine: (value) => FlLine(
//                   color: Colors.grey[300]!,
//                   strokeWidth: 1,
//                 ),
//               ),
//               titlesData: FlTitlesData(
//                 show: true,
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     interval: 3,
//                     getTitlesWidget: (value, meta) {
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         child: Text('${value.toInt()}:00'),
//                       );
//                     },
//                     reservedSize: 30,
//                   ),
//                 ),
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     interval: 10,
//                     getTitlesWidget: (value, meta) {
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         child: Text('${value.toInt()}m'),
//                       );
//                     },
//                     reservedSize: 30,
//                   ),
//                 ),
//                 topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               ),
//               borderData: FlBorderData(show: false),
//               minX: 0,
//               maxX: 24,
//               minY: 0,
//               maxY: 40,
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: _getHourlySpots(),
//                   isCurved: true,
//                   curveSmoothness: 0.3,
//                   color: Colors.blue,
//                   barWidth: 3,
//                   isStrokeCapRound: true,
//                   dotData: FlDotData(
//                     show: true,
//                     getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
//                       radius: 4,
//                       color: Colors.white,
//                       strokeWidth: 2,
//                       strokeColor: Colors.blue,
//                     ),
//                   ),
//                   belowBarData: BarAreaData(
//                     show: true,
//                     color: Colors.blue.withOpacity(0.1),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   List<FlSpot> _getHourlySpots() {
//     List<FlSpot> spots = [];
//     for (int hour = 0; hour < 24; hour++) {
//       spots.add(FlSpot(hour.toDouble(), (hourlyUsage[hour] ?? 0).toDouble()));
//     }
//     return spots;
//   }

//   Widget _buildUsageSpikes() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Usage Spikes',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: usageSpikes.map((spike) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 12.0),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 4,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: Colors.redAccent,
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '${spike['day']} at ${spike['time']}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             'Duration: ${spike['duration']}',
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Icon(
//                       Icons.arrow_forward_ios,
//                       size: 16,
//                       color: Colors.grey,
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMonthlyComparison() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Monthly Comparison',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'This Month',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 14,
//                         ),
//                       ),
//                       const Text(
//                         '45.2 hours',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.red.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Row(
//                       children: const [
//                         Icon(
//                           Icons.arrow_upward,
//                           color: Colors.red,
//                           size: 16,
//                         ),
//                         SizedBox(width: 4),
//                         Text(
//                           '15%',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               LinearProgressIndicator(
//                 value: 0.8,
//                 backgroundColor: Colors.grey[200],
//                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
//                 minHeight: 8,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Last Month',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 14,
//                         ),
//                       ),
//                       const Text(
//                         '39.3 hours',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Monthly Limit',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 14,
//                         ),
//                       ),
//                       const Text(
//                         '56 hours',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSettingsTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildLimitSettings(),
//           const SizedBox(height: 24),
//           _buildNotificationSettings(),
//           const SizedBox(height: 24),
//           _buildFocusModeSettings(),
//         ],
//       ),
//     );
//   }

//   Widget _buildLimitSettings() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Time Limits',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               _buildSettingItem(
//                 title: 'Daily Limit',
//                 value: '3 hours',
//                 onTap: () {},
//               ),
//               const Divider(),
//               _buildSettingItem(
//                 title: 'Weekly Limit',
//                 value: '15 hours',
//                 onTap: () {},
//               ),
//               const Divider(),
//               _buildSettingItem(
//                 title: 'Monthly Limit',
//                 value: '56 hours',
//                 onTap: () {},
//               ),
//               const Divider(),
//               _buildSettingItem(
//                 title: 'Custom Time Frames',
//                 value: '2 active',
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildNotificationSettings() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Notifications',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               SwitchListTile(
//                 title: const Text('Limit Warnings'),
//                 subtitle: const Text('Notify when approaching time limits'),
//                 value: true,
//                 onChanged: (value) {},
//                 contentPadding: EdgeInsets.zero,
//               ),
//               const Divider(),
//               SwitchListTile(
//                 title: const Text('Usage Reports'),
//                 subtitle: const Text('Weekly summary of app usage'),
//                 value: true,
//                 onChanged: (value) {},
//                 contentPadding: EdgeInsets.zero,
//               ),
//               const Divider(),
//               SwitchListTile(
//                 title: const Text('Excessive Usage Alerts'),
//                 subtitle: const Text('Notify when using app for extended periods'),
//                 value: true,
//                 onChanged: (value) {},
//                 contentPadding: EdgeInsets.zero,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFocusModeSettings() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Focus Mode',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SwitchListTile(
//                 title: const Text('Scheduled Focus Times'),
//                 subtitle: const Text('Block app during specific hours'),
//                 value: false,
//                 onChanged: (value) {},
//                 contentPadding: EdgeInsets.zero,
//               ),
//               const Divider(),
//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 title: const Text('Configure Focus Schedule'),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                 onTap: () {},
//               ),
//               const Divider(),
//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 title: const Text('Block App Now'),
//                 trailing: const Icon(Icons.block, color: Colors.red),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSettingItem({
//     required String title,
//     required String value,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       title: Text(title),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             value,
//             style: TextStyle(
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(width: 8),
//           const Icon(Icons.arrow_forward_ios, size: 16),
//         ],
//       ),
//       onTap: onTap,
//     );
//   }

//   String _formatMinutes(int minutes) {
//     final int hours = minutes ~/ 60;
//     final int mins = minutes % 60;
    
//     if (hours > 0) {
//       return '${hours}h ${mins}m';
//     } else {
//       return '${mins}m';
//     }
//   }

//   Color _getColorForPercentage(double percentage) {
//     if (percentage < 0.7) {
//       return Colors.green;
//     } else if (percentage < 0.9) {
//       return Colors.orange;
//     } else {
//       return Colors.red;
//     }
//   }
// }

// // Usage example:
// // Navigator.push(
// //   context,
// //   MaterialPageRoute(
// //     builder: (context) => AppInsightsPage(
// //       appName: 'Instagram',
// //       appIcon: 'assets/images/instagram_icon.png',
// //     ),
// //   ),
// // );


















// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

// class AppDetailPage extends StatefulWidget {
//   final String appName;
//   final int minutes;
//   final Color appColor;
//   final int timeLimitMinutes;

//   const AppDetailPage({
//     Key? key,
//     required this.appName,
//     required this.minutes,
//     required this.appColor,
//     required this.timeLimitMinutes,
//   }) : super(key: key);

//   @override
//   _AppDetailPageState createState() => _AppDetailPageState();
// }

// class _AppDetailPageState extends State<AppDetailPage> {
//   // Sample hourly usage data for the day
//   final List<double> hourlyUsage = [
//     0.5, 0.8, 1.2, 0.3, 0.0, 0.0, 0.0, 0.0, 
//     0.6, 1.5, 2.1, 1.8, 0.7, 0.0, 0.2, 1.2, 
//     2.0, 1.7, 1.3, 0.9, 0.4, 0.3, 0.1, 0.0
//   ];

//   // Sample weekly usage data
//   final List<int> weeklyData = [42, 38, 55, 45, 40, 52, 45];
//   final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

//   @override
//   Widget build(BuildContext context) {
//     // Calculate percentage of usage against time limit
//     double usagePercentage = (widget.minutes / widget.timeLimitMinutes) * 100;
    
//     // Determine if usage is in danger zone
//     bool inDangerZone = usagePercentage > 75;
//     bool nearLimit = usagePercentage > 50 && usagePercentage <= 75;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         // title: Text(
//         //   "${widget.appName} Usage",
//         //   style: TextStyle(color: Colors.black),
//         // ),
//         // backgroundColor: Colors.white,
//         // elevation: 0,
//         // iconTheme: IconThemeData(color:widget.appColor),
//         // Removed settings action from app bar
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with app info
//             Container(
//               padding: EdgeInsets.all(16),
//               color: widget.appColor,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: Icon(Icons.chat, color: widget.appColor),
//                         radius: 30,
//                       ),
//                       SizedBox(width: 16),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.appName,
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             "Today's usage: ${_formatMinutes(widget.minutes)}",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white.withOpacity(0.9),
//                             ),
//                           ),
//                           Text(
//                             "Time limit: ${_formatMinutes(widget.timeLimitMinutes)}",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white.withOpacity(0.9),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Added gap between heading and gauge chart
//             SizedBox(height: 24),

//             // Usage Meter heading with improved styling
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[900],
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 ),
//                 child: Text(
//                   "Usage Meter",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               ),
//             ),

//             // Gauge chart section with improved styling
//             Container(
//               padding: EdgeInsets.all(16),
//               margin: EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   )
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 250,
//                     child: SfRadialGauge(
//                       axes: <RadialAxis>[
//                         RadialAxis(
//                           minimum: 0,
//                           maximum: 100,
//                           startAngle: 150,
//                           endAngle: 30,
//                           showLabels: false,
//                           showTicks: false,
//                           radiusFactor: 0.8,
//                           axisLineStyle: AxisLineStyle(
//                             thickness: 0.2,
//                             cornerStyle: CornerStyle.bothCurve,
//                             color: Colors.grey.withOpacity(0.3),
//                             thicknessUnit: GaugeSizeUnit.factor,
//                           ),
//                           ranges: <GaugeRange>[
//                             // Normal usage zone (0-50%)
//                             GaugeRange(
//                               startValue: 0,
//                               endValue: 50,
//                               color: Colors.green,
//                               startWidth: 30,
//                               endWidth: 30,
//                             ),
//                             // Warning zone (50-75%)
//                             GaugeRange(
//                               startValue: 50,
//                               endValue: 75,
//                               color: Colors.orange,
//                               startWidth: 30,
//                               endWidth: 30,
//                             ),
//                             // Danger zone (75-100%)
//                             GaugeRange(
//                               startValue: 75,
//                               endValue: 100,
//                               color: Colors.red,
//                               startWidth: 30,
//                               endWidth: 30,
//                             ),
//                           ],
//                           pointers: <GaugePointer>[
//                             NeedlePointer(
//                               value: usagePercentage > 100 ? 100 : usagePercentage,
//                               needleLength: 0.6,
//                               needleStartWidth: 1,
//                               needleEndWidth: 5,
//                               knobStyle: KnobStyle(
//                                 knobRadius: 0.07,
//                                 color: Colors.white,
//                               ),
//                               tailStyle: TailStyle(
//                                 width: 5,
//                                 length: 0.15,
//                               ),
//                               needleColor: Colors.white,
//                             ),
//                           ],
//                           annotations: <GaugeAnnotation>[
//                             GaugeAnnotation(
//                               widget: Container(
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       '${usagePercentage.toInt()}%',
//                                       style: TextStyle(
//                                         fontSize: 28,
//                                         fontWeight: FontWeight.bold,
//                                         color: inDangerZone 
//                                             ? Colors.red 
//                                             : nearLimit 
//                                                 ? Colors.orange 
//                                                 : Colors.green,
//                                       ),
//                                     ),
//                                     Text(
//                                       _formatMinutes(widget.minutes),
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Text(
//                                       inDangerZone 
//                                           ? 'Danger Zone!' 
//                                           : nearLimit 
//                                               ? 'Approaching Limit' 
//                                               : 'Normal Usage',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: inDangerZone 
//                                             ? Colors.red 
//                                             : nearLimit 
//                                                 ? Colors.orange 
//                                                 : Colors.green,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               angle: 90,
//                               positionFactor: 0.5,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Usage zones explanation with improved styling
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.black45,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _buildZoneIndicator(Colors.green, "Normal (0-50%)"),
//                         _buildZoneIndicator(Colors.orange, "Warning (50-75%)"),
//                         _buildZoneIndicator(Colors.red, "Danger (75-100%)"),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: 24),
            
//             // Hourly usage chart heading with improved styling
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[900],
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 ),
//                 child: Text(
//                   "Today's Hourly Usage",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               ),
//             ),
            
//             // Hourly usage chart with improved styling
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 16),
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   )
//                 ],
//               ),
//               height: 220,
//               child: BarChart(
//                 BarChartData(
//                   alignment: BarChartAlignment.spaceAround,
//                   maxY: 3,
//                   barTouchData: BarTouchData(
//                     enabled: true,
//                     touchTooltipData: BarTouchTooltipData(
//                       tooltipBgColor: Colors.blueGrey,
//                       getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                         return BarTooltipItem(
//                           '${group.x}:00: ${rod.toY.toStringAsFixed(1)} min',
//                           TextStyle(color: Colors.white),
//                         );
//                       },
//                     ),
//                   ),
//                   titlesData: FlTitlesData(
//                     show: true,
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           if (value % 4 == 0) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 8.0),
//                               child: Text(
//                                 '${value.toInt()}:00',
//                                 style: TextStyle(color: Colors.white, fontSize: 10),
//                               ),
//                             );
//                           }
//                           return SizedBox();
//                         },
//                       ),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           return Text(
//                             '${value.toInt()} min',
//                             style: TextStyle(color: Colors.white, fontSize: 10),
//                           );
//                         },
//                         reservedSize: 30,
//                       ),
//                     ),
//                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   ),
//                   gridData: FlGridData(
//                     show: true,
//                     drawVerticalLine: false,
//                     getDrawingHorizontalLine: (value) {
//                       return FlLine(
//                         color: Colors.grey[800]!,
//                         strokeWidth: 1,
//                       );
//                     },
//                   ),
//                   borderData: FlBorderData(show: false),
//                   barGroups: hourlyUsage.asMap().entries.map((entry) {
//                     final int index = entry.key;
//                     final double value = entry.value;
                    
//                     return BarChartGroupData(
//                       x: index,
//                       barRods: [
//                         BarChartRodData(
//                           toY: value,
//                           color: widget.appColor,
//                           width: 8,
//                           borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
//                         ),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
            
//             SizedBox(height: 24),
            
//             // Weekly usage trends heading with improved styling
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[900],
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 ),
//                 child: Text(
//                   "Weekly Usage Trends",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               ),
//             ),
            
//             // Weekly usage trends with improved styling
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 16),
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   )
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "This week: ${_formatMinutes(weeklyData.reduce((a, b) => a + b))}",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         "Daily avg: ${_formatMinutes(weeklyData.reduce((a, b) => a + b) ~/ 7)}",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   SizedBox(
//                     height: 150,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: List.generate(7, (index) {
//                         final int minutes = weeklyData[index];
//                         final double percentage = minutes / weeklyData.reduce((a, b) => a > b ? a : b);
                        
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Container(
//                               width: 30,
//                               height: 100 * percentage,
//                               decoration: BoxDecoration(
//                                 color: widget.appColor.withOpacity(0.8),
//                                 borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               weekDays[index],
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             Text(
//                               "$minutes min",
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.7),
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: 32),
//           ],
//         ),
//       ),
//       // Removed floating action button (time limit setting option)
//     );
//   }

//   Widget _buildZoneIndicator(Color color, String label) {
//     return Row(
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//           ),
//         ),
//         SizedBox(width: 4),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }

//   String _formatMinutes(int minutes) {
//     int hours = minutes ~/ 60;
//     int remainingMinutes = minutes % 60;

//     if (hours > 0) {
//       return "$hours h $remainingMinutes min";
//     } else {
//       return "$minutes min";
//     }
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

// class AppDetailPage extends StatefulWidget {
//   final String appName;
//   final int minutes;
//   final Color appColor;
//   final int timeLimitMinutes;

//   const AppDetailPage({
//     Key? key,
//     required this.appName,
//     required this.minutes,
//     required this.appColor,
//     required this.timeLimitMinutes,
//   }) : super(key: key);

//   @override
//   _AppDetailPageState createState() => _AppDetailPageState();
// }

// class _AppDetailPageState extends State<AppDetailPage> {
//   // Sample hourly usage data for the day
//   final List<double> hourlyUsage = [
//     0.5, 0.8, 1.2, 0.3, 0.0, 0.0, 0.0, 0.0, 
//     0.6, 1.5, 2.1, 1.8, 0.7, 0.0, 0.2, 1.2, 
//     2.0, 1.7, 1.3, 0.9, 0.4, 0.3, 0.1, 0.0
//   ];

//   // Sample weekly usage data
//   final List<int> weeklyData = [42, 38, 55, 45, 40, 52, 45];
//   final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

//   @override
//   Widget build(BuildContext context) {
//     // Calculate percentage of usage against time limit
//     double usagePercentage = (widget.minutes / widget.timeLimitMinutes) * 100;
    
//     // Determine if usage is in danger zone
//     bool inDangerZone = usagePercentage > 75;
//     bool nearLimit = usagePercentage > 50 && usagePercentage <= 75;
//     bool exceededLimit = usagePercentage > 100;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           "${widget.appName} Usage",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: widget.appColor,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Modified header with app info and warning message when limit exceeded
//             Container(
//               padding: EdgeInsets.all(16),
//               color: widget.appColor,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: Icon(Icons.chat, color: widget.appColor),
//                         radius: 30,
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.appName,
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             Text(
//                               "Today's usage: ${_formatMinutes(widget.minutes)}",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white.withOpacity(0.9),
//                               ),
//                             ),
//                             Text(
//                               "Time limit: ${_formatMinutes(widget.timeLimitMinutes)}",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white.withOpacity(0.9),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Added warning message when time limit is exceeded
//                   if (exceededLimit)
//                     Container(
//                       margin: EdgeInsets.only(top: 12),
//                       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                       decoration: BoxDecoration(
//                         color: Colors.red.shade800,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.white, width: 1),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.warning_amber_rounded,
//                             color: Colors.white,
//                             size: 24,
//                           ),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               "You have exceeded your time limit!",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//             ),

//             // Added gap between heading and gauge chart
//             SizedBox(height: 24),

//             // Usage Meter heading with improved styling
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[900],
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 ),
//                 child: Text(
//                   "Usage Meter",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               ),
//             ),

//             // Gauge chart section with improved styling and capped percentage
//             Container(
//               padding: EdgeInsets.all(16),
//               margin: EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   )
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 250,
//                     child: SfRadialGauge(
//                       axes: <RadialAxis>[
//                         RadialAxis(
//                           minimum: 0,
//                           maximum: 100,
//                           startAngle: 150,
//                           endAngle: 30,
//                           showLabels: false,
//                           showTicks: false,
//                           radiusFactor: 0.8,
//                           axisLineStyle: AxisLineStyle(
//                             thickness: 0.2,
//                             cornerStyle: CornerStyle.bothCurve,
//                             color: Colors.grey.withOpacity(0.3),
//                             thicknessUnit: GaugeSizeUnit.factor,
//                           ),
//                           ranges: <GaugeRange>[
//                             // Normal usage zone (0-50%)
//                             GaugeRange(
//                               startValue: 0,
//                               endValue: 50,
//                               color: Colors.green,
//                               startWidth: 30,
//                               endWidth: 30,
//                             ),
//                             // Warning zone (50-75%)
//                             GaugeRange(
//                               startValue: 50,
//                               endValue: 75,
//                               color: Colors.orange,
//                               startWidth: 30,
//                               endWidth: 30,
//                             ),
//                             // Danger zone (75-100%)
//                             GaugeRange(
//                               startValue: 75,
//                               endValue: 100,
//                               color: Colors.red,
//                               startWidth: 30,
//                               endWidth: 30,
//                             ),
//                           ],
//                           pointers: <GaugePointer>[
//                             NeedlePointer(
//                               value: usagePercentage > 100 ? 100 : usagePercentage,
//                               needleLength: 0.6,
//                               needleStartWidth: 1,
//                               needleEndWidth: 5,
//                               knobStyle: KnobStyle(
//                                 knobRadius: 0.07,
//                                 color: Colors.white,
//                               ),
//                               tailStyle: TailStyle(
//                                 width: 5,
//                                 length: 0.15,
//                               ),
//                               needleColor: Colors.white,
//                             ),
//                           ],
//                           annotations: <GaugeAnnotation>[
//                             GaugeAnnotation(
//                               widget: Container(
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       // Display actual percentage but capped at 100% for gauge
//                                       '${exceededLimit ? 100 : usagePercentage.toInt()}%',
//                                       style: TextStyle(
//                                         fontSize: 28,
//                                         fontWeight: FontWeight.bold,
//                                         color: exceededLimit || inDangerZone
//                                             ? Colors.red 
//                                             : nearLimit 
//                                                 ? Colors.orange 
//                                                 : Colors.green,
//                                       ),
//                                     ),
//                                     Text(
//                                       _formatMinutes(widget.minutes),
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Text(
//                                       exceededLimit
//                                           ? 'Limit Exceeded!'
//                                           : inDangerZone 
//                                               ? 'Danger Zone!' 
//                                               : nearLimit 
//                                                   ? 'Approaching Limit' 
//                                                   : 'Normal Usage',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: exceededLimit || inDangerZone
//                                             ? Colors.red 
//                                             : nearLimit 
//                                                 ? Colors.orange 
//                                                 : Colors.green,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               angle: 90,
//                               positionFactor: 0.5,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Usage zones explanation with improved styling
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.black45,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _buildZoneIndicator(Colors.green, "Normal (0-50%)"),
//                         _buildZoneIndicator(Colors.orange, "Warning (50-75%)"),
//                         _buildZoneIndicator(Colors.red, "Danger (75-100%)"),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: 24),
            
//             // Hourly usage chart heading with improved styling
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[900],
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 ),
//                 child: Text(
//                   "Today's Hourly Usage",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               ),
//             ),
            
//             // Hourly usage chart with improved styling
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 16),
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   )
//                 ],
//               ),
//               height: 220,
//               child: BarChart(
//                 BarChartData(
//                   alignment: BarChartAlignment.spaceAround,
//                   maxY: 3,
//                   barTouchData: BarTouchData(
//                     enabled: true,
//                     touchTooltipData: BarTouchTooltipData(
//                       tooltipBgColor: Colors.blueGrey,
//                       getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                         return BarTooltipItem(
//                           '${group.x}:00: ${rod.toY.toStringAsFixed(1)} min',
//                           TextStyle(color: Colors.white),
//                         );
//                       },
//                     ),
//                   ),
//                   titlesData: FlTitlesData(
//                     show: true,
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           if (value % 4 == 0) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 8.0),
//                               child: Text(
//                                 '${value.toInt()}:00',
//                                 style: TextStyle(color: Colors.white, fontSize: 10),
//                               ),
//                             );
//                           }
//                           return SizedBox();
//                         },
//                       ),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           return Text(
//                             '${value.toInt()} min',
//                             style: TextStyle(color: Colors.white, fontSize: 10),
//                           );
//                         },
//                         reservedSize: 30,
//                       ),
//                     ),
//                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   ),
//                   gridData: FlGridData(
//                     show: true,
//                     drawVerticalLine: false,
//                     getDrawingHorizontalLine: (value) {
//                       return FlLine(
//                         color: Colors.grey[800]!,
//                         strokeWidth: 1,
//                       );
//                     },
//                   ),
//                   borderData: FlBorderData(show: false),
//                   barGroups: hourlyUsage.asMap().entries.map((entry) {
//                     final int index = entry.key;
//                     final double value = entry.value;
                    
//                     return BarChartGroupData(
//                       x: index,
//                       barRods: [
//                         BarChartRodData(
//                           toY: value,
//                           color: widget.appColor,
//                           width: 8,
//                           borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
//                         ),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
            
//             SizedBox(height: 24),
            
//             // Weekly usage trends heading with improved styling
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[900],
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 ),
//                 child: Text(
//                   "Weekly Usage Trends",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               ),
//             ),
            
//             // Weekly usage trends with improved styling
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 16),
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   )
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "This week: ${_formatMinutes(weeklyData.reduce((a, b) => a + b))}",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         "Daily avg: ${_formatMinutes(weeklyData.reduce((a, b) => a + b) ~/ 7)}",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   SizedBox(
//                     height: 150,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: List.generate(7, (index) {
//                         final int minutes = weeklyData[index];
//                         final double percentage = minutes / weeklyData.reduce((a, b) => a > b ? a : b);
                        
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Container(
//                               width: 30,
//                               height: 100 * percentage,
//                               decoration: BoxDecoration(
//                                 color: widget.appColor.withOpacity(0.8),
//                                 borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               weekDays[index],
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             Text(
//                               "$minutes min",
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.7),
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildZoneIndicator(Color color, String label) {
//     return Row(
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//           ),
//         ),
//         SizedBox(width: 4),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }

//   String _formatMinutes(int minutes) {
//     int hours = minutes ~/ 60;
//     int remainingMinutes = minutes % 60;

//     if (hours > 0) {
//       return "$hours h $remainingMinutes min";
//     } else {
//       return "$minutes min";
//     }
//   }
// }







///aarthi code final
library;


// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AppDetailPage extends StatefulWidget {
  final String appName;
  final int minutes;
  final Color appColor;
  final int timeLimitMinutes;

  const AppDetailPage({
    super.key,
    required this.appName,
    required this.minutes,
    required this.appColor,
    required this.timeLimitMinutes,
  });

  @override
  _AppDetailPageState createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Sample data for daily usage
  final List<double> dailyUsageData = [25, 42, 38, 45, 55, 65, 58];
  
  // Sample data for weekly usage
  final List<double> weeklyUsageData = [185, 210, 245, 230, 275, 310, 280];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate percentage of time limit used
    double usagePercentage = (widget.minutes / widget.timeLimitMinutes) * 100;
    usagePercentage = usagePercentage > 100 ? 100 : usagePercentage;
    
    // Determine color for gauge based on usage
    Color gaugeColor = Colors.green;
    if (usagePercentage > 75) {
      gaugeColor = Colors.red;
    } else if (usagePercentage > 50) {
      gaugeColor = Colors.orange;
    }
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: widget.appColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              radius: 16,
              child: Icon(Icons.apps, color: Colors.white, size: 16),
            ),
            SizedBox(width: 12),
            Text(
              widget.appName,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time limit and consumption info
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Usage",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildUsageInfoItem(
                            "Time Used",
                            
                            _formatMinutes(widget.minutes),
                            widget.appColor,
                            Icons.timer,
                          ),
                          _buildUsageInfoItem(
                            "Time Limit",
                            _formatMinutes(widget.timeLimitMinutes),
                            widget.appColor,
                            Icons.alarm,
                          ),
                          _buildUsageInfoItem(
                            "Remaining",
                            _formatMinutes(widget.timeLimitMinutes > widget.minutes 
                                ? widget.timeLimitMinutes - widget.minutes 
                                : 0),
                            widget.appColor,
                            Icons.hourglass_bottom,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // Gauge chart
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Usage Meter",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 250,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              startAngle: 150,
                              endAngle: 30,
                              radiusFactor: 0.8,
                              showLabels: false,
                              showTicks: false,
                              axisLineStyle: AxisLineStyle(
                                thickness: 30,
                                color: Colors.grey[800],
                              ),
                              ranges: <GaugeRange>[
                                // Normal zone (0-50%)
                                GaugeRange(
                                  startValue: 0,
                                  endValue: 50,
                                  color: Colors.green,
                                  startWidth: 30,
                                  endWidth: 30,
                                ),
                                // Warning zone (50-75%)
                                GaugeRange(
                                  startValue: 50,
                                  endValue: 75,
                                  color: Colors.orange,
                                  startWidth: 30,
                                  endWidth: 30,
                                ),
                                // Danger zone (75-100%)
                                GaugeRange(
                                  startValue: 75,
                                  endValue: 100,
                                  color: Colors.red,
                                  startWidth: 30,
                                  endWidth: 30,
                                ),
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                  value: usagePercentage,
                                  needleLength: 0.7,
                                  needleColor: gaugeColor,
                                  knobStyle: KnobStyle(
                                    knobRadius: 0.1,
                                    color: gaugeColor,
                                  ),
                                ),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  widget: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${usagePercentage.toStringAsFixed(1)}%',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          
                                        ),
                                      ),
                                      Text(
                                        'of limit used',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  positionFactor: 0.5,
                                  angle: 90,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (usagePercentage >= 100)
                        Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.red),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "You have reached your time limit!",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // Usage charts (daily/weekly)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Usage Statistics",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      TabBar(
                        controller: _tabController,
                        labelColor: widget.appColor,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: widget.appColor,
                        tabs: [
                          Tab(text: "Daily"),
                          Tab(text: "Weekly"),
                        ],
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 250,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Daily usage chart
                            _buildBarChart(
                              dailyUsageData,
                              ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                              "Minutes",
                              maxY: 80,
                            ),
                            // Weekly usage chart
                            _buildBarChart(
                              weeklyUsageData,
                              ['W1', 'W2', 'W3', 'W4', 'W5', 'W6', 'W7'],
                              "Minutes",
                              maxY: 350,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // Usage insights
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Insights",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildInsightItem(
                        "Peak Usage Time",
                        "8:00 PM - 10:00 PM",
                        Icons.access_time,
                        widget.appColor,
                      ),
                      _buildInsightItem(
                        "Weekly Trend",
                        usagePercentage > 80 ? "Increasing ↑" : "Decreasing ↓",
                        Icons.trending_up,
                        usagePercentage > 80 ? Colors.red : Colors.green,
                      ),
                      _buildInsightItem(
                        "Compared to Average",
                        widget.minutes > 60 ? "Above average" : "Below average",
                        Icons.compare_arrows,
                        widget.minutes > 60 ? Colors.orange : Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsageInfoItem(String title, String value, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 30,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildInsightItem(String title, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<double> data, List<String> labels, String title, {required double maxY}) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.black,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    labels[value.toInt() % labels.length],
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                );
              },
              reservedSize: 30,
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey[800]!,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(show: false),
        barGroups: data.asMap().entries.map((entry) {
          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value,
                color: widget.appColor,
                width: 16,
                borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  String _formatMinutes(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    if (hours > 0) {
      return "$hours h $remainingMinutes min";
    } else {
      return "$minutes min";
    }
  }
}