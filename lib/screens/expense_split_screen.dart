import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/trip_model.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/add_expense_sheet.dart';
import '../widgets/promptpay_sheet.dart';

class ExpenseSplitScreen extends StatelessWidget {
  const ExpenseSplitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final trip = appState.activeTrip;
    final balances = appState.memberBalances;
    final totalSpent = trip.totalSpent;
    final progress = (totalSpent / trip.totalBudget).clamp(0.0, 1.0);

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (ctx) => const AddExpenseSheet(),
            );
          },
          elevation: 4,
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: Text(
            'เพิ่มค่าใช้จ่าย',
            style: GoogleFonts.prompt(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Smart Bill Share',
                              style: GoogleFonts.prompt(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textMain,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text('🧾', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        Text(
                          'หารบิลทริปอัตโนมัติ เคลียร์ยอดง่ายด้วย PromptPay',
                          style: GoogleFonts.prompt(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Active Trip Card & Budget
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on_rounded, color: Colors.white, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  trip.location,
                                  style: GoogleFonts.prompt(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${trip.members.length} คนในทริป',
                              style: GoogleFonts.prompt(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        trip.title,
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Spent amount
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ยอดใช้จ่ายรวมในทริป',
                                style: GoogleFonts.prompt(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '฿${totalSpent.toStringAsFixed(0)}',
                                style: GoogleFonts.prompt(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'งบ ฿${trip.totalBudget.toStringAsFixed(0)}',
                            style: GoogleFonts.prompt(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor: Colors.white.withValues(alpha: 0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'ใช้ไปแล้ว ${(progress * 100).toStringAsFixed(0)}% ของงบประมาณทริป',
                        style: GoogleFonts.prompt(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Balances Section (Who owes whom)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: [
                    Text(
                      '👥 สรุปยอดที่ต้องเคลียร์ / โอนคืน',
                      style: GoogleFonts.prompt(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textMain,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Member Balance Cards
            SliverToBoxAdapter(
              child: SizedBox(
                height: 155,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: trip.members.length,
                  itemBuilder: (ctx, i) {
                    final member = trip.members[i];
                    final balance = balances[member.id] ?? 0.0;
                    final isOwed = balance > 0; // Member should receive money
                    final owes = balance < 0; // Member needs to pay

                    return Container(
                      width: 175,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isOwed
                              ? AppColors.mint.withValues(alpha: 0.4)
                              : (owes ? AppColors.primary.withValues(alpha: 0.4) : AppColors.border),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage(member.avatar),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  member.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.prompt(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textMain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            isOwed ? 'รอรับคืน' : (owes ? 'ต้องโอนคืน' : 'เคลียร์ครบแล้ว'),
                            style: GoogleFonts.prompt(
                              fontSize: 11,
                              color: isOwed
                                  ? AppColors.mint
                                  : (owes ? AppColors.primary : AppColors.textMuted),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '฿${balance.abs().toStringAsFixed(0)}',
                            style: GoogleFonts.prompt(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: isOwed
                                  ? const Color(0xFF00A896)
                                  : (owes ? AppColors.primary : AppColors.textMuted),
                            ),
                          ),
                          const SizedBox(height: 6),
                          if (isOwed && member.id != 'm1')
                            SizedBox(
                              width: double.infinity,
                              height: 28,
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (ctx) => PromptPaySheet(
                                      member: member,
                                      amountToPay: balance,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.mint,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'โอนให้ ${member.name}',
                                  style: GoogleFonts.prompt(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Expense History Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
                child: Row(
                  children: [
                    Text(
                      '📋 ประวัติการจ่ายเงิน (${trip.expenses.length} รายการ)',
                      style: GoogleFonts.prompt(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textMain,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Expense History List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) {
                    final exp = trip.expenses[i];
                    final payer = trip.members.firstWhere(
                      (m) => m.id == exp.paidBy,
                      orElse: () => trip.members.first,
                    );
                    final iconInfo = _getCategoryIcon(exp.category);

                    return Dismissible(
                      key: Key(exp.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        appState.deleteExpense(exp.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('ลบรายการ "${exp.title}" แล้ว 🗑️'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: (iconInfo['color'] as Color).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Icon(iconInfo['icon'], color: iconInfo['color'], size: 22),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exp.title,
                                    style: GoogleFonts.prompt(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textMain,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Text(
                                        'จ่ายโดย ${payer.name} • หาร ${exp.splitWith.length} คน',
                                        style: GoogleFonts.prompt(
                                          fontSize: 11,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (exp.note != null) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      '📌 ${exp.note}',
                                      style: GoogleFonts.prompt(
                                        fontSize: 11,
                                        color: AppColors.primary,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '฿${exp.amount.toStringAsFixed(0)}',
                                  style: GoogleFonts.prompt(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textMain,
                                  ),
                                ),
                                Text(
                                  '~฿${(exp.amount / exp.splitWith.length).toStringAsFixed(0)}/คน',
                                  style: GoogleFonts.prompt(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: trip.expenses.length,
                ),
              ),
            ),

            // Bottom space for floating nav bar
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getCategoryIcon(ExpenseCategory cat) {
    switch (cat) {
      case ExpenseCategory.food:
        return {'icon': Icons.restaurant_rounded, 'color': AppColors.primary};
      case ExpenseCategory.stay:
        return {'icon': Icons.hotel_rounded, 'color': AppColors.purple};
      case ExpenseCategory.transport:
        return {'icon': Icons.directions_car_rounded, 'color': AppColors.sky};
      case ExpenseCategory.cafe:
        return {'icon': Icons.coffee_rounded, 'color': AppColors.pink};
      case ExpenseCategory.activity:
        return {'icon': Icons.attractions_rounded, 'color': AppColors.mint};
      case ExpenseCategory.shopping:
        return {'icon': Icons.shopping_bag_rounded, 'color': AppColors.yellow};
      case ExpenseCategory.other:
        return {'icon': Icons.more_horiz_rounded, 'color': AppColors.textMuted};
    }
  }
}
