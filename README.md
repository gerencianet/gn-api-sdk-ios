# gn-api-sdk-ios

A simple lib for easy integration of your mobile app with the payment services 
provided by [Gerencianet](http://gerencianet.com.br).

## Requirements

* iOS 7.0+
* ARC

## Installation

Via [CocoaPods](http://cocoapods.org):
```ruby
pod 'GNApi-Sdk-iOS', '~> 0.2'
```

Direct download:

Drag the `GNApiSdk/` folder to you project and install [AFNetworking](https://github.com/AFNetworking/AFNetworking)


## Documentation

Instantiate a `GNConfig` object and set your credentials:

```objective-c
GNConfig *gnConfig = [[GNConfig alloc] initWithClientId:@"YOUR-CLIENT-ID" clientSecret:@"YOUR-CLIENT-SECRET"];
```

If you're testing, set the sandbox flag to true:

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
creditCard.brand = kGNMethodNameVisa;
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
All you need is the total amount and the card brand:

```objective-c
GNMethod *method = [[GNMethod alloc] initWithName:kGNMethodNameMasterCard total:@(1000)];
[gnApi fetchPaymentMethods:method];
```

If you want to generate a boleto instead of paying with a credit card you just need to init the `GNMethod` object with the name `kGNMethodNameBoleto`.

This project already includes a sample application.
To use it just clone this repo, install dependencies with `pod install` and open with XCode.

## License

[Apache Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)

    Copyright (C) 2015 Gerencianet

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.