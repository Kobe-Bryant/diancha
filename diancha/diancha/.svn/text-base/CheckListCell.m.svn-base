//
//  CheckListCell.m
//  diancha
//
//  Created by Fang on 14-6-30.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "CheckListCell.h"

@implementation CheckListCell
@synthesize lb_name,lb_number,lb_price;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setContent:(NSDictionary *)data
{
    self.lb_name.text = [data objectForKey:@"productName"];
    self.lb_price.text = [NSString stringWithFormat:@"￥%@",[data objectForKey:@"storePrice"] ];
    self.lb_number.text = [@"x"stringByAppendingString:[data objectForKey:@"number"] ];
}


@end
