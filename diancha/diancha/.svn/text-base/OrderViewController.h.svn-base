//
//  OrderViewController.h
//  diancha
//
//  Created by Fang on 14-7-2.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"

@protocol OrderViewControllerDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(NSMutableArray *)arrary;
@end

@interface OrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DropDownChooseDelegate,DropDownChooseDataSource>
{
    id<OrderViewControllerDelegate>delegate;
    NSMutableArray *buffer;
    NSMutableArray *roomList;

    IBOutlet UITableView *contentListView;
    IBOutlet UIView *head_view;
    IBOutlet UILabel *lb_totalPrice;
    IBOutlet UILabel *lb_roomPrice;

    IBOutlet UIButton *btn_take;
    IBOutlet UIButton *btn_cancel;

    NSString *oldOrderId;
    NSString *roomId;

}

@property(nonatomic,retain)id<OrderViewControllerDelegate>delegate;

- (void)setUpBuffer:(NSMutableArray *)arrary;

@end
