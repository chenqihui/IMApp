//
//  RectViewForMessage.m
//  IMApp
//
//  Created by chen on 14/7/27.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "RectViewForMessage.h"

@interface RectViewForMessage ()
{
    int _nSumOfLine;
    NSArray *_arData;
}

@end

@implementation RectViewForMessage

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame sumOfLine:0];
}

- (id)initWithFrame:(CGRect)frame sumOfLine:(int)nSumLine
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _nSumOfLine = nSumLine + 1;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame ar:(NSArray *)arData
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _arData = arData;
        _nSumOfLine = [_arData count];
        [self createLabel];
    }
    return self;
}

- (void)createLabel
{
    float nW = self.width/_nSumOfLine;
    float nH = self.height;
    [_arData enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
    {
        UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(idx * nW, 0, nW - 1, nH)];
        [t setTextAlignment:NSTextAlignmentCenter];
        [t setText:obj];
        [self addSubview:t];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    float nW = self.width/_nSumOfLine;
    float nH = self.height;
    for (int i = 1; i < _nSumOfLine; i++)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextSetLineWidth(context, 0.5);
        
        CGPoint *point = (CGPoint *) malloc(sizeof(CGPoint) * 2);
        point[0] = CGPointMake(i * nW, 0);
        point[1] = CGPointMake(i * nW, nH);
        CGContextBeginPath(context);
        CGContextAddLines(context, point, 2);
        CGContextClosePath(context);
        CGContextStrokePath(context);
        free(point);
    }
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocatin = [touch locationInView:self];
    float nW = self.width/_nSumOfLine;
    int index = touchLocatin.x/nW;
    if ([_delegate respondsToSelector:@selector(press:index:)])
    {
        [_delegate press:self index:index];
    }
}

@end
