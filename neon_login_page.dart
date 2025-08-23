import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class NeonLoginPage extends StatefulWidget {
  const NeonLoginPage({super.key});

  @override
  State<NeonLoginPage> createState() => _NeonLoginPageState();
}

class _NeonLoginPageState extends State<NeonLoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  late AnimationController _logoCtrl;
  late Animation<double> _logoScale;

  // ألوان قريبة من اللقطة
  final Color bgTop = const Color(0xFF0B1020);
  final Color bgBottom = const Color(0xFF0F1326);
  final Color fieldColor = const Color(0xFF2A2F3A);
  final Color neonCyan = const Color(0xFF40E0FF);
  final Color gradientStart = const Color(0xFFFF00C6);
  final Color gradientEnd = const Color(0xFFFFB86C);

  @override
  void initState() {
    super.initState();
    _logoCtrl =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));
    _logoScale = CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut);
    _logoCtrl.forward();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _logoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // العربية
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [bgTop, bgBottom],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              const _StarryBackground(),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // أيقونة النيون
                        ScaleTransition(
                          scale: _logoScale,
                          child: const _NeonCartIcon(size: 120),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "مرحبًا بعودتك",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 22),

                        // بطاقة زجاجية + حقول
                        _Glass(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _GlassField(
                                  hint: "البريد الإلكتروني",
                                  controller: _emailCtrl,
                                  keyboard: TextInputType.emailAddress,
                                  icon: Icons.login_rounded,
                                  fieldColor: fieldColor,
                                ),
                                const SizedBox(height: 12),
                                _GlassField(
                                  hint: "كلمة المرور",
                                  controller: _passwordCtrl,
                                  obscure: _obscure,
                                  icon: Icons.lock_outline_rounded,
                                  fieldColor: fieldColor,
                                  suffix: IconButton(
                                    onPressed: () =>
                                        setState(() => _obscure = !_obscure),
                                    icon: Icon(
                                      _obscure
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                      color: Colors.white.withOpacity(.85),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // زر متدرّج مع توهج
                        _GlowGradientButton(
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // TODO: أكشن تسجيل الدخول
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("تم الضغط على تسجيل الدخول")),
                              );
                            }
                          },
                          height: 54,
                          borderRadius: 18,
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [gradientStart, gradientEnd],
                          ),
                          child: const Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Text(
                          "تسوّق بسهولة وسرعة",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.85),
                            fontSize: 12,
                            letterSpacing: .2,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// خلفية نجوم متحركة خفيفة
class _StarryBackground extends StatefulWidget {
  const _StarryBackground();

  @override
  State<_StarryBackground> createState() => _StarryBackgroundState();
}

class _StarryBackgroundState extends State<_StarryBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final List<_Star> _stars = [];

  @override
  void initState() {
    super.initState();
    final rand = Random(42);
    for (int i = 0; i < 140; i++) {
      _stars.add(_Star(
        dx: rand.nextDouble(),
        dy: rand.nextDouble(),
        radius: rand.nextDouble() * 1.4 + 0.2,
        twinkle: rand.nextDouble() * pi,
      ));
    }
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => CustomPaint(
        painter: _StarsPainter(_stars, _ctrl.value),
        size: Size.infinite,
      ),
    );
  }
}

class _Star {
  final double dx, dy, radius, twinkle;
  _Star({required this.dx, required this.dy, required this.radius, required this.twinkle});
}

class _StarsPainter extends CustomPainter {
  final List<_Star> stars;
  final double t; // 0..1
  _StarsPainter(this.stars, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(.9);
    for (final s in stars) {
      final opacity = 0.45 + 0.45 * sin(s.twinkle + t * 2 * pi);
      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(s.dx * size.width, s.dy * size.height), s.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarsPainter oldDelegate) => oldDelegate.t != t;
}

/// طبقة زجاجية لحقول الإدخال
class _Glass extends StatelessWidget {
  final Widget child;
  const _Glass({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.06),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(.15)),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// حقل زجاجي يشبه اللقطة
class _GlassField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final Widget? suffix;
  final IconData? icon;
  final TextInputType? keyboard;
  final Color fieldColor;

  const _GlassField({
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.suffix,
    this.icon,
    this.keyboard,
    required this.fieldColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fieldColor.withOpacity(.65),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboard,
        style: const TextStyle(color: Colors.white),
        validator: (v) =>
            (v == null || v.trim().isEmpty) ? "الحقل مطلوب" : null,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(.75)),
          prefixIcon: icon == null
              ? null
              : Icon(icon, color: Colors.white.withOpacity(.85)),
          suffixIcon: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.white.withOpacity(.35), width: 1),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        ),
      ),
    );
  }
}

/// زر متدرّج مع توهج عند الضغط
class _GlowGradientButton extends StatefulWidget {
  final VoidCallback onTap;
  final double height;
  final double borderRadius;
  final Gradient gradient;
  final Widget child;

  const _GlowGradientButton({
    required this.onTap,
    required this.child,
    required this.gradient,
    this.height = 54,
    this.borderRadius = 16,
  });

  @override
  State<_GlowGradientButton> createState() => _GlowGradientButtonState();
}

class _GlowGradientButtonState extends State<_GlowGradientButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: widget.gradient,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: _pressed
              ? [
                  BoxShadow(
                    color: Colors.pinkAccent.withOpacity(.55),
                    blurRadius: 24,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.pinkAccent.withOpacity(.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}

/// أيقونة عربة نيون متوهجة (بدون أصول خارجية)
class _NeonCartIcon extends StatelessWidget {
  final double size;
  const _NeonCartIcon({this.size = 110});

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFF40E0FF);
    return Stack(
      alignment: Alignment.center,
      children: [
        // توهجات خلفية
        Container(
          width: size * 1.1,
          height: size * 1.1,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: neon, blurRadius: 60, spreadRadius: 6),
            ],
          ),
        ),
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: neon, blurRadius: 30, spreadRadius: 2),
            ],
          ),
        ),
        // رسم الأيقونة كـ "نص" لتمكين الظلال (حيلة)
        Text(
          String.fromCharCode(Icons.shopping_cart_rounded.codePoint),
          style: const TextStyle(
            fontSize: 92,
            fontFamily: 'MaterialIcons',
            color: neon,
            shadows: [
              Shadow(color: neon, blurRadius: 28),
              Shadow(color: neon, blurRadius: 18),
            ],
          ),
        ),
      ],
    );
  }
}
