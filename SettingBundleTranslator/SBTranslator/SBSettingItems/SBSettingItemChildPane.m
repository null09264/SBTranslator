//
//  SBSettingItemChildPanel.m
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 12/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingItemChildPane.h"

@implementation SBSettingItemChildPane

- (instancetype) initWithDictionary: (NSDictionary *) preferenceDictionary {
    self = [super init];
    
    if (self) {
        assert([[preferenceDictionary objectForKey:@"Type"] isEqualToString:@"PSChildPaneSpecifier"]);
        self.file = [preferenceDictionary objectForKey:@"File"];
        self.title = [preferenceDictionary objectForKey:@"Title"];
        self.type = @"PSChildPaneSpecifier";
    }
    
    return self;
}


@end
