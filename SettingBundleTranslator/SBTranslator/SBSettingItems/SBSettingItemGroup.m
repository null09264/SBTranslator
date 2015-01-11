//
//  SBSettingGroupItem.m
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingItemGroup.h"

@implementation SBSettingItemGroup

- (instancetype) initWithDictionary: (NSDictionary *) preferenceDictionary {
    self = [super init];

    if (self) {
        assert([[preferenceDictionary objectForKey:@"Type"] isEqualToString:@"PSGroupSpecifier"]);
        self.title = [preferenceDictionary objectForKey:@"Title"];
        self.type = @"PSGroupSpecifier";
    }
    
    return self;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"GROUP: Title: %@", self.title];
}

@end
