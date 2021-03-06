# Titanium integration instructions

This document assumes you are using Titanium to target both Android and iOS.

## Integrating the SDK

* Download and extract the Tapstream Titanium SDK.
* Copy the resulting `modules` directory, and paste it into the root of your Titanium app's project directory.
* Start Titanium Studio and open your `tiapp.xml` file.
* In the `modules` pane, click the Plus button to add a new module reference.
* Select the module named `com.tapstream.sdk` and click OK.

## Importing and initializing the SDK

Import and initialize the SDK early in your code by calling Tapstream's `create` method:

    :::javascript
    var tapstream = require('com.tapstream.sdk');
    tapstream.create('TAPSTREAM_ACCOUNT_NAME', 'TAPSTREAM_SDK_SECRET', {});

## Firing extra events

By default, Tapstream fires an event whenever a user runs the app. You can define further events for recording key actions in your app by using the syntax below:

    :::javascript
    // Regular event:
    tapstream.fireEvent('test-event', false);

    // Regular event with custom parameters:
    tapstream.fireEvent('test-event', false, {
        'my-custom-param': 3,
    });

    // One-time-only event:
    tapstream.fireEvent('install', true);

    // One-time-only event with custom parameters:
    tapstream.fireEvent('install', true, {
        'my-custom-param': 'hello world',
    });

**Note**: Custom event parameters are not exposed in Tapstream's dashboard. The key/value pairs are exposed via Tapstream's postback system and Conversion API. Custom parameters are usually used for integration with a third-party ad network or your in-house dashboard or CRM.

## Changing the default behavior of the Tapstream SDK

**Note**: Changing this behavior is not usually required.

To change the default Tapstream config, provide config overrides like this:

    :::javascript
    tapstream.create('TAPSTREAM_ACCOUNT_NAME', 'TAPSTREAM_SDK_SECRET', {
        collectWifiMac: false,
        secureUdid: '<SecureUDID goes here>',
        idfa: '<IDFA goes here>',
        collectDeviceId: true,
        installEventName: 'custom-install-event-name',
    });

Consult the platform-specific SDK documentation to see what config variables are available.  Don't use accessor methods, just set the variables directly, using camel-case capitalization.
