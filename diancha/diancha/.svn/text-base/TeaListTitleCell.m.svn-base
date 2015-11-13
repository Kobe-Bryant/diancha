//
//  TeaListTitleCell.m
//  diancha
//
//  Created by Fang on 14-7-2.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "TeaListTitleCell.h"

@implementation TeaListTitleCell

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
    lb_orderName.text = [ @"订单编号:" stringByAppendingString:[data objectForKey:@"orderName"] ];
    lb_orderPrice.text = [@"总金额:￥"stringByAppendingString:[data objectForKey:@"receivableAmount"]];
    
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
	[date_formatter setDateFormat:@"YYYY-MM-dd HH:MM"];
    
    NSString *post_date = [date_formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[data objectForKey:@"orderDate"] doubleValue]/1000]];
    lb_orderTime.text = [NSString stringWithFormat:@"下单时间:%@",post_date];
    
    if(!IOS7){
        lb_orderPrice.textAlignment = NSTextAlignmentLeft;
    }

}

@end
