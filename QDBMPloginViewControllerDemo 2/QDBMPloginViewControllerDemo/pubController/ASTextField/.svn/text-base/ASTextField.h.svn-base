//
//  UITextField+ASTextField.h
//  ASTextViewDemo
//
//  Created by Adil Soomro on 4/14/14.
//  Copyright (c) 2014 Adil Soomro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"
#import "QDTool.h"

typedef enum {
    ASTextFieldTypeAccount,
    ASTextFieldTypePassWord,
    ASTextFieldTypeCompetitonAccount,
    ASTextFieldTypeCompetitonPassWord,
}ASTextFieldType;


@protocol ASTextFieldDelegate <NSObject>

@optional -(void)selectAccount:(BOOL)select;

@end

@interface ASTextField : UITextField<QRadioButtonDelegate>

@property(nonatomic,weak)id<ASTextFieldDelegate>asDelegate;

@property(nonatomic,strong)QRadioButton *radio1 ;

@end


@interface UITextField ()



- (void)setupTextFieldWithIconName:(NSString *)name;
- (void)setupTextFieldWithType:(ASTextFieldType)type delegate:(id)fromDelegate withIconName:(NSString *)name;
//重置颜色
-(void)resetSkinColor;
@end
