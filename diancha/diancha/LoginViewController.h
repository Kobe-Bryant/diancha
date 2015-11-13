//
//  LoginViewController.h
//  diancha
//
//  Created by Fang on 14-6-19.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginViewDelegate <NSObject>

@optional

- (void)didLogin;

@end

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    id <LoginViewDelegate>delegate;
}

@property(nonatomic,retain)id <LoginViewDelegate>delegate;

@end
