//
//  ViewController.m
//  NSPredicate
//
//  Created by jamalping on 15-3-24.
//  Copyright (c) 2015年 jamalping. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // (1)对NSArray进行过滤
    [self aaaaa];
    // (2)判断字符串是否全为字母:
    [self bbbbb];
    // (3)字符串替换：
    [self ccccc];
    // (4)截取字符串如下：
    [self ddddd];
}

// (1)对NSArray进行过滤
- (void)aaaaa {
    NSArray *array = [[NSArray alloc]initWithObjects:@"beijing",@"shanghai",@"guangzou",@"wuhan", nil];
    NSString *string = @"ang";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",string];
    NSLog(@"%@",[array filteredArrayUsingPredicate:pred]);
}

// (2)判断字符串是否全为字母:
- (void)bbbbb {
    NSString *aString = @"sdsgfhgjhbm";
    NSString *regex = @"[A-Za-z]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:aString]) {
        NSLog(@"该字符串的首字符为字母");
    }else {
        NSLog(@"该字符串的首字符不是字母");
    }
}

// (3)字符串替换：
- (void)ccccc {
    NSError* error = NULL;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"(encoding=\")[^\"]+(\")"
                                                                           options:0
                                                                             error:&error];
    NSString* sample = @"<xml encoding=\"abc\"></xml><xml encoding=\"def\"></xml><xml encoding=\"ttt\"></xml>";
    NSLog(@"Start:%@",sample);
    NSString* result = [regex stringByReplacingMatchesInString:sample
                                                       options:0
                                                         range:NSMakeRange(0, sample.length)
                                                  withTemplate:@"$1utf-8$2"];
    NSLog(@"Result:%@", result);
}

// (4)截取字符串如下：
- (void)ddddd {
    //组装一个字符串，需要把里面的网址解析出来
    NSString *urlString=@"<meta/><link/><title>1Q84 BOOK1</title></head><body>";
    
    //NSRegularExpression类里面调用表达的方法需要传递一个NSError的参数。下面定义一个
    NSError *error;
    
    //http+:[^\\s]* 这个表达式是检测一个网址的。(?<=title\>).*(?=</title)截取html文章中的<title></title>中内文字的正则表达式
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<=title\\>).*(?=</title)" options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            
            //从urlString当中截取数据
            NSString *result=[urlString substringWithRange:resultRange];
            //输出结果
            NSLog(@"->%@<-",result);
        }    
        
    }
}

@end
