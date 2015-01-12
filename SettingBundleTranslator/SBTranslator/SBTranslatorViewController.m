//
//  SBTranslatorViewControllerTableViewController.m
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBTranslatorViewController.h"

#import "SimplePickerInputTableViewCell.h"

#import "SBSettingItemGroup.h"
#import "SBSettingItemTextField.h"
#import "SBSettingItemToggleSwitch.h"
#import "SBSettingItemSlider.h"
#import "SBSettingItemMultiValue.h"
#import "SBSettingItemTitle.h"
#import "SBSettingItemRadioGroupElement.h"

@interface SBTranslatorViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, SimplePickerInputTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property SBTranslator *settingBundleTranslator;

@end

@implementation SBTranslatorViewController

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.settingBundleTranslator = [[SBTranslator alloc]init];
        self.title = @"Settings";
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adjustLayoutWithKeyboardFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shrinkLayoutWithKeyboardFrame:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(expandLayoutWithKeyboardFrame:) name:UIKeyboardWillHideNotification object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.settingBundleTranslator getNumberOfGroups];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settingBundleTranslator getNumberOfRowForGroupAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SBSettingItem *item = [self.settingBundleTranslator getItemAtIndexPath:indexPath];
    SBSettingGroup *group = [self.settingBundleTranslator.settingGroups objectAtIndex:indexPath.section];
    return [self getCellWithItem:item andGroup:group];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    SBSettingGroup *group = [self.settingBundleTranslator.settingGroups objectAtIndex:section];
    return [group getTitle];
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    SBSettingGroup *group = [self.settingBundleTranslator.settingGroups objectAtIndex:section];
    return [group getFooterText];
}

#pragma mark - Table view delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SBSettingGroup *group = [self.settingBundleTranslator.settingGroups objectAtIndex:indexPath.section];
    if (group.isRadioGroup) {
        if (indexPath.row < group.radioGroupElements.count) {
            SBSettingItemRadioGroupElement* element = (SBSettingItemRadioGroupElement*) [self.settingBundleTranslator getItemAtIndexPath:indexPath];
            [group selectElementWithValue: element.value];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            [[NSUserDefaults standardUserDefaults] setObject:element.value forKey:group.radioGroup.key];
        }
    }
}








- (UITableViewCell *) getCellWithItem: (SBSettingItem *)item andGroup: (SBSettingGroup *) group{
    if ([item isTextFieldItem]) {
        return [self getCellWithTextFieldItem:(SBSettingItemTextField *)item];
    } else if ([item isToggleSwitchItem]) {
        return [self getCellWithToggleSwitchItem:(SBSettingItemToggleSwitch *)item];
    } else if ([item isSliderItem]) {
        return [self getCellWithSliderItem:(SBSettingItemSlider *)item];
    } else if ([item isMultiValueItem]) {
        return [self getCellWithMultiValueItem:(SBSettingItemMultiValue *)item];
    } else if ([item isTitleItem]) {
        return [self getCellWithTitleItem:(SBSettingItemTitle *)item];
    } else if ([item isRadioGroupElementItem]) {
        return [self getCellWithGroupRadioElementItem:(SBSettingItemRadioGroupElement *)item andGroup: (SBSettingGroup *) group];
    } else {
        return [self getDefaultCell];
    }
}

- (UITableViewCell *) getCellWithTextFieldItem: (SBSettingItemTextField *)item {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, cell.contentView.frame.size.width * 0.3, cell.contentView.frame.size.height)];
    titleLabel.text = item.title;
    [cell.contentView addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width * 0.3 + 10, 0, cell.contentView.frame.size.width * 0.7 - 25, cell.contentView.frame.size.height)];
    textField.textAlignment = NSTextAlignmentRight;
    textField.autocapitalizationType = item.autocapitalizationType;
    textField.autocorrectionType = item.autocorrectionType;
    textField.text = [[NSUserDefaults standardUserDefaults] stringForKey:item.key];
    textField.keyboardType = item.keyboardType;
    [textField setSecureTextEntry: item.isSecure];
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    
    return cell;
}

- (UITableViewCell *) getCellWithToggleSwitchItem: (SBSettingItemToggleSwitch *)item {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", item.title];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UISwitch *toggleSwitch = [[UISwitch alloc]init];
    [toggleSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:item.key] animated:NO];
    [toggleSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = toggleSwitch;
    return cell;
}

- (UITableViewCell *) getCellWithSliderItem: (SBSettingItemSlider *)item {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UISlider *slider = [[UISlider alloc]init];
    slider.bounds = CGRectMake(0, 0, cell.contentView.bounds.size.width - 20, slider.bounds.size.height);
    slider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));
    slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    slider.value = [[NSUserDefaults standardUserDefaults] doubleForKey:item.key];
    slider.minimumValue = item.minimumValue;
    slider.maximumValue = item.maximumValue;
    slider.minimumValueImage = [UIImage imageNamed:item.minimumValueImage];
    slider.maximumValueImage = [UIImage imageNamed:item.maximumValueImage];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:slider];
    return cell;
}

- (UITableViewCell *) getCellWithMultiValueItem: (SBSettingItemMultiValue *) item {
    SimplePickerInputTableViewCell *cell = [[SimplePickerInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = item.title;
    cell.values = item.titles;
    cell.delegate = self;
    cell.value = [item.titles objectAtIndex:[item.values indexOfObject:[[NSUserDefaults standardUserDefaults] stringForKey:item.key]]];
    return cell;
}

- (UITableViewCell *) getCellWithTitleItem: (SBSettingItemTitle *)item {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, cell.contentView.frame.size.width * 0.3, cell.contentView.frame.size.height)];
    titleLabel.text = item.title;
    [cell.contentView addSubview:titleLabel];
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width * 0.3 + 10, 0, cell.contentView.frame.size.width * 0.7 - 25, cell.contentView.frame.size.height)];
    valueLabel.textAlignment = NSTextAlignmentRight;
    valueLabel.textColor = [UIColor grayColor];
    NSString *valueString = [[NSUserDefaults standardUserDefaults] stringForKey:item.key];
    
    @try {
        valueLabel.text = [item.titles objectAtIndex:[item.values indexOfObject:valueString]];
    }
    @catch (NSException *exception) {
        valueLabel.text = @"";
    }
    
    [cell.contentView addSubview:valueLabel];
    
    return cell;
}

- (UITableViewCell *) getCellWithGroupRadioElementItem: (SBSettingItemRadioGroupElement *) item andGroup: (SBSettingGroup *) group{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", item.title];
    
    if (item.isSelected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (UITableViewCell *) getDefaultCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    return cell;
}


#pragma value change responding methods

- (void) switchValueChanged: (UISwitch *) sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *) sender.superview];
    SBSettingItemToggleSwitch *item = (SBSettingItemToggleSwitch *)[self.settingBundleTranslator getItemAtIndexPath:indexPath];
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:item.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) sliderValueChanged: (UISlider *) sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *) sender.superview.superview];
    SBSettingItemSlider *item = (SBSettingItemSlider *)[self.settingBundleTranslator getItemAtIndexPath:indexPath];
    [[NSUserDefaults standardUserDefaults] setFloat:sender.value forKey:item.key];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

#pragma UITextField Delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *) textField.superview.superview];
    SBSettingItemTextField *item = (SBSettingItemTextField *)[self.settingBundleTranslator getItemAtIndexPath:indexPath];
    [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:item.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}


#pragma SimplePickerInputTableViewCell Delegate
- (void)tableViewCell:(SimplePickerInputTableViewCell *)cell didEndEditingWithValue:(NSString *)title {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    SBSettingItemMultiValue *item = (SBSettingItemMultiValue *)[self.settingBundleTranslator getItemAtIndexPath:indexPath];
    NSString *value = [item.values objectAtIndex:[item.titles indexOfObject:title]];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:item.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}














//keyboard observer
- (void) adjustLayoutWithKeyboardFrame:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyboardHeight = keyboardRect.size.height;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - keyboardHeight);
    }];
    
}

- (void) shrinkLayoutWithKeyboardFrame:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyboardHeight = keyboardRect.size.height;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - keyboardHeight);
    }];
    
}

- (void) expandLayoutWithKeyboardFrame:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
}
@end
