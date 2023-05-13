import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krankenhaus/common/text_widget.dart';
import 'package:krankenhaus/models/qr_model.dart';
import 'package:responsive_table/responsive_table.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key, required this.data}) : super(key: key);
  final QRModel data;
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<DatatableHeader> _headers = [];
  @override
  void initState() {
    super.initState();
    print(widget.data.products);

    /// set headers
    _headers = [
      DatatableHeader(
          text: "ID",
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Name",
          value: "name",
          show: true,
          flex: 2,
          sortable: true,
          editable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Quantity",
          value: "quantity",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Price",
          value: "price",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Department",
          value: "department",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Date",
          value: "date",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
    ];

    // _initializeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              constraints: BoxConstraints(
                maxHeight: Get.height,
              ),
              child: ResponsiveDatatable(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   mainAxisSize: MainAxisSize.max,
                      //   children: [
                      //     TextWidget(text: "FirstName"),
                      //     TextWidget(
                      //       text: widget.data.transaction['firstName'],
                      //     )
                      //   ],
                      // ),
                      // ListTile(
                      //     leading: TextWidget(text: "FirstName"),
                      //     trailing: TextWidget(
                      //       text: widget.data.transaction['firstName'],
                      //     )),
                      // RichText(text: TextSpan(children: [
                      //   TextSpan(text: "First Name")
                      // ],),)
                      TextWidget(
                        text:
                            'First Name: ${widget.data.transaction['firstName']}',
                        fontWeight: FontWeight.w700,
                      ),
                      TextWidget(
                        text:
                            'Last Name: ${widget.data.transaction['lastName']}',
                        fontWeight: FontWeight.w700,
                      ),
                      TextWidget(
                        text: 'Status: ${widget.data.transaction['status']}',
                        fontWeight: FontWeight.w700,
                      ),
                      TextWidget(
                        text: 'Unit: ${widget.data.transaction['unit']}',
                        fontWeight: FontWeight.w700,
                      ),
                      TextWidget(
                        text:
                            'Total: ${widget.data.transaction['total'].toString()}',
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                reponseScreenSizes: [ScreenSize.xs],

                headers: _headers,
                source: widget.data.products
                    .map(
                      (e) => {
                        "id": e['id'],
                        "name": e['name'],
                        "quantity": e['quantity'],
                        "price": e['price'],
                        "department": e['department'],
                        "date": DateFormat("yyyy-MM-dd")
                            .format(DateTime.parse(e['createdAt']))
                      },
                    )
                    .toList(),
                selecteds: [],
                showSelect: false,
                autoHeight: false,

                expanded: [],
                // sortAscending: _sortAscending,
                // sortColumn: _sortColumn,
                isLoading: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
