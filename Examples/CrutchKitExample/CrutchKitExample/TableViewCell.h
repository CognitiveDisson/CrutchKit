//
//  TableViewCell.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@end

@protocol TableViewCellDelegate <NSObject>

- (void)didPressButton:(UIButton *)button
                onCell:(TableViewCell *)cell;

- (void)didSwitch:(UISwitch *)sender;


@end

@protocol AnotherTableViewCellDelegate <NSObject>

@optional

- (void)didChangedSliderValue:(CGFloat)value;

@end
