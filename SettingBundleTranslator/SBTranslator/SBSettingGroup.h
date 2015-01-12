//
//  SBSettingGroup.h
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingItemGroup.h"
#import "SBSettingItemRadioGroup.h"

@interface SBSettingGroup : NSObject

@property SBSettingItemGroup *groupItem;
@property NSMutableArray *otherItems;
@property BOOL isRadioGroup;
@property SBSettingItemRadioGroup *radioGroup;
@property NSMutableArray *radioGroupElements;

- (NSInteger) getNumberOfRows;
- (NSString *) getTitle;
- (NSString *) getFooterText;
- (void) setRadioGroup:(SBSettingItemRadioGroup *)radioGroup;
- (void) selectElementWithValue: (NSString *) value;
- (SBSettingItem *) getItemAtIndex: (NSInteger) index;
- (void) setRadioGroupItem:(SBSettingItemRadioGroup *)radioGroup;
@end
