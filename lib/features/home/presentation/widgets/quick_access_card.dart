import 'package:flutter/material.dart';

class QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const QuickAccessCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
  
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Container(
              width: 55, 
              height: 55, 
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon, 
                size: 28, 
                color: colorScheme.primary,
              ),
            ),
            
            const SizedBox(height: 8), 
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2, 
                overflow: TextOverflow.visible, 
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                      fontSize: 13, 
                      height: 1.1,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}