import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sign_stage/models/main/ticket.dart';
import 'package:sign_stage/widgets/custom/custom_barcode_image.dart';
import 'package:sign_stage/widgets/custom/custom_detailed_column.dart';

class ETicketItem extends StatelessWidget {
  ETicketItem({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Play: ${ticket.play.title}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'e-ticket',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailedColumn(
                        label: 'Date',
                        value: DateFormat('MM/dd/yyyy')
                            .format(ticket.bookingInfo.selectedDate),
                      ),
                      const SizedBox(height: 20),
                      DetailedColumn(
                        label: 'Location',
                        value: ticket.play.hall,
                      ),
                      const SizedBox(height: 20),
                      DetailedColumn(
                        label: 'Payment',
                        value: ticket.status,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailedColumn(
                        label: 'Time',
                        value: '${ticket.bookingInfo.selectedTime} PM',
                      ),
                      const SizedBox(height: 20),
                      DetailedColumn(
                        label: 'Seats',
                        value: ticket.bookingInfo.selectedSeats.join(', '),
                      ),
                      const SizedBox(height: 20),
                      DetailedColumn(
                        label: 'Price',
                        value: '${ticket.bookingInfo.totalPrice} €',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const DottedLine(
                dashLength: 6.0,
                dashGapLength: 3.0,
                lineThickness: 1.0,
                dashColor: Colors.black,
              ),
              const SizedBox(height: 30),
              Center(
                child: CustomBarcodeImage(
                  data: ticket.id.substring(0, 12),
                  barcode: ticket.barcode,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Future<void> captureAndSaveImage() async {
  //   await Future.delayed(Duration(milliseconds: 500)); // Ensure widget build completion
  //   if (_globalKey.currentContext == null) {
  //     print('GlobalKey current context is null');
  //     return;
  //   }
  //   final RenderObject? renderObject = _globalKey.currentContext!.findRenderObject();
  //   if (renderObject == null) {
  //     print('Render object is null');
  //     return;
  //   }

  //   try {
  //     final RenderRepaintBoundary boundary = renderObject as RenderRepaintBoundary;
  //     final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //     final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     if (byteData == null) {
  //       print('ByteData is null');
  //       return;
  //     }
  //     final Uint8List pngBytes = byteData.buffer.asUint8List();

  //     // Save image to temporary directory
  //     final directory = await getTemporaryDirectory();
  //     final filePath = '${directory.path}/ticket_${ticket.id}.png';
  //     final file = File(filePath);
  //     await file.writeAsBytes(pngBytes);

  //     // Use flutter_downloader to download the file
  //     await FlutterDownloader.enqueue(
  //       url: file.path,
  //       savedDir: directory.path,
  //       fileName: 'ticket_${ticket.id}.png',
  //       showNotification: true,
  //       openFileFromNotification: true,
  //     );
  //   } catch (e) {
  //     print('Error capturing and saving image: ${e.toString()}');
  //   }
  // }
}
