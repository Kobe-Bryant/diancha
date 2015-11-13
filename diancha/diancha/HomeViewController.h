//
//  HomeViewController.h
//  diancha
//
//  Created by Fang on 14-6-24.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMGridView.h"
#import "MMGridViewDefaultCell.h"
#import "MorePiciListViewController.h"

@class OrderViewController,LogoutViewController;

@interface HomeViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,MMGridViewDataSource,MMGridViewDelegate,MMGridViewDefaultCellDelegate,MorePiciListViewControllerDelegate>
{
    NSMutableArray *buffer;
    NSMutableArray *roomListBuffer;
    NSArray *imageArray;
    NSString *roomDescriber;
    NSString *roomId;
    UIView *tableView_head;
    NSMutableArray *dataSource;
    NSUInteger pageCount;
    NSUInteger pageIndex;
    NSUInteger currentIndex;
    NSString *productId;
    NSDictionary *detailDict;
    NSDictionary *roomDetailDict;

    NSUInteger sumPrice;
    NSString *yearId;
    NSString *catalogName;
    NSMutableArray *yearArray;
    BOOL is_detail;
    BOOL is_roomDetail;

    BOOL roomViewDidShow;
    IBOutlet MMGridView *gridView;
    OrderViewController *secondDetailViewController;
    LogoutViewController *logoutViewController;
}
@end
