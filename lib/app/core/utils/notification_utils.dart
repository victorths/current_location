import '../commons.dart';

void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      dismissDirection: DismissDirection.none,
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height -
            MediaQuery.of(context).size.height / 4,
        right: 16,
        left: 16,
      ),
    ),
  );
}
