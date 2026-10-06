import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/trip_model.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  ExpenseCategory _selectedCategory = ExpenseCategory.food;
  String _paidById = 'm1';
  final List<String> _selectedMembers = ['m1', 'm2', 'm3', 'm4'];

  final Map<ExpenseCategory, Map<String, dynamic>> _catData = {
    ExpenseCategory.food: {'icon': Icons.restaurant_rounded, 'name': 'อาหาร & เครื่องดื่ม', 'color': AppColors.primary},
    ExpenseCategory.stay: {'icon': Icons.hotel_rounded, 'name': 'ที่พัก & โรงแรม', 'color': AppColors.purple},
    ExpenseCategory.transport: {'icon': Icons.directions_car_rounded, 'name': 'การเดินทาง/น้ำมัน', 'color': AppColors.sky},
    ExpenseCategory.cafe: {'icon': Icons.coffee_rounded, 'name': 'คาเฟ่ & ขนมหวาน', 'color': AppColors.pink},
    ExpenseCategory.activity: {'icon': Icons.attractions_rounded, 'name': 'กิจกรรม & ค่าเข้า', 'color': AppColors.mint},
    ExpenseCategory.shopping: {'icon': Icons.shopping_bag_rounded, 'name': 'ช้อปปิ้ง & ของฝาก', 'color': AppColors.yellow},
    ExpenseCategory.other: {'icon': Icons.more_horiz_rounded, 'name': 'อื่นๆ', 'color': AppColors.textMuted},
  };

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final members = appState.tripMembers;

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
                const Text('💸', style: TextStyle(fontSize: 22)),
                const SizedBox(width: 8),
                Text(
                  'เพิ่มรายการแชร์ค่าใช้จ่าย',
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

            // Amount Input (Big & Cute)
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: GoogleFonts.prompt(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixText: '฿ ',
                prefixStyle: GoogleFonts.prompt(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.primary),
                hintText: '0.00',
                fillColor: AppColors.primaryPastel.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 14),

            // Title
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.receipt_long_rounded, color: AppColors.textMuted),
                hintText: 'ชื่อรายการ (เช่น มื้อเย็นส้มตำ, ค่าน้ำมัน)',
              ),
            ),
            const SizedBox(height: 14),

            // Category Selector
            Text(
              'หมวดหมู่:',
              style: GoogleFonts.prompt(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textMuted),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ExpenseCategory.values.map((cat) {
                  final data = _catData[cat]!;
                  final isSelected = _selectedCategory == cat;
                  final color = data['color'] as Color;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? color.withValues(alpha: 0.18) : AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? color : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(data['icon'] as IconData, size: 16, color: color),
                          const SizedBox(width: 6),
                          Text(
                            data['name'] as String,
                            style: GoogleFonts.prompt(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? color : AppColors.textMain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Who Paid Selector
            Text(
              'ใครเป็นคนจ่ายก่อน:',
              style: GoogleFonts.prompt(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textMuted),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: members.map((m) {
                  final isSelected = _paidById == m.id;
                  return GestureDetector(
                    onTap: () => setState(() => _paidById = m.id),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.mintLight : AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColors.mint : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(radius: 12, backgroundImage: NetworkImage(m.avatar)),
                          const SizedBox(width: 6),
                          Text(
                            m.name,
                            style: GoogleFonts.prompt(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? AppColors.mint : AppColors.textMain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Split with (checkbox / chips)
            Text(
              'หารกับใครบ้าง:',
              style: GoogleFonts.prompt(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textMuted),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: members.map((m) {
                final isIncluded = _selectedMembers.contains(m.id);
                return FilterChip(
                  label: Text(m.name),
                  selected: isIncluded,
                  selectedColor: AppColors.primaryPastel,
                  checkmarkColor: AppColors.primary,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedMembers.add(m.id);
                      } else {
                        if (_selectedMembers.length > 1) {
                          _selectedMembers.remove(m.id);
                        }
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final amount = double.tryParse(_amountController.text.trim()) ?? 0;
                  final title = _titleController.text.trim();

                  if (amount <= 0 || title.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('กรุณากรอกชื่อรายการและจำนวนเงินที่ถูกต้อง 💡'),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    );
                    return;
                  }

                  appState.addExpense(
                    title: title,
                    amount: amount,
                    category: _selectedCategory,
                    paidById: _paidById,
                    splitWithIds: _selectedMembers,
                    note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
                  );

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('บันทึกยอด ฿$amount และคำนวณบิลเรียบร้อย! 🧾✨'),
                      backgroundColor: AppColors.mint,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: const Text('บันทึกค่าใช้จ่าย & คำนวณบิล'),
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
