import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class CreatePostSheet extends StatefulWidget {
  const CreatePostSheet({super.key});

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _buddyController = TextEditingController();
  
  String _selectedEmoji = '✈️';
  final List<String> _emojis = ['✈️', '🏝️', '⛰️', '☕', '🍜', '🛵', '💖', '📸'];

  bool _isLookingForBuddy = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 16,
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('📝', style: TextStyle(fontSize: 22)),
                const SizedBox(width: 8),
                Text(
                  'สร้างโพสต์รีวิว / หาเพื่อนเที่ยว',
                  style: GoogleFonts.prompt(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMain,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Select Vibe Emoji
            Text(
              'เลือก Vibe ทริป:',
              style: GoogleFonts.prompt(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _emojis.map((emoji) {
                  final isSelected = _selectedEmoji == emoji;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedEmoji = emoji),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryPastel : AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Text(emoji, style: const TextStyle(fontSize: 18)),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Content textfield
            TextField(
              controller: _contentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'เล่าความประทับใจ พิกัดลับ หรือรายละเอียดทริป...',
                hintStyle: GoogleFonts.prompt(fontSize: 14, color: AppColors.textMuted),
              ),
            ),
            const SizedBox(height: 14),

            // Location
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_rounded, color: AppColors.primary),
                hintText: 'พิกัด / จังหวัด (เช่น เกาะกูด, ตราด)',
              ),
            ),
            const SizedBox(height: 12),

            // Budget
            TextField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.attach_money_rounded, color: AppColors.mint),
                hintText: 'งบประมาณโดยประมาณ / คน (บาท)',
              ),
            ),
            const SizedBox(height: 14),

            // Looking for buddy switch
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                '👫 กำลังหาเพื่อนร่วมทริปหารค่าใช้จ่าย',
                style: GoogleFonts.prompt(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              value: _isLookingForBuddy,
              activeThumbColor: AppColors.primary,
              onChanged: (val) => setState(() => _isLookingForBuddy = val),
            ),

            if (_isLookingForBuddy) ...[
              TextField(
                controller: _buddyController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.group_add_rounded, color: AppColors.primary),
                  hintText: 'เช่น รับอีก 2 คน (หารค่าน้ำมัน+ที่พัก)',
                ),
              ),
              const SizedBox(height: 12),
            ],

            const SizedBox(height: 16),

            // Post Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_contentController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('กรุณากรอกข้อความก่อนโพสต์น้า ✍️'),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    );
                    return;
                  }

                  final appState = Provider.of<AppState>(context, listen: false);
                  final budget = int.tryParse(_budgetController.text.trim());
                  
                  appState.addCommunityPost(
                    content: _contentController.text.trim(),
                    location: _locationController.text.trim(),
                    tags: ['#GoGoThai', '#รีวิวเที่ยวไทย', '#เพื่อนเที่ยว'],
                    budget: budget,
                    buddyStatus: _isLookingForBuddy ? (_buddyController.text.isEmpty ? 'หาเพื่อนเที่ยว' : _buddyController.text) : null,
                    vibeEmoji: _selectedEmoji,
                  );

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('แชร์โพสต์ไปยังฟีด GoGoThai สำเร็จ! 🎉'),
                      backgroundColor: AppColors.mint,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  );
                },
                icon: const Icon(Icons.send_rounded),
                label: const Text('แชร์ลงคอมมูนิตี้'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
