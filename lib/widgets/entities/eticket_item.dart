import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sign_stage/models/main/ticket.dart';
import 'package:sign_stage/widgets/custom/custom_barcode_image.dart';
import 'package:sign_stage/widgets/custom/custom_detailed_column.dart';

class ETicketItem extends StatelessWidget {
  ETicketItem({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  final Ticket ticket;
  final GlobalKey _globalKey = GlobalKey();

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
                child: RepaintBoundary(
                  key: _globalKey,
                  child: CustomBarcodeImage(
                    data: ticket.id.substring(0, 12),
                    barcode: ticket.barcode,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await captureAndSaveImage();
                    await downloadTicketImage(ticket);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    'Download E-Ticket',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> captureAndSaveImage() async {
    try {
      await Future.delayed(
          Duration(milliseconds: 500)); // Ensure widget build completion
      final RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        throw Exception('ByteData is null');
      }
      final Uint8List pngBytes = byteData.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/ticket_${ticket.id}.png';
      final File file = File(filePath);
      await file.writeAsBytes(pngBytes);
    } catch (e) {
      print('Error capturing and saving image: $e');
    }
  }

  Future<void> downloadTicketImage(Ticket ticket) async {
    try {
      // Save the captured image to a temporary directory
      final directory = await getTemporaryDirectory();
      final tempFilePath = '${directory.path}/ticket_${ticket.id}.png';

      // Move the file to the downloads directory
      Directory? downloadsDirectory = await getDownloadsDirectory();
      if (downloadsDirectory == null) {
        throw Exception("Unable to get downloads directory");
      }
      final downloadsFilePath = '${downloadsDirectory.path}/ticket_${ticket.id}.png';
      final File tempFile = File(tempFilePath);
      final File downloadsFile = await tempFile.copy(downloadsFilePath);

      // Use the correct file URL format for FlutterDownloader
      await FlutterDownloader.enqueue(
        url: downloadsFile.path,
        savedDir: downloadsDirectory.path,
        fileName: 'ticket_${ticket.id}.png',
        showNotification: true,
        openFileFromNotification: true,
      );
    } catch (e) {
      print('Error downloading image: $e');
    }
  }
}
