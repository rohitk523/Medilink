import 'package:medilink_flutter/util/responsive.dart';
import 'package:medilink_flutter/widgets/dashboard_widget.dart';
import 'package:medilink_flutter/widgets/side_menu_widget.dart';
import 'package:medilink_flutter/widgets/summary_widget.dart';
import 'package:flutter/material.dart';

class PatientMainScreen extends StatelessWidget {
  const PatientMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidget(),
            )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const SummaryWidget(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              const Expanded(
                flex: 2,
                child: SizedBox(
                  child: SideMenuWidget(),
                ),
              ),
            const Expanded(
              flex: 7,
              child: DashboardWidget(),
            ),
            if (isDesktop)
              const Expanded(
                flex: 3,
                child: SummaryWidget(),
              ),
          ],
        ),
      ),
    );
  }
}
