# applinks_bug_app

This Flutter project serves as a debug application designed to reproduce a specific [bug](https://github.com/llfbandit/app_links/issues/118).

## Reproducing the bug

To test the application and reproduce the bug, follow these steps:

1. Run the Python server by executing `python server.py`.
2. Launch the application on an Android device.
3. Trigger the app link using adb shell with the following command:

    ```
    am start -a android.intent.action.VIEW "http://10.0.2.2:8020"
    ```
4. On the first attempt, as the app link isn't verified, the user will be prompted to select the application to handle the URL. Choose the debug app and click "Always". Clear your debug console and trigger the app link again.

After triggering the app link, you'll see the "App link triggered" print statement twice in the debug console even though you've only triggered it once.
