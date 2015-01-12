//
//  SBSettingTextFieldItem.h
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingItem.h"
#import <UIKit/UIKit.h>

@interface SBSettingItemTextField : SBSettingItem

@property UITextAutocapitalizationType autocapitalizationType;
@property UITextAutocorrectionType autocorrectionType;
@property NSString *defaultValue;
@property BOOL isSecure;
@property NSString *key;
@property UIKeyboardType keyboardType;
@property NSString *title;

@end
