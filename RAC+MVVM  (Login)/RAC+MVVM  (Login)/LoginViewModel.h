//
//  LoginViewModel.h
//  RAC+MVVM  (Login)
//
//  Created by TsouMac2016 on 2018/11/26.
//  Copyright © 2018 TsouMac2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (nonatomic, strong) Account *account;
/**
 * 每次Account模型的值改变，就需要判断按钮能否点击，在VM模型中做处理，给外界提供一个能否点击按钮的信号.由于这个信号由其他两个信号决定，所以该信号此处应该聚合而成。
 */
@property (nonatomic, strong) RACSignal *enableSignal;

/**
 * 处理点击事件
 */
@property (nonatomic, strong, readonly) RACCommand *LoginCommand;

@end

NS_ASSUME_NONNULL_END
