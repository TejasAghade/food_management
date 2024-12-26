import 'package:flutter/material.dart';
import 'package:food_management/models/user_food_report.model.dart';
import 'package:food_management/services/api.service.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  UserFoodReportModel? foodReport;
  bool pageLoading = false;
  int _selectedMonth = 11;
  int totalFine = 0;
  int pending = 0;
  int totalOrders = 0;

  void _fetchFoodReport() async {
    foodReport = await fetchUserFoodReports(months: _selectedMonth);
    totalFine = 0;
    foodReport?.reports?.forEach((report) {
      int reportFine = 0;
      int orders = 0;

      if (report.optIns?.breakfast == "Pending") reportFine += 1;
      if (report.optIns?.lunch == "Pending") reportFine += 1;
      if (report.optIns?.dinner == "Pending") reportFine += 1;

      if (report.optIns?.breakfast != "Canceled") orders += 1;
      if (report.optIns?.lunch != "Canceled") orders += 1;
      if (report.optIns?.dinner != "Canceled") orders += 1;
    
      totalOrders += orders;
      totalFine += reportFine*100;
    });
    pageLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    pageLoading = true;
    _fetchFoodReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Report", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
        elevation: 1,
        backgroundColor: Colors.amber.shade100,
      ),
      body: pageLoading
          ? Center(
              child: const CircularProgressIndicator.adaptive(),
            )
          : foodReport == null? Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Text("Something went wrong! try again."),
                IconButton(onPressed: ()=>_fetchFoodReport(), icon: Icon(Icons.replay_outlined))
              ],
            ),
          ) : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.orangeAccent.shade100,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  radius: 20,
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.person_outline_outlined,
                                    size: 25,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${foodReport?.user?.fName} ${foodReport?.user?.lName}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4,),
                                  Row(
                                    children: [
                                      Icon(Icons.mail_outline, size: 14, color: Colors.deepOrange,),
                                      SizedBox(width: 5,),
                                      Text(
                                        "${foodReport?.user?.email}",
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4,),
                                  Row(
                                    children: [
                                      Icon(Icons.phone_android_rounded, size: 14, color: Colors.deepOrange,),
                                      SizedBox(width: 5,),
                                      Text(
                                        "${foodReport?.user?.phone}",
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4,),
                                  Row(
                                    children: [
                                      Text(
                                        "${foodReport?.user?.empId}  | ",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      Text(
                                        " dept - ${foodReport?.user?.departmentId}",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              SizedBox(
                                height: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.greenAccent.shade400,
                                      ),
                                      padding: EdgeInsets.only(
                                        left: 10,
                                        bottom: 1,
                                        top: 1,
                                        right: 10,
                                      ),
                                      margin: EdgeInsets.only(right: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        foodReport?.user?.status == 1
                                            ? "Active"
                                            : "Disabled",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: foodReport?.user?.isVeg == 1
                                                ? Colors.greenAccent.shade400
                                                : Colors.red.shade400,
                                          ),
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            bottom: 1,
                                            top: 1,
                                          ),
                                          margin: EdgeInsets.only(right: 6),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Text(
                                          foodReport?.user?.isVeg == 1
                                              ? "Veg"
                                              : "Nonveg",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: foodReport?.user?.isVeg == 1
                                                ? Colors.greenAccent.shade400
                                                : Colors.red.shade400,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber.shade200),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Month",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.only(left: 3),
                              height: 35,
                              margin: EdgeInsets.only(top: 3),
                              child: DropdownButton<int>(
                                menuWidth: 70,
                                underline: SizedBox(),
                                value: _selectedMonth,
                                hint: Text('Select month'),
                                items: List.generate(12, (index) {
                                  int number = index + 1;
                                  return DropdownMenuItem<int>(
                                    value: number,
                                    child: Text(number.toString()),
                                  );
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    pageLoading = true;
                                    _selectedMonth = value!;
                                  });
                                  _fetchFoodReport();
                                },
                              ),
                            ),
                          ],
                        ),
                      
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Orders       :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    "${foodReport?.user?.orderCount==0? totalOrders : foodReport?.user?.orderCount}",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 7,),
                              Row(
                                children: [
                                  Text(
                                    "Total Fine :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Text( 
                                    "₹ $totalFine",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  foodReport?.reports == null || foodReport?.reports!.length ==0 ? Center(child: Text("No Reports", style: TextStyle(fontSize: 13, color: Colors.grey.shade800),),) :Expanded(
                    child: ListView.builder(
                      itemCount: foodReport?.reports?.length ?? 0,
                      itemBuilder: (context, index) {
                        Report? report = foodReport!.reports![index];
                        pending =
                            report.optIns?.breakfast == "Pending" ? 1 : 0;
                        pending = pending +
                            (report.optIns?.lunch == "Pending" ? 1 : 0);
                        pending = pending +
                            (report.optIns?.dinner == "Pending" ? 1 : 0);
                        return ListTile(
                          title: Text(
                            "${report.date}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(
                              top: 3,
                            ),
                            padding: EdgeInsets.only(
                              left: 8,
                              bottom: 12,
                              top: 5
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.amber.shade100,
                                ),
                              ),
                            ),
                            child: report.optIns == null
                                ? Text(
                                    "No data",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Breakfast    :   ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.grey.shade800,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: report
                                                          .optIns!.breakfast ??
                                                      "",
                                                  style: optInTextStyle(
                                                    status: report
                                                        .optIns!.breakfast!,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Lunch          :   ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.grey.shade800,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: report.optIns!.lunch ??
                                                      "",
                                                  style: optInTextStyle(
                                                    status:
                                                        report.optIns!.lunch!,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Dinner         :   ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.grey.shade800,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: report.optIns!.dinner ??
                                                      "",
                                                  style: optInTextStyle(
                                                    status:
                                                        report.optIns!.dinner!,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (pending > 0)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Fine",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Text(
                                              pending.toString() + 'x Pending',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                            Text(
                                              "₹ ${pending * 100}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

TextStyle optInTextStyle({String status = "Delivered"}) {
  return TextStyle(
      fontWeight: FontWeight.w500,
      color: status == "Pending" ? Colors.red : Colors.black);
}
