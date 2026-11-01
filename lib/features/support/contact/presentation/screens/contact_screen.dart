
import 'package:aura_maison_e_commerce/features/profile/presentation/widgets/profile_widget.dart';
import 'package:aura_maison_e_commerce/features/support/contact/data/models/contact_model.dart';
import 'package:aura_maison_e_commerce/features/support/contact/presentation/widgets/contact_widget.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // Controllers for editing salon contact information.
  late final TextEditingController _parisPhoneController;
  late final TextEditingController _parisEmailController;

  late final TextEditingController _genevaPhoneController;
  late final TextEditingController _genevaEmailController;

  // Salon sample data.
  late final ContactModel _parisSalon;
  late final ContactModel _genevaSalon;

  @override
void initState() {
  super.initState();

  _parisSalon = ContactModel.paris();
  _genevaSalon = ContactModel.geneva();

  _parisPhoneController = TextEditingController(
    text: _parisSalon.phone,
  );

  _parisEmailController = TextEditingController(
    text: _parisSalon.email,
  );

  _genevaPhoneController = TextEditingController(
    text: _genevaSalon.phone,
  );

  _genevaEmailController = TextEditingController(
    text: _genevaSalon.email,
  );
}

  @override
  void dispose() {
    // Always dispose controllers when the screen is removed.
    _parisPhoneController.dispose();
    _parisEmailController.dispose();

    _genevaPhoneController.dispose();
    _genevaEmailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: CustomAppBar(
        title: 'Private Concierge Support',
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Screen introduction.
          Row(
            children: [
              Icon(
                Icons.circle,
                color: AppColors.primaryGold,
                size: 6,
              ),
              const SizedBox(width: 6),
              Text(
                'PRIVATE SALON NETWORK • PARIS & GENÈVE',
                style: TextStyle(
                  color: AppColors.primaryGold,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            'The Watchmaking Sanctuaries',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Access strictly reserved for collectors and accredited representatives. Absolute discretion and a high-security protocol.',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 20),

          // Paris salon.
          ConciergeSalonCard(
            salon: _parisSalon,
            phoneController: _parisPhoneController,
            emailController: _parisEmailController,
          ),

          const SizedBox(height: 16),

          // Geneva salon.
          ConciergeSalonCard(
            salon: _genevaSalon,
            phoneController: _genevaPhoneController,
            emailController: _genevaEmailController,
          ),

          const SizedBox(height: 16),

          // Shared information widgets.
          StrategicRadarCard(),

          const SizedBox(height: 20),

          PrimaryButton(
            text: 'OPEN CONCIERGE FORM',
            onPressed: () {
              // TODO: Navigate to the concierge form screen.
            },
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.cardBorder),
              backgroundColor: AppColors.cardBg,
              minimumSize: Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () {
              // TODO: Implement private salon visit scheduling.
            },
            icon: Icon(
              Icons.calendar_today_outlined,
              color: AppColors.primaryGold,
              size: 16,
            ),
            label: Text(
              'SCHEDULE A PRIVATE SALON VISIT',
              style: TextStyle(
                color: AppColors.textWhite,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),

          const SizedBox(height: 16),

          HighDiscretionProtocolCard(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
