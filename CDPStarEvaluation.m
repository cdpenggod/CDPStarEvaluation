//
//  CDPStarEvaluation.m
//  CDPStarEvaluation
//
//  Created by MAC on 15/4/20.
//  Copyright (c) 2015年 com.xuezi.CDP. All rights reserved.
//

#import "CDPStarEvaluation.h"

@implementation CDPStarEvaluation

-(id)initWithFrame:(CGRect)frame onTheView:(UIView *)view{
    if (self=[super init]) {
        _commentText=@"无";
        //空星级imageView
        _starEmptyImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"评价1"]];
        _starEmptyImageView.frame=frame;
        _starEmptyImageView.userInteractionEnabled=YES;
        
        [view addSubview:_starEmptyImageView];
        //满星级imageView(之前等比例适配出现问题，因为赶时间，采用了以下解决方法适配...)
        if (view.bounds.size.width==320) {
            if (view.bounds.size.height==568) {
                //5、5s
                _starImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"评价2-5"]];
            }
            else{
                //4s
                _starImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"评价2-4"]];
            }
        }
        else{
            //6、6plus
            _starImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"评价2"]];
        }
        
        _starImageView.frame=CGRectMake(frame.origin.x,frame.origin.y,0,frame.size.height);
        _starImageView.contentMode=UIViewContentModeLeft;
        _starImageView.clipsToBounds=YES;
        [view addSubview:_starImageView];
        //单击手势
        UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
        [_starEmptyImageView addGestureRecognizer:tapGR];
        //拖动手势
        UIPanGestureRecognizer *panGR=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGR:)];
        [_starEmptyImageView addGestureRecognizer:panGR];
    }
    
    return self;
}

#pragma mark 手势
//单击手势
-(void)tapGR:(UITapGestureRecognizer *)tapGR{
    CGPoint tapPoint=[tapGR locationInView:_starEmptyImageView];
    _width=tapPoint.x/_starEmptyImageView.bounds.size.width;
    _starImageView.frame=CGRectMake(_starEmptyImageView.frame.origin.x,_starEmptyImageView.frame.origin.y,tapPoint.x,_starEmptyImageView.bounds.size.height);
    
    if (_width<=1/5.0) {
        //差
        _commentText=@"差";
    }
    else if(_width<=2/5.0&&_width>1/5.0){
        //一般
        _commentText=@"一般";
    }
    else if(_width<=3/5.0&&_width>2/5.0){
        //好
        _commentText=@"好";
    }
    else if(_width<=4/5.0&&_width>3/5.0){
        //很好
        _commentText=@"很好";
    }
    else{
        //非常好
        _commentText=@"非常好";
    }
    
    if (_delegate) {
        [_delegate theCurrentCommentText:_commentText];
    }
}
//拖动手势
- (void)panGR:(UIPanGestureRecognizer *)panGR
{
    CGPoint panPoint = [panGR locationInView:_starEmptyImageView];
    if (panPoint.x<0||panPoint.x>_starEmptyImageView.bounds.size.width) {
        return;
    }
    _width=panPoint.x/_starEmptyImageView.bounds.size.width;
    
    _starImageView.frame=CGRectMake(_starEmptyImageView.frame.origin.x,_starEmptyImageView.frame.origin.y,panPoint.x,_starEmptyImageView.bounds.size.height);
    
    if (_width<=1/5.0) {
        //差
        _commentText=@"差";
    }
    else if(_width<=2/5.0&&_width>1/5.0){
        //一般
        _commentText=@"一般";
    }
    else if(_width<=3/5.0&&_width>2/5.0){
        //好
        _commentText=@"好";
    }
    else if(_width<=4/5.0&&_width>3/5.0){
        //很好
        _commentText=@"很好";
    }
    else{
        //非常好
        _commentText=@"非常好";
    }
    
    if (_delegate) {
        [_delegate theCurrentCommentText:_commentText];
    }
}







@end
