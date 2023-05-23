import 'package:flutter/material.dart';
import '../services/utilities.dart' as util;

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: util.navyBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Methods',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Choose desired method type.',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24.0),
            Column(
              children: [
                Container(
                  width: 500,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black, // couleur de la bordure
                      width: 0.5, // largeur de la bordure
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/visa.png',
                          width: 200,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const Expanded(
                        child: Text(
                          '**** **** **** 3765',
                          style: TextStyle(
                            fontSize: 16, // taille de police de 16 points
                            fontWeight: FontWeight.bold, // police en gras
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  width: 500,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black, // couleur de la bordure
                      width: 0.5, // largeur de la bordure
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/paypal.png',
                          width: 500,
                          height: 300,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const Expanded(
                        child: Text(
                          'bastore@gmail.com',
                          style: TextStyle(
                            fontSize: 16, // taille de police de 16 points
                            fontWeight: FontWeight.bold, // police en gras
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  width: 500,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black, // couleur de la bordure
                      width: 0.5, // largeur de la bordure
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/moncash.webp',
                          width: 800,
                          height: 300,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const Expanded(
                        child: Text(
                          '509 **** 3997',
                          style: TextStyle(
                            fontSize: 16, // taille de police de 16 points
                            fontWeight: FontWeight.bold, // police en gras
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50.0),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: util.navyBlue, // Background color
                  minimumSize: const Size(300, 60), // Width and height
                ),
                child: const Text('Proceed to payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
