//
//  FSJNetWorking.h
//  FSJ
//
//  Created by Monstar on 16/3/3.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, NetworkConnectionActionType){
    /**
     *   注册
     */
    registerAction,
    
    /**
     *   登录
     */
    loginAction,

    /**
     *   忘记密码
     */
    forgetPassword,
    
    /**
     *   修改密码
     */
    changePassword,
    
   };
typedef NS_ENUM(NSInteger, UploadActionType) {
    UserHeaderImageAction = 1 <<4,
};

typedef void(^UploadFormDataBlock) (id<AFMultipartFormData> formData);
@interface WSQNetWorking : AFHTTPRequestOperationManager

//POST请求数据
+ (void)networkingPOSTWithActionType:(NetworkConnectionActionType)actionType
                   requestDictionary:(NSDictionary *)requestDictionary
                             success:(void (^)(NSDictionary *responseObject))success
                             failure:(void (^)(NSError *error))failure;


//图片上传
+ (void)uploadDataWithActionType:(NetworkConnectionActionType)actionType
               requestDictionary:(NSDictionary *)requestDictionary
                  uploadFormData:(NSData *)imageData
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSString *error))failure;

+ (NSString *)actionWithConnectionActionType:(NetworkConnectionActionType)actionType;

@end
