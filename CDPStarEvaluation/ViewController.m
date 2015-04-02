//
//  ViewController.m
//  CDPStarEvaluation
//
//  Created by MAC on 15/4/2.
//  Copyright (c) 2015年 com.xuezi.CDP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    UIImageView *_starImageView;//满五星imageView
    UILabel *_commentLabel;//评论级别label
    UIImageView *_starEmptyImageView;//空五星imageView
    
    float _width;//实时记录评价详细分数
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [self creatUI];
}
-(void)creatUI{
    //总体评价label
    UILabel *allCommentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,100,self.view.bounds.size.width,self.view.bounds.size.height*0.07042254)];
    allCommentLabel.text=@"总体评价";
    allCommentLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:allCommentLabel];
    //空星级imageView
    _starEmptyImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"评价1"]];
    _starEmptyImageView.frame=CGRectMake(self.view.bounds.size.width*0.1875,allCommentLabel.frame.origin.y+allCommentLabel.bounds.size.height,self.view.bounds.size.width*0.625,allCommentLabel.bounds.size.height);
    _starEmptyImageView.userInteractionEnabled=YES;
    
    [self.view addSubview:_starEmptyImageView];
    //满星级imageView(之前等比例适配出现问题，因为赶时间，采用了以下解决方法适配...)
    if (self.view.bounds.size.width==320) {
        if (self.view.bounds.size.height==568) {
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
    
    _starImageView.frame=CGRectMake(self.view.bounds.size.width*0.1875,allCommentLabel.frame.origin.y+allCommentLabel.bounds.size.height,0,allCommentLabel.bounds.size.height);
    _starImageView.contentMode=UIViewContentModeLeft;
    _starImageView.clipsToBounds=YES;
    [self.view addSubview:_starImageView];
    //单击手势
    UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [_starEmptyImageView addGestureRecognizer:tapGR];
    //拖动手势
    UIPanGestureRecognizer *panGR=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGR:)];
    [_starEmptyImageView addGestureRecognizer:panGR];
    //评价级别label
    _commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,_starImageView.frame.origin.y+_starImageView.bounds.size.height,self.view.bounds.size.width,allCommentLabel.bounds.size.height)];
    _commentLabel.text=@"无";
    _commentLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_commentLabel];
    //提交评论
    UIButton *submitCommentButton=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*0.0625,_commentLabel.frame.origin.y+_commentLabel.bounds.size.height,self.view.bounds.size.width*0.875,self.view.bounds.size.height*0.07042254)];
    submitCommentButton.backgroundColor=[UIColor colorWithRed:242/255.0 green:130/255.0 blue:32/255.0 alpha:1];
    [submitCommentButton setTitle:@"提交评价" forState:UIControlStateNormal];
    [submitCommentButton addTarget:self action:@selector(submitCommentClick) forControlEvents:UIControlEventTouchUpInside];
    submitCommentButton.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [self.view addSubview:submitCommentButton];
}
#pragma mark 手势
//单击手势
-(void)tapGR:(UITapGestureRecognizer *)tapGR{
    CGPoint tapPoint=[tapGR locationInView:_starEmptyImageView];
    _width=tapPoint.x/_starEmptyImageView.bounds.size.width;
    _starImageView.frame=CGRectMake(_starEmptyImageView.frame.origin.x,_starEmptyImageView.frame.origin.y,tapPoint.x,_starEmptyImageView.bounds.size.height);
    
    if (_width<=1/5.0) {
        //差
        _commentLabel.text=@"差";
    }
    else if(_width<=2/5.0&&_width>1/5.0){
        //一般
        _commentLabel.text=@"一般";
    }
    else if(_width<=3/5.0&&_width>2/5.0){
        //好
        _commentLabel.text=@"好";
    }
    else if(_width<=4/5.0&&_width>3/5.0){
        //很好
        _commentLabel.text=@"很好";
    }
    else{
        //非常好
        _commentLabel.text=@"非常好";
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
        _commentLabel.text=@"差";
    }
    else if(_width<=2/5.0&&_width>1/5.0){
        //一般
        _commentLabel.text=@"一般";
    }
    else if(_width<=3/5.0&&_width>2/5.0){
        //好
        _commentLabel.text=@"好";
    }
    else if(_width<=4/5.0&&_width>3/5.0){
        //很好
        _commentLabel.text=@"很好";
    }
    else{
        //非常好
        _commentLabel.text=@"非常好";
    }
    
}
#pragma mark 点击事件
//提交评论
-(void)submitCommentClick{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提交结果" message:[NSString stringWithFormat:@"级别:%@  分数:%.2f\n(分数默认显示小数点后两位,自己可根据需求更改)",_commentLabel.text,_width*5] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
