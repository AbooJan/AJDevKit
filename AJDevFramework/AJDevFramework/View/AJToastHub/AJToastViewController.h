//
//  AJToast.h
//  AJToastHub
//
//  Created by 钟宝健 on 15/11/27.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ToastPosition)
{
    ToastPositionBottom,
    ToastPositionCenter,
    ToastPositionTop
};

@class AJToast;
@class AJHub;

@interface AJToastViewController : UIViewController

@property (nonatomic, weak) AJToast *toastWindow;
@property (weak, nonatomic) AJHub *hubWindow;

@property (nonatomic, copy) NSString *toastMessageStr;
@property (nonatomic, copy) NSString *hubMessageStr;

//=======Toast=========
@property (nonatomic, assign) ToastPosition toastPosition;

- (void)showToast:(void(^)())finished;
- (void)dismissToast:(void(^)())finished;

//=======Hub==========
- (void)showHub:(void(^)())finished;
- (void)dismissHub:(void(^)())finished;

@end
