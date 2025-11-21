import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Блок с именем пользователя
            _buildUserInfo(context),
            const SizedBox(height: 32.0),

            // 2. Блок настроек
            _buildSettingsSection(context),
            const SizedBox(height: 32.0),

            // 3. Блок юридической информации
            _buildLegalSection(context),
            const SizedBox(height: 32.0),

            // 4. Кнопка выхода
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }
  // ... внутри ProfileScreen

  Widget _buildUserInfo(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.person, size: 40, color: Colors.white),
        ),
        SizedBox(height: 12.0),
        Text(
          'Имя пользователя',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'ID клиента: 123456789',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
  Widget _buildLegalSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Информация',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(),
        _buildProfileTile(
          title: 'О банке Eldik',
          icon: Icons.info,
          onTap: () {},
        ),
        _buildProfileTile(
          title: 'Политика конфиденциальности',
          icon: Icons.policy,
          onTap: () {},
        ),
      ],
    );
  }
  // ... внутри ProfileScreen

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Настройки',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(),
        _buildProfileTile(
          title: 'Изменить личные данные',
          icon: Icons.edit_note,
          onTap: () {
            // Здесь будет переход на экран редактирования
          },
        ),
        _buildProfileTile(
          title: 'Безопасность и пароли',
          icon: Icons.security,
          onTap: () {
            // Здесь будет переход на экран безопасности
          },
        ),
        _buildProfileTile(
          title: 'Уведомления',
          icon: Icons.notifications,
          onTap: () {
            // Здесь будет переход на экран уведомлений
          },
        ),
      ],
    );
  }
  // ... внутри ProfileScreen

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout),
        label: const Text('Выйти'),
        onPressed: () {
          // !!! Здесь будет логика выхода (BlocProvider.of<AuthBloc>(context).add(LogoutEvent()))
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Выход из системы')),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.red, // Текст красного цвета
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Colors.red, width: 1.5),
          ),
          backgroundColor: Colors.white, // Фон белый
          elevation: 0,
        ),
      ),
    );
  }
  // ... внутри ProfileScreen

  Widget _buildProfileTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}