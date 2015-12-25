//
//  UpdateViewController.h
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/24.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "BaseViewController.h"
#import "StudentBean.h"

@protocol UpdateViewControllerDelegate <NSObject>

- (void)confirmUpdate;

@end

@interface UpdateViewController : BaseViewController
@property (nonatomic, strong) StudentBean *studentBean;

@property (nonatomic, assign) id<UpdateViewControllerDelegate> delegate;
@end
