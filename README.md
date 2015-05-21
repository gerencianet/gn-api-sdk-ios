# gn-api-sdk-ios

A simple lib for easy integration of your mobile app with the payment services 
provided by [Gerencianet](http://gerencianet.com.br).

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

Import the sdk header file with ```#import "GNApiSdk.h"``` or ```#import <GNApi-Sdk-iOS/GNApiSdk.h>``` you are using CocoaPods.

Instantiate a `GNConfig` object and set your credentials:

```objective-c
GNConfig *gnConfig = [[GNConfig alloc] initWithClientId:@"YOUR_CLIENT_ID" clientSecret:@"YOUR_CLIENT_SECRET"];
```

If you're testing, set the sandbox flag to ```YES```:

```objective-c
gnConfig.sandbox = YES;
```

Create an `GNApiEndpoints` instance passing your `GNConfig`:
```objective-c
GNApiEndpoints *gnApi = [[GNApiEndpoints alloc] initWithConfig:gnConfig];
``` 

To receive a payment token you need to create a `GNCreditCard` object and call `paymentTokenForCreditCard:` or `paymentTokenForCreditCard:completion:`:

```objective-c
GNCreditCard *creditCard = [[GNCreditCard alloc] init];
creditCard.number = @"4012001038443335";
creditCard.brand = kGNMethodTypeVisa;
creditCard.expirationMonth = @"05";
creditCard.expirationYear = @"2018";
creditCard.cvv = @"123";

[gnApi paymentTokenForCreditCard:creditCard completion:^(GNPaymentToken *paymentToken, GNError *error) {
    if(!error){
        NSLog(@"%@", paymentToken.token);
    }
}
```

> `GNApiEndpoints` provides two signatures for each api method.
> So you can use either blocks or delegates to receive callbacks.

You can also get the installments before getting the payment token. 
All you need is the total amount and the method type:

```objective-c
GNMethod *method = [[GNMethod alloc] initWithType:kGNMethodTypeMasterCard total:@(1000)];
[_gnApi fetchPaymentDataWithMethod:method];
```

If you want to get the payment data for a banking billet instead of a credit card you just need to init the `GNMethod` object with the type `kGNMethodTypeBankingBillet`.

The available method types are defined in the following constants:

* ```kGNMethodTypeVisa```
* ```kGNMethodTypeMasterCard```
* ```kGNMethodTypeAmex```
* ```kGNMethodTypeDiners```
* ```kGNMethodTypeDiscover```
* ```kGNMethodTypeJCB```
* ```kGNMethodTypeElo```
* ```kGNMethodTypeAura```
* ```kGNMethodTypeBankingBillet```

This project already includes a sample application.
To use it just clone this repo, install dependencies with `pod install` and open with XCode. The example requires you to provide your API credentials.

## License

[The MIT License (MIT)](http://opensource.org/licenses/MIT)

    The MIT License (MIT)

    Copyright (c) 2015 Gerencianet

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.