//
//  LYSystemLocationManager.m
//  ToursCool
//
//  Created by tourscool on 12/4/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYSystemLocationManager.h"
#import "NSError+LYError.h"
typedef void (^LYSystemLocationCompletionHandler)(CLLocation *location, NSError *error);
typedef void (^LYSystemReverseGeocodeLocationCompletionHandler)(CLPlacemark * placemark, NSError *error);
static LYSystemLocationManager * systemLocationManager = nil;
@interface LYSystemLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CLGeocoder * geocoder;
@property (nonatomic, strong) CLLocation * userLocation;
@property (nonatomic, copy) LYSystemLocationCompletionHandler  systemLocationCompletionHandler;
@property (nonatomic, copy) LYSystemReverseGeocodeLocationCompletionHandler systemReverseGeocodeLocationCompletionHandler;
@end
@implementation LYSystemLocationManager
+ (LYSystemLocationManager *)sharedSystemLocationManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemLocationManager = [[LYSystemLocationManager alloc] init];
    });
    return systemLocationManager;
}

+ (RACSignal *)startSystemLoaction
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [LYSystemLocationManager startSystemUpdatingLocationWithCompletionHandler:^(CLLocation *location, NSError *error) {
            LYNSLog(@"%@%@", location, error);
            if (error) {
                [subscriber sendError:error];
            }else{
                [subscriber sendNext:location];
                [subscriber sendCompleted];
            }
        }];
        return nil;
    }];
}

+ (RACSignal *)startUserLocation
{
    RACSignal * loactionSignal = [LYSystemLocationManager startSystemLoaction];
    RACSignal * reverseSignal = [LYSystemLocationManager reverseGeocodeLocationWithLocation: LYSystemLocationManager.sharedSystemLocationManager.userLocation];
    return [loactionSignal then:^RACSignal * _Nonnull{
        return reverseSignal;
    }];
}

+ (RACSignal *)reverseGeocodeLocationWithLocation:(CLLocation *)location
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [LYSystemLocationManager reverseGeocodeLoctionWithLocation:location completionHandler:^(CLPlacemark *placemark, NSError *error) {
            LYNSLog(@"%@ %@ %@", placemark.name, placemark.locality, placemark.subLocality);
            if (error) {
                [subscriber sendError:error];
            }else{
                if (placemark) {
                    [subscriber sendNext:placemark];
                    [subscriber sendCompleted];
                }else{
                    [subscriber sendNext:[NSError errorWithTitle:@"错误" reason:@"获取位置失败"code:-130]];
                    [subscriber sendCompleted];
                }
            }
        }];
        return nil;
    }];
}

+ (void)reverseGeocodeLoctionWithLocation:(CLLocation *)location completionHandler:(LYSystemReverseGeocodeLocationCompletionHandler)completionHandler
{
    if (!LYSystemLocationManager.sharedSystemLocationManager.geocoder) {
        LYSystemLocationManager.sharedSystemLocationManager.geocoder = [[CLGeocoder alloc] init];
    }
    [LYSystemLocationManager.sharedSystemLocationManager.geocoder reverseGeocodeLocation:location?:LYSystemLocationManager.sharedSystemLocationManager.userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        completionHandler(placemarks.firstObject, error);
    }];
}

+ (void)startSystemUpdatingLocationWithCompletionHandler:(LYSystemLocationCompletionHandler)completionHandler
{
    LYSystemLocationManager.sharedSystemLocationManager.systemLocationCompletionHandler = completionHandler;
    if (![CLLocationManager locationServicesEnabled]) {
        LYSystemLocationManager.sharedSystemLocationManager.systemLocationCompletionHandler(nil, [NSError errorWithTitle:@"错误" reason:@"没有定位服务"code:-100]);
        return ;
    }
    if (!LYSystemLocationManager.sharedSystemLocationManager.locationManager) {
        LYSystemLocationManager.sharedSystemLocationManager.locationManager = [[CLLocationManager alloc] init];
        LYSystemLocationManager.sharedSystemLocationManager.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        LYSystemLocationManager.sharedSystemLocationManager.locationManager.distanceFilter = 10.0;
        [LYSystemLocationManager.sharedSystemLocationManager.locationManager requestAlwaysAuthorization];
        [LYSystemLocationManager.sharedSystemLocationManager.locationManager requestWhenInUseAuthorization];
        LYSystemLocationManager.sharedSystemLocationManager.locationManager.delegate = LYSystemLocationManager.sharedSystemLocationManager;
    }else{
        CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
        switch (CLstatus) {
            case kCLAuthorizationStatusAuthorizedAlways:
                break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                break;
            case kCLAuthorizationStatusDenied:
                LYSystemLocationManager.sharedSystemLocationManager.systemLocationCompletionHandler(nil, [NSError errorWithTitle:@"错误" reason:@"关闭定位权限"code:-120]);
                return;
            case kCLAuthorizationStatusNotDetermined:
                LYSystemLocationManager.sharedSystemLocationManager.systemLocationCompletionHandler(nil, [NSError errorWithTitle:@"错误" reason:@"没有定位权限"code:-110]);
                return;
            case kCLAuthorizationStatusRestricted:
                
                break;
            default:
                break;
        }
    }
    
    
    [LYSystemLocationManager.sharedSystemLocationManager.locationManager startUpdatingLocation];
}

+ (BOOL)obtainLocationAuthorizationStatus
{
    CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
    switch (CLstatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
            return YES;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return YES;
        case kCLAuthorizationStatusDenied:
            return NO;
        case kCLAuthorizationStatusNotDetermined:
            return NO;
        case kCLAuthorizationStatusRestricted:
            return NO;
        default:
            return NO;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    LYNSLog(@"didFailWithError-------------%@", error);
    if (self.systemLocationCompletionHandler) {
        self.systemLocationCompletionHandler(nil, error);
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (locations.count) {
        [manager stopUpdatingLocation];
        LYNSLog(@"didUpdateLocations-------------");
        CLLocation * location = locations.lastObject;
        self.userLocation = location;
        if (self.systemLocationCompletionHandler) {
            self.systemLocationCompletionHandler(location, nil);
        }
    }
}

@end
