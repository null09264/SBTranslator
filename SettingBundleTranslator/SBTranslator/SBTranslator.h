//
//  SBTranslator.h
//  SettingBundleTranslator
//
//  Created by Justus on 11/01/15.
//  Copyright (c) 2015年 NULL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBTranslator : NSObject

@property NSArray *settingGroups;

-(instancetype) init;
- (NSInteger) getNumberOfGroups;
- (NSInteger) getNumberOfRowForGroupAtIndex: (NSInteger) index;

@end
