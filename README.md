# gn-api-sdk-ios

A simple lib for easy integration of your mobile app with the payment services 
provided by [Gerencianet](http://gerencianet.com.br).

:warning: **This module is under development and is based on the new API that Gerencianet is about to release. It won't work in production by now.**

[![Build Status](https://travis-ci.org/gerencianet/gn-api-sdk-ios.svg)](https://travis-ci.org/gerencianet/gn-api-sdk-ios)
[![Coverage Status](https://coveralls.io/repos/gerencianet/gn-api-sdk-ios/badge.svg)](https://coveralls.io/r/gerencianet/gn-api-sdk-ios)
[![Pod version](https://cocoapod-badges.herokuapp.com/v/GNApi-Sdk-iOS/badge.png)](https://cocoapods.org/pods/GNApi-Sdk-iOS)

### Requirements
* iOS 7.0+
* ARC

### Dependencies
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)

### Installation
**Via [CocoaPods](http://cocoapods.org):**

```ruby
pod 'GNApi-Sdk-iOS', '~> 0.2'
```

**Direct download:**

Drag the `GNApiSdk/` folder to you project and install dependencies.

### Documentation

Import the sdk header file with ```#import "GNApiSdk.h"``` or ```#import <GNApi-Sdk-iOS/GNApiSdk.h>``` if you are using CocoaPods.

Instantiate a `GNConfig` object defining your account code. If you're in development phase, set the sandbox flag to ```YES```:

```objective-c
GNConfig *gnConfig = [[GNConfig alloc] initWithAccountCode:@"YOUR_ACCOUNT_CODE" sandbox:YES];
```

Create an `GNApiEndpoints` instance passing your `GNConfig`:
```objective-c
GNApiEndpoints *gnApi = [[GNApiEndpoints alloc] initWithConfig:gnConfig];
``` 

To receive a payment token you need to create a `GNCreditCard` object and call `paymentTokenForCreditCard:` or `paymentTokenForCreditCard:completion:`:

```objective-c
GNCreditCard *creditCard = [[GNCreditCard alloc] init];
creditCard.number = @"4012001038443335";
creditCard.brand = kGNMethodBrandVisa;
creditCard.expirationMonth = @"05";
creditCard.expirationYear = @"2018";
creditCard.cvv = @"123";

[gnApi paymentTokenForCreditCard:creditCard completion:^(GNPaymentToken *paymentToken, GNError *error) {
    if(!error){
        NSLog(@"%@", paymentToken.token);
    }
}];
```

> `GNApiEndpoints` provides two signatures for each api method.
> So you can use either blocks or delegates to receive callbacks.
> An example of how to use the `GNApiEndpointsDelegate` protocol can be found in the `Example/` directory.

You can also get the installments before getting the payment token. 
All you need is the total amount and the method brand:

```objective-c
// The following code will fetch installments for a total of R$10,00 with MasterCard card brand.
GNMethod *method = [[GNMethod alloc] initWithBrand:kGNMethodBrandMasterCard total:@(1000)];
[_gnApi fetchPaymentDataWithMethod:method];
```

If you want to get the payment data for a banking billet instead of a credit card you just need to init the `GNMethod` object with the brand `kGNMethodBrandBankingBillet`.

The available method brands are defined in the following constants:

* ```kGNMethodBrandVisa```
* ```kGNMethodBrandMasterCard```
* ```kGNMethodBrandAmex```
* ```kGNMethodBrandDiners```
* ```kGNMethodBrandDiscover```
* ```kGNMethodBrandJCB```
* ```kGNMethodBrandElo```
* ```kGNMethodBrandAura```
* ```kGNMethodBrandBankingBillet```

This project already includes a sample application.
To use it just clone this repo, install dependencies with `pod install` and open with XCode. The example requires you to provide your account code.

## License

[MIT](https://github.com/gerencianet/gn-api-sdk-ios/blob/master/LICENSE)