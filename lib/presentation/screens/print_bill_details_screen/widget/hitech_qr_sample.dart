import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LabBookingInfoWidget extends StatelessWidget {
  final String userName;
  final String labQrData;
  final String bookingQrData;

  const LabBookingInfoWidget({
    super.key,
    this.userName = 'SANDRIYA',
    required this.labQrData,
    required this.bookingQrData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // CALL US FOR BOOKING
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'CALL US FOR BOOKING',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),

          // SERVICES
          const Text(
            'X-RAY, ECG, SCANNING, TMT, ECHO,\n'
            'MAMOGRAPHY, PFT, EEG, NCV,LAB TEST , LIVER\n'
            'ELASTOGRAPHY  ALONG WITH HOME BLOOD\n'
            'COLLECTION',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              height: 1.35,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 2),

          // PHONE NUMBER
          const Text(
            '2 333 888 , 35 33 888',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // WHATSAPP INFORMATION
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'RESULT AVAILABLE VIA',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),

              const SizedBox(width: 5),

              const Icon(Icons.chat, size: 30, color: Colors.black),

              const SizedBox(width: 10),

              const Text(
                'PLEASE SEND YOUR',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // BLACK BANNER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.black,
            child: Center(
              child: Text(
                'NAME & LAB NO. TO 807 88 10000',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 3),

          // QR TITLES
          Row(
            children: [
              Expanded(child: _buildQrTitle('Find our Labs')),
              Expanded(child: _buildQrTitle('Take Your Booking')),
            ],
          ),

          // QR CODES
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: QrImageView(
                  data: labQrData,
                  version: QrVersions.auto,
                  size: 150,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(10),
                ),
              ),

              Expanded(
                child: QrImageView(
                  data: bookingQrData,
                  version: QrVersions.auto,
                  size: 150,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // USER NAME
          Row(
            children: [
              const Text(
                'User:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),

              const SizedBox(width: 40),

              Text(
                userName,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildQrTitle(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
