//
//  CDPStarEvaluation.h
//  CDPStarEvaluation
//
//  Created by MAC on 15/4/20.
//  Copyright (c) 2015年 com.xuezi.CDP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CDPStarEvaluationDelegate <NSObject>

-(void)theCurrentCommentText:(NSString *)commentText;//获得实时评价级别

@end

@interface CDPStarEvaluation : NSObject

@property (nonatomic,strong) UIImageView *starImageView;//满五星imageView

@property (nonatomic,strong) UIImageView *starEmptyImageView;//空五星imageView

@property (nonatomic,strong) NSString *commentText;//评价级别

@property (nonatomic,assign) float width;//实时记录评价详细分数

@property (nonatomic,assign) id <CDPStarEvaluationDelegate> delegate;

-(id)initWithFrame:(CGRect)frame  onTheView:(UIView *)view;//初始化


@end
