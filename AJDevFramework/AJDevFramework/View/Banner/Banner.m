//
//  Banner.m
//  Banner
//
//  Created by 钟宝健 on 15/10/8.
//  Copyright © 2015年 钟宝健. All rights reserved.
//
//
//  如果要加载网络图片，可以结合 SDWebImage 框架
//
//


#import "Banner.h"

/// banner自动滚动速度
static const NSInteger SCROLL_RATE = 3;


@interface Banner() <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *bannerImageNameArray;
@property (nonatomic, assign) NSInteger currentPage;
/// 自动滚动计时器
@property (nonatomic, strong) NSTimer *autoScrollTimer;
/// YES，反向；NO，正向
@property (nonatomic, assign) BOOL scrollDirection;
@end

@implementation Banner

- (instancetype)initWithFrame:(CGRect)frame bannerImageNameArray:(NSArray *)nameArray
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"Banner" owner:nil options:nil][0];
        self.mainScrollView.delegate = self;
        
        self.frame = frame;
        self.bannerImageNameArray = nameArray;
        
        self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:SCROLL_RATE target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.autoScrollTimer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)setBannerImageNameArray:(NSArray *)bannerImageNameArray
{
    _bannerImageNameArray = bannerImageNameArray;
    
    // 设置图片
    CGFloat bannerWidth = self.frame.size.width;
    CGFloat bannerHeight = self.frame.size.height;
    for (NSInteger i = 0; i < self.bannerImageNameArray.count; i++) {
        CGFloat bannerX = i * bannerWidth;
        CGFloat bannerY = 0;
        
        NSString *imgName = self.bannerImageNameArray[i];
        UIImage *bannerImg = [UIImage imageNamed:imgName];
        UIImageView *bannerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(bannerX, bannerY, bannerWidth, bannerHeight)];
        bannerImgView.image = bannerImg;
        bannerImgView.userInteractionEnabled = YES;
        bannerImgView.tag = i;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerClick:)];
        [bannerImgView addGestureRecognizer:tapGesture];
        
        [self.mainScrollView addSubview:bannerImgView];
    }
    
    // 更新滚动区域大小
    self.mainScrollView.contentSize = CGSizeMake(bannerWidth * self.bannerImageNameArray.count, bannerHeight);
    
    // 设置指示器
    [self.pageControl setNumberOfPages:self.bannerImageNameArray.count];
}

#pragma mark 自动滚动事件
- (void)autoScroll
{
    CGRect scrollRect;
    if (!_scrollDirection) {
        // 正向
        
        _currentPage ++;
        scrollRect = CGRectMake(self.frame.size.width * _currentPage, 0, self.frame.size.width, self.frame.size.height);
        [self.mainScrollView scrollRectToVisible:scrollRect animated:YES];
        
        if (_currentPage >= self.bannerImageNameArray.count - 1) {
            _scrollDirection = YES;
        }
        
    }else{
        // 反向
        
        _currentPage --;
        scrollRect = CGRectMake(self.frame.size.width * _currentPage, 0, self.frame.size.width, self.frame.size.height);
        [self.mainScrollView scrollRectToVisible:scrollRect animated:YES];
        
        if (_currentPage <= 0) {
            _scrollDirection = NO;
        }
    }
}

#pragma mark banner点击事件监听
- (void)bannerClick:(UITapGestureRecognizer *)tapGesture
{
    UIImageView *banner = (UIImageView *)tapGesture.view;
    NSInteger index = banner.tag;
    
    NSLog(@"Banner点击：%ld", index);
}


#pragma mark - 滚动视图代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentPage = scrollView.contentOffset.x / self.frame.size.width;
    
    self.pageControl.currentPage = _currentPage;
}


-(void)dealloc
{
    [self.autoScrollTimer invalidate];
    self.autoScrollTimer = nil;
}

@end
