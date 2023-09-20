class LoginScreen extends StatefulWidget {
  final ApiService apiService;

  LoginScreen(this.apiService);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleLogin() async {
    final username = usernameController.text;
    final password = passwordController.text;

    try {
      final user = await widget.apiService.login(username, password);
      // Handle successful login, e.g., navigate to the home screen.
      // You can store the user data in a global state or elsewhere as needed.
    } catch (e) {
      // Handle login failure, e.g., show an error message.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleLogin,
              child: Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
