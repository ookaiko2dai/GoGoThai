import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/trip_model.dart';
import '../theme/app_theme.dart';

class PromptPaySheet extends StatelessWidget {
  final TripMember member;
  final double amountToPay;

  const PromptPaySheet({
    super.key,
    required this.member,
    required this.amountToPay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Header PromptPay
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF003D6B),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.qr_code_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  'PromptPay พร้อมเพย์',
                  style: GoogleFonts.prompt(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Receiver info
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(member.avatar),
          ),
          const SizedBox(height: 8),
          Text(
            member.promptPayName,
            style: GoogleFonts.prompt(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textMain,
            ),
          ),
          Text(
            'เบอร์พร้อมเพย์: ${member.promptPayNumber}',
            style: GoogleFonts.prompt(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),

          // QR Code Mock Container
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Simulated QR Graphic
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.qr_code_2_rounded, size: 160, color: Color(0xFF003D6B)),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Text('🇹🇭', style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'ยอดที่ต้องโอน',
                  style: GoogleFonts.prompt(fontSize: 12, color: AppColors.textMuted),
                ),
                Text(
                  '฿${amountToPay.toStringAsFixed(2)}',
                  style: GoogleFonts.prompt(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('บันทึกสลิปและแจ้งเตือน ${member.name} แล้ว! 💸🎉'),
                        backgroundColor: AppColors.mint,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle_rounded),
                  label: const Text('ยืนยันว่าโอนแล้ว'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mint,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton.filledTonal(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('คัดลอกเบอร์ ${member.promptPayNumber} แล้ว! 📋'),
                      backgroundColor: AppColors.primary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  );
                },
                icon: const Icon(Icons.copy_rounded, color: AppColors.textMain),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  padding: const EdgeInsets.all(14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
