//
//  UIRippleButton.m
//  BrainFuckLearner2
//
//  Created by 刘宇轩 on 10/04/2017.
//  Copyright © 2017 liuyuxuan. All rights reserved.
//

#import "UIRippleButton.h"

@interface UIRippleButton()

@property (strong,nonatomic)UIView* rippleView;
@property (strong,nonatomic)UIView* rippleBackgroundView;
@property (strong,nonatomic)CAShapeLayer* rippleMask;



@end



@implementation UIRippleButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize ripplePercent = _ripplePercent;
@synthesize rippleBackgroundColor = _rippleBackgroundColor;
@synthesize rippleColor = _rippleColor;


-(CAShapeLayer*)rippleMask{
    if(_rippleMask == nil){
        _rippleMask = [CAShapeLayer layer];
        _rippleMask.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                      cornerRadius:self.layer.cornerRadius].CGPath;
        
    }
    return _rippleMask;
}


-(void)setRippleOverBounds:(BOOL)rippleOverBounds{
    _rippleOverBounds = rippleOverBounds;
}

-(UIView*)rippleView{
    if(_rippleView == nil){
        _rippleView = [[UIView alloc]init];
    }
    return _rippleView;
}

-(UIView*)rippleBackgroundView{
    if(_rippleBackgroundView == nil){
        _rippleBackgroundView = [[UIView alloc]init];
    }
    return _rippleBackgroundView;
}
-(void)setRipplePercent:(double)ripplePercent{
    
    _ripplePercent = ripplePercent;
    [self setupRippleView];
    NSLog(@"I called it  = %f",ripplePercent);
}

-(double)ripplePercent{
    if(_ripplePercent == 0){
        _ripplePercent = 0.8;
    }
    return _ripplePercent;
}

-(UIColor*)rippleColor{
    if(_rippleColor == nil){
        _rippleColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _rippleColor;
}
-(void)setRippleColor:(UIColor *)rippleColor{
    _rippleColor = rippleColor;
    self.rippleView.backgroundColor = rippleColor;
}



-(UIColor*)rippleBackgroundColor{
    if(_rippleBackgroundColor == nil){
        _rippleBackgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    }
    return _rippleBackgroundColor;
}

-(void)setRippleBackgroundColor:(UIColor *)rippleBackgroundColor{
    _rippleBackgroundColor = rippleBackgroundColor;
    self.rippleBackgroundView.backgroundColor = rippleBackgroundColor;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}



-(void) setup{
    [self setupRippleView];
    
    self.rippleBackgroundView.backgroundColor = self.rippleBackgroundColor;

    self.rippleBackgroundView.frame = self.bounds;
    self.rippleBackgroundView.alpha = 0.0;
    
    [self.rippleBackgroundView addSubview:self.rippleView];
    [self addSubview:self.rippleBackgroundView];
    
    self.layer.shadowRadius = 0;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;

}

-(void) setupRippleView{
    NSLog(@"%f",self.ripplePercent);
    
    CGFloat size = self.bounds.size.width * self.ripplePercent;
    CGFloat x    = (self.bounds.size.width / 2) - (size / 2);
    CGFloat y    = (self.bounds.size.height / 2) - (size / 2);
    CGFloat corner = size / 2;
    
    
    self.rippleView.backgroundColor = self.rippleColor;
    self.rippleView.frame = CGRectMake(x, y, size, size);
    self.rippleView.layer.cornerRadius = corner;
    
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
   
    self.touchCenterLocation =[touch locationInView:self];
    
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.rippleBackgroundView.alpha = 1;
                     }
                     completion:nil];
    
    self.rippleView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    [UIView animateWithDuration:0.7
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut
                     animations:^{
                            self.rippleView.transform = CGAffineTransformIdentity;
                        }
                     completion:nil];
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

-(void)animateToNormal{
    [UIView animateWithDuration:10
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.rippleBackgroundView.alpha = 1;
                     }
                     completion:^(BOOL success){
                         [UIView animateWithDuration:self.touchUpAnimationTime
                                               delay:0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              self.rippleBackgroundView.alpha = 0;
                                          }
                                          completion:nil];
                     }];
    
    
}

-(void)cancelTrackingWithEvent:(UIEvent *)event{
    [super cancelTrackingWithEvent:event];
    [self animateToNormal];
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    [self animateToNormal];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.rippleView.center = self.touchCenterLocation;
    if(self.rippleOverBounds == true){
        self.rippleBackgroundView.layer.mask = self.rippleMask;
    }
    
}




@end
