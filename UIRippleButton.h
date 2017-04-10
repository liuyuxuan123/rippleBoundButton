//
//  UIRippleButton.h
//  BrainFuckLearner2
//
//  Created by 刘宇轩 on 10/04/2017.
//  Copyright © 2017 liuyuxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIRippleButton : UIButton

@property(nonatomic) IBInspectable BOOL    rippleOverBounds;
@property(nonatomic) IBInspectable CGFloat shadowRippleRadius;
@property(nonatomic) IBInspectable BOOL    shadowRippleEnable;
@property(nonatomic) IBInspectable BOOL    trackTouchLocation;
@property(nonatomic) IBInspectable double  touchUpAnimationTime;

@property(nonatomic) CGFloat tempShadowRadius;
@property(nonatomic) CGFloat tempShadowOpacity;
@property(nonatomic) CGPoint touchCenterLocation;

@property(nonatomic)IBInspectable double ripplePercent;
@property(nonatomic,strong)IBInspectable UIColor* rippleColor;
@property(nonatomic,strong)IBInspectable UIColor* rippleBackgroundColor;


@end
