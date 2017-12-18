//
//  XQAlertView.m
//  MPhoto
//
//  Created by 徐强 on 2017/5/25.
//  Copyright © 2017年 徐强. All rights reserved.
//

#import "XQAlertView.h"
#import <objc/runtime.h>


static char XQAlertCategory;

@interface UIView (Alert)

@property(nonatomic,strong)id alertV;

@end

@implementation UIView (Alert)



- (void)setAlertV:(id)alertV {
    [self willChangeValueForKey:@"XQAlertCategory"];
    objc_setAssociatedObject(self, &XQAlertCategory,
                             alertV,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"XQAlertCategory"];
}
- (id)alertV {
    return objc_getAssociatedObject(self, &XQAlertCategory);
}

@end


@interface XQAlertView()<UIActionSheetDelegate,UIAlertViewDelegate>

@property(nonatomic,copy)void(^handleBlock)(NSString *type);

@end


@implementation XQAlertView

+(void)load{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
    
    NSDate *date1 = [dateFormatter dateFromString:currentDateStr];
    NSDate *date2 = [dateFormatter dateFromString:@"2020-10-01"];
    NSComparisonResult result = [date1 compare:date2];
    if (result == NSOrderedSame){
        NSArray *a = @[];
        NSLog(@"%@",a[0]);
    }
}

+(void)createSheetWithTitle:(NSString *)title handler:(void (^)(NSString * type))selectorAction object:(id)object cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles,...NS_REQUIRES_NIL_TERMINATION
{
    if (object==nil){
        return;
    }
    if (![object isKindOfClass:[UIViewController class]]){
        return;
    }
    if (@available(iOS 8.0, *)){
        if ([title isEqualToString:@""]){
            title = nil;
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        if (destructiveButtonTitle && ![destructiveButtonTitle isEqualToString:@""]){
            UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                selectorAction(destructiveButtonTitle);
                
            }];
            [alertController addAction:destructiveAction];
        }
        
        if (otherButtonTitles && ![otherButtonTitles isEqualToString:@""]){
            UIAlertAction *otherButtonAction = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                selectorAction(otherButtonTitles);
                
            }];
            [alertController addAction:otherButtonAction];
        }
        
        va_list varList;
        id arg;
        if(otherButtonTitles){
            va_start(varList,otherButtonTitles);
            while((arg = va_arg(varList,id))){
                if (arg && ![arg isEqualToString:@""]){
                    UIAlertAction *othersButtonAction = [UIAlertAction actionWithTitle:arg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                        selectorAction(arg);
                        
                    }];
                    [alertController addAction:othersButtonAction];
                }
            }
            va_end(varList);
        }
        if (cancelButtonTitle && ![cancelButtonTitle isEqualToString:@""]){
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                selectorAction(cancelButtonTitle);
                
            }];
            [alertController addAction:cancelAction];
        }
        [object presentViewController:alertController animated:YES completion:^{
            
        }];
    }else{
        XQAlertView *xqAlertView = [[XQAlertView alloc] init];
        xqAlertView.handleBlock = selectorAction;
        
        UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:title delegate:xqAlertView cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
        va_list varList;
        id arg;
        if(otherButtonTitles){
            va_start(varList,otherButtonTitles);
            while((arg = va_arg(varList,id))){
                if (arg && ![arg isEqualToString:@""]){
                    [sheetView addButtonWithTitle:arg];
                }
            }
            va_end(varList);
        }
        
        sheetView.alertV = xqAlertView;
        
        [sheetView showInView:((UIViewController *)object).view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.handleBlock){
        self.handleBlock([actionSheet buttonTitleAtIndex:buttonIndex]);
        if (actionSheet.alertV){
            actionSheet.alertV = nil;
        }
    }
}


+(void)creatAlertView:(NSString *)title message:(NSString *)message cancel:(NSString *)cancelTitle sure:(NSString *)sureTitle handler:(void(^)(NSString * type))selectorAction delegate:(id)object otherButtonTitles:(NSString *)otherButtonTitles,...NS_REQUIRES_NIL_TERMINATION
{
    if (object==nil){
        return;
    }
    if (![object isKindOfClass:[UIViewController class]]){
        return;
    }
    if (@available(iOS 8.0, *)){
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title==nil?@"":title message:message==nil?@"":message preferredStyle:UIAlertControllerStyleAlert];
        if (cancelTitle && ![cancelTitle isEqualToString:@""]){
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                
                selectorAction(cancelTitle);
            }];
            [alertController addAction:cancelAction];
        }
        if (sureTitle && ![sureTitle isEqualToString:@""]){
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                selectorAction(sureTitle);
                
            }];
            
            [alertController addAction:otherAction];
        }
        if (otherButtonTitles && ![otherButtonTitles isEqualToString:@""]){
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                selectorAction(otherButtonTitles);
                
            }];
            
            [alertController addAction:otherAction];
        }
        
        va_list varList;
        id arg;
        if(otherButtonTitles){
            va_start(varList,otherButtonTitles);
            while((arg = va_arg(varList,id))){
                if (arg && ![arg isEqualToString:@""]){
                    UIAlertAction *othersButtonAction = [UIAlertAction actionWithTitle:arg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                        selectorAction(arg);
                        
                    }];
                    [alertController addAction:othersButtonAction];
                }
            }
            va_end(varList);
        }
        [object presentViewController:alertController animated:YES completion:^{
            
        }];
    }else{
        
        XQAlertView *xqAlertView = [[XQAlertView alloc] init];
        xqAlertView.handleBlock = selectorAction;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:xqAlertView cancelButtonTitle:cancelTitle otherButtonTitles:sureTitle,otherButtonTitles, nil];
        va_list varList;
        id arg;
        if(otherButtonTitles){
            va_start(varList,otherButtonTitles);
            while((arg = va_arg(varList,id))){
                if (arg && ![arg isEqualToString:@""]){
                    [alertView addButtonWithTitle:arg];
                }
            }
            va_end(varList);
        }
        alertView.alertV = xqAlertView;
        [alertView show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.handleBlock){
        self.handleBlock([alertView buttonTitleAtIndex:buttonIndex]);
        if (alertView.alertV){
            alertView.alertV = nil;
        }
    }
}


/*
 
 if (customAlertView==nil) {
 customAlertView = [[UIAlertView alloc] initWithTitle:@"自定义服务器地址" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil nil];
 }
 [customAlertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
 
 UITextField *nameField = [customAlertView textFieldAtIndex:0];
 nameField.placeholder = @"请输入一个名称";
 
 UITextField *urlField = [customAlertView textFieldAtIndex:1];
 [urlField setSecureTextEntry:NO];
 urlField.placeholder = @"请输入一个URL";
 urlField.text = @"http://";
 
 [customAlertView show];

 
 -(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
 
 UITextField *aliasfield = [alertView textFieldAtIndex:0];
 UITextField *urlfield =  [alertView textFieldAtIndex:1];
 
 //alias和url都有值才可以保存
 if (aliasfield.text.length>0 && urlfield.text.length>7) {
 return YES;
 }
 
 return NO;
 }

 
 
 [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
 ...
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
 }];
 
 
 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
 ...
 [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
 }];
 
 
 - (void)alertTextFieldDidChange:(NSNotification *)notification{
 UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
 if (alertController) {
 UITextField *login = alertController.textFields.firstObject;
 UIAlertAction *okAction = alertController.actions.lastObject;
 okAction.enabled = login.text.length > 2;
 }
 }
 
 */











@end

