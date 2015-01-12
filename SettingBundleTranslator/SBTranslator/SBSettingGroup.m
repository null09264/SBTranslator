//
//  SBSettingGroup.m
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingGroup.h"
#import "SBSettingItemRadioGroupElement.h"

@implementation SBSettingGroup


- (instancetype) init {
    self = [super init];
    if (self) {
        self.groupItem = nil;
        self.otherItems = [[NSMutableArray alloc]init];
        self.isRadioGroup = NO;
    }
    return self;
}

- (void) setRadioGroupItem:(SBSettingItemRadioGroup *)radioGroup {
    self.radioGroup = radioGroup;
    self.isRadioGroup = YES;
    self.radioGroupElements = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.radioGroup.titles.count; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:[self.radioGroup.titles objectAtIndex:i]  forKey:@"Title"];
        [dict setObject:[self.radioGroup.values objectAtIndex:i]  forKey:@"Value"];
        [dict setObject:@"PSRadioGroupElementSpecifier"  forKey:@"Type"];
        SBSettingItem *item = [[SBSettingItem alloc]initWithDictionary:dict];
        [self.radioGroupElements addObject:item];
    }
}

- (void) selectElementWithValue: (NSString *) value {
    for (SBSettingItemRadioGroupElement *element in self.radioGroupElements) {
        if ([element.value isEqualToString:value]) {
            element.isSelected = YES;
        } else {
            element.isSelected = NO;
        }
    }
}

- (SBSettingItem *) getItemAtIndex: (NSInteger) index {
    if (self.isRadioGroup) {
        if (index >= self.radioGroup.titles.count) {
            return [self.otherItems objectAtIndex:index - self.radioGroup.titles.count];
        } else {
            return [self.radioGroupElements objectAtIndex:index];
        }
    } else {
        return [self.otherItems objectAtIndex:index];
    }
}

- (NSInteger) getNumberOfRows {
    if (self.isRadioGroup) {
        return self.radioGroup.values.count + self.otherItems.count;
    } else {
        return self.otherItems.count;
    }
}

- (NSString *) getTitle {
    if (self.isRadioGroup) {
        return self.radioGroup.title;
    } else {
        return self.groupItem.title;
    }
}

- (NSString *) getFooterText {
    if (self.isRadioGroup) {
        return self.radioGroup.footerText;
    } else {
        return self.groupItem.footerText;
    }
}

@end
