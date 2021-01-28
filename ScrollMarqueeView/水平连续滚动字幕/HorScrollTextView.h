//
//  HorScrollTextView.h
//  FREEGOU
//
//  Created by admin on 2021/1/8.
//  Copyright © 2021 xin sun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HorScrollTextView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *textArr;

@property(nonatomic,strong)UIScrollView *textScrollview;

@property(nonatomic,assign)NSInteger scrMaxW;


@property(nonatomic,assign)NSInteger scrX;

@property(nonatomic,strong)NSTimer *timer;


- (void)invTimer;

@end

NS_ASSUME_NONNULL_END
