// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_uis/MiniApps/HotAirBalloons/Screens/DetailScreen/TestKeys.dart';
import 'package:flutter_uis/MiniApps/HotAirBalloons/data/TestKeys.dart';
import 'package:test/test.dart';

import 'package:flutter_uis/screens/Home/TestKeys.dart';
import 'package:flutter_uis/Widgets/Screen/TestKeys.dart';
import 'package:flutter_uis/screens/UIDetail/TestKeys.dart';
import 'package:flutter_uis/statics/data/uiListTestKeys.dart';
import 'package:flutter_uis/MiniApps/HealtyFoodDelivery/Screens/HomeScreen/TestKeys.dart';

import 'screenshot.dart';
import 'actions.dart';
import 'utils.dart';

void main() async {
  group('Counter App', () {
    FlutterDriver driver;
    double width;
    double height;

    setUpAll(() async {
      driver = await FlutterDriver.connect();

      final platform = await driver.requestData("platform");
      final dimensions = (await driver.requestData("dimensions")).split(",");

      width = double.parse(dimensions[0]);
      height = double.parse(dimensions[1]);

      Utils.driver = driver;
      TestActions.driver = driver;
      Screenshot.driver = driver;
      Screenshot.platform = platform;

      await Utils.init(platform);
      await TestActions.delay(1000);

      await driver.clearTimeline();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver?.close();
    });

    // test('Chunk testing', () async {
    //   await driver.runUnsynchronized(() async {});
    // }, timeout: Timeout.none);

    // return;

    test(
      'ScreenShots',
      () async {
        await driver.runUnsynchronized(() async {
          if (Utils.isDesktop || Utils.isWeb) {
            await Screenshot.screenshot("Home-Screen-Modal");
            await TestActions.tap(HomeScreenTestKeys.modalContinueBtn);
          }
          // Home Screen
          await Screenshot.screenshot("Home-Screen");
          await TestActions.tap(HomeScreenTestKeys.settingsBtn);
          print("Home Screen Complete");

          // Settings Modal
          await Screenshot.screenshot("Settings-Modal");
          await TestActions.tap(ScreenWidgetTestKeys.close);
          print("Settings Modal Complete");

          // Download Screen
          await TestActions.delay(1000);
          await TestActions.tap(HomeScreenTestKeys.downloadBtn);
          await Screenshot.screenshot("Download-Screen");
          await driver.requestData("nav_go_back");
          print("Download Screen Complete");

          // About Developer Screen
          await TestActions.delay(1000);
          await TestActions.tap(HomeScreenTestKeys.aboutDeveloperBtn);
          await Screenshot.screenshot("AboutDeveloper-Screen");
          await driver.requestData("nav_go_back");
          print("About Developer Complete");

          // About App Screen
          await TestActions.delay(1000);
          await TestActions.tap(HomeScreenTestKeys.aboutBtn);
          await Screenshot.screenshot("AboutApp-Screen");
          await driver.requestData("nav_go_back");
          print("About App Complete");

          // Explore UIs Screen
          await TestActions.delay(1000);
          await TestActions.tap(HomeScreenTestKeys.uiListBtn);
          await Screenshot.screenshot("ExploreUIs-Screen");
          print("Explores UIs Complete");

          // Mini App HFD Flow
          await TestActions.delay(1000);
          await TestActions.tap(UIListDataTestKeys.hfd);
          await Screenshot.screenshot("HFD-Detail-Screen");
          await TestActions.tap(UIDetailScreenTestKeys.openApp);

          // Mini App HFD Home Screen
          await Screenshot.screenshot("HFD-Home-Screen-1");
          await driver.scrollUntilVisible(
            find.byValueKey(HFDHomeScreenTestKeys.foodItemsScroll),
            find.byValueKey(HFDHomeScreenTestKeys.foodItem9),
            dxScroll: -140,
            dyScroll: 0.0,
            timeout: Duration(seconds: 30),
          );
          await Screenshot.screenshot("HFD-Home-Screen-2");
          await driver.scrollUntilVisible(
            find.byValueKey(HFDHomeScreenTestKeys.restaurantScroll),
            find.byValueKey(HFDHomeScreenTestKeys.restaurant5),
            dxScroll: -360,
            dyScroll: 0.0,
            timeout: Duration(seconds: 30),
          );
          await TestActions.tap(HFDHomeScreenTestKeys.restaurant5);
          await Screenshot.screenshot("HFD-Home-Screen-3");

          // Mini App HFD Detail Screen
          await TestActions.tap(HFDHomeScreenTestKeys.foodItem9);
          await Screenshot.screenshot("HFD-Detail-Screen");
          await driver.requestData("nav_go_back");
          await driver.requestData("nav_go_back");
          await driver.requestData("nav_go_back");
          print("Mini App HFD Complete");

          // Mini App HAB Home Screen
          await TestActions.tap(UIListDataTestKeys.hab);
          await TestActions.tap(UIDetailScreenTestKeys.openApp);
          await Screenshot.screenshot("HAB-Home-Screen");

          // Mini App HAB Detail Screen
          await TestActions.tap(HABRootTestKeys.standard);
          await Screenshot.screenshot("HAB-Detail-Screen-1");
          await driver.scroll(
            find.byValueKey(HABDetailScreenTestKeys.rootPageView),
            -width * 0.9,
            0.0,
            Duration(milliseconds: 400),
          );
          await TestActions.delay(1000);
          await Screenshot.screenshot("HAB-Detail-Screen-2");
          await driver.scroll(
            find.byValueKey(HABDetailScreenTestKeys.rootPageView),
            -width * 0.9,
            0.0,
            Duration(milliseconds: 400),
          );
          await TestActions.delay(1000);
          TestActions.tap(HABDetailScreenTestKeys.tabPreFlightInfo);
          await Screenshot.screenshot("HAB-Detail-Screen-3");
          TestActions.tap(HABDetailScreenTestKeys.tabPostFlightInfo);
          await Screenshot.screenshot("HAB-Detail-Screen-4");
          TestActions.tap(HABDetailScreenTestKeys.tabInFlightInfo);
          await driver.requestData("nav_go_back");
          await driver.requestData("nav_go_back");
          await driver.requestData("nav_go_back");
          print("Mini App HAB Complete");

          // Mini App SKV Home Screen

          await TestActions.delay(2000);
        });
      },
      timeout: Timeout.none,
    );
  });
}
