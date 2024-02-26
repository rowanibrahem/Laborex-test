import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laborex_distribution_app/data/models/delivery_order.dart';

class DeliveryOrderCard extends StatefulWidget {
  final DeliveryOrder deliveryOrder;

  const DeliveryOrderCard({super.key, required this.deliveryOrder});

  @override
  State<DeliveryOrderCard> createState() => _DeliveryOrderCardState();
}

class _DeliveryOrderCardState extends State<DeliveryOrderCard> {
  String _scanBarcode = 'Unknown';
  bool _foundResult = false;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
      if (!mounted) return;

      setState(() {
        barcodeScanRes != '-1' ? _foundResult = true : _foundResult = false;

        _scanBarcode = barcodeScanRes;
      });
    } catch (e) {
      barcodeScanRes = 'Failed : ${e.toString()}';

      if (!mounted) return;

      setState(
        () {
          _foundResult = false;
          _scanBarcode = barcodeScanRes;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var customDivider = SizedBox(
      height: 34.h,
      child: VerticalDivider(
        color: Colors.grey[90],
        thickness: 1,
      ),
    );
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.deliveryOrder.pharmacyName,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
            ),
            subtitle: Text(
              widget.deliveryOrder.orderId,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14.sp,
                  ),
            ),
            // trailing: Text(deliveryOrder.status.toString()),
            trailing: (widget.deliveryOrder.status ==
                    DeliveryOrderStatus.inStock)
                ? InkWell(
                    child: Image.asset(
                      "assets/icons/qr_red.png",
                    ),
                    onTap: () {
                      scanBarcodeNormal();
                    },
                  )
                : (widget.deliveryOrder.status == DeliveryOrderStatus.pending)
                    ? Image.asset("assets/icons/qr_green.png")
                    : Image.asset("assets/icons/green_arrow.png"),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BottomSection(
                  title: "رقم الفاتورة",
                  subtitle: widget.deliveryOrder.itemsCount.toString(),
                ),
                customDivider,
                BottomSection(
                  title: "التكلفة الكلية",
                  subtitle: widget.deliveryOrder.billNumber.toString(),
                ),
                customDivider,
                BottomSection(
                  title: "عدد الاصناف",
                  subtitle: widget.deliveryOrder.totalAmount.toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  final String title;
  final String subtitle;
  const BottomSection({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold, color: const Color(0xbb696969)),
        ),
        SizedBox(height: 8.h),
        Text(subtitle),
      ],
    );
  }
}
