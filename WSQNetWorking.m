//
//  WSQNetWorking.m
//  WSQ
//
//  Created by Monstar on 16/3/3.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "WSQNetWorking.h"
#import <CommonCrypto/CommonCrypto.h>

@interface WSQNetWorking()
@end

@implementation WSQNetWorking

#pragma mark --POST

+ (void)networkingPOSTWithActionType:(NetworkConnectionActionType)actionType requestDictionary:(NSDictionary *)parameters success:(void (^)(NSDictionary *responseObject))success failure:(void (^)( NSError *error))failure {
    //初始化网络请求类
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //设置请求超时时间
    manager.requestSerializer.timeoutInterval = 15;
    //设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置MIME类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil]];
    NSString *URL = [NSString stringWithFormat:@"%@",[self actionWithConnectionActionType:actionType]];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark --上传图片
+ (void)uploadDataWithActionType:(NetworkConnectionActionType)actionType
               requestDictionary:(NSDictionary *)requestDictionary
                  uploadFormData:(NSData *)imageData
                         success:(void (^)(id))success
                         failure:(void (^)(NSString *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString  *URL =[self actionWithConnectionActionType:actionType];
    [manager POST:URL parameters:requestDictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"imageLogo.jpeg"mimeType:@"image/jpeg"];
//        //多图上传
//        for (NSInteger i = 0; i < imageData.count; i++) {
//            [formData appendPartWithFileData:imageData[i] name:@"file" fileName:[NSString stringWithFormat:@"image_%ld.jpg",(long)i] mimeType:@"image/jpeg"];
//        }
        
    } success:^(AFHTTPRequestOperation * operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        if (error) {
            failure(error.description);
        }
    }];
}

+ (NSString *)actionWithConnectionActionType:(NetworkConnectionActionType)actionType{
    NSString *url = [[NSString alloc]init];
    switch (actionType) {
        case registerAction:
            url = @"register/save";
            break;
        case loginAction:
            url = @"register/login";
            break;
        case forgetPassword:
            url = @"register/forgetPassword";
            break;
        case changePassword:
            url = @"register/changePassword";
                break;
        default:
            break;
    }
    NSString *resultUrl = [[NSString alloc]init];
    resultUrl = [NSString stringWithFormat:@"http://192.168.199.254:8080/annie/%@",url];
    return resultUrl;


@end
