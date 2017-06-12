//
//  XQAlertView.h
//  MPhoto
//
//  Created by 徐强 on 2017/5/25.
//  Copyright © 2017年 徐强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XQAlertView : NSObject
/**
 *object:iOS8以后，必传Controller，其他系统传View，不能为空
 */
+(void)createSheetWithTitle:(NSString *)title handler:(void (^)(NSString * type))selectorAction object:(id)object cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles,...NS_REQUIRES_NIL_TERMINATION;
/**
 *object:iOS8以后，必传Controller，其他系统随便，不能为空
 */
+(void)creatAlertView:(NSString *)title message:(NSString *)message cancel:(NSString *)cancelTitle sure:(NSString *)sureTitle handler:(void(^)(NSString * type))selectorAction delegate:(id)object otherButtonTitles:(NSString *)otherButtonTitles,...NS_REQUIRES_NIL_TERMINATION;

@end


