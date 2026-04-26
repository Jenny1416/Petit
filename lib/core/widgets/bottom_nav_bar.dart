import 'package:flutter/material.dart';
import '../../app/router/app_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Detectamos la ruta actual para saber qué icono resaltar
    final currentRoute = ModalRoute.of(context)?.settings.name;

    int currentIndex = 0;
    if (currentRoute == AppRouter.home) currentIndex = 0;
    if (currentRoute == AppRouter.wishlist) currentIndex = 1;
    if (currentRoute == AppRouter.cart) currentIndex = 2;
    if (currentRoute == AppRouter.orders) currentIndex = 3;
    if (currentRoute == AppRouter.settings) currentIndex = 4;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF32B56A),
      unselectedItemColor: const Color(0xFF666666),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (index) {
        if (index == 0) {
          // Si presionamos Inicio, siempre navegamos al home (limpiando el stack de categorías)
          Navigator.pushNamedAndRemoveUntil(context, AppRouter.home, (route) => false);
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, AppRouter.wishlist);
        }
        // Puedes añadir aquí el resto de casos (carrito, etc.) cuando las rutas existan
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'Deseos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Carrito',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          activeIcon: Icon(Icons.receipt_long),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: 'Configuración',
        ),
      ],
    );
  }
}
