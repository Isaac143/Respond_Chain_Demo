//
//  ButtonTableViewCell.m
//  viewCDemo
//
//  Created by Isaac on 17/8/1.
//  Copyright © 2017年 Isaac. All rights reserved.
//

#import "ButtonTableViewCell.h"
#import "UIResponder+Router.h"

NSString * const ATableViewCellAEvent = @"AEvent";
NSString * const ATableViewCellAEvent2 = @"AEvent2";


@implementation ButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake(10, 10, 60, 30);
        [btn setTitle:@"testBTN" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.backgroundColor = [UIColor redColor];
        btn2.frame = CGRectMake(100, 10, 60, 30);
        [btn2 setTitle:@"testBTN2" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(testAction2:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn2];
    }
    return self;
    
}

- (void)testAction:(UIButton *)sender {   //方法名要和下面的一致。
    
    [self routerEventWithName:ATableViewCellAEvent userInfo:@{@"title":@"testBTN", @"param":@"在这里传过去一些数据"}];
    
}
- (void)testAction2:(UIButton *)sender {
    
    [self routerEventWithName:ATableViewCellAEvent2 userInfo:@{@"title":@"testBTN2", @"param2":@"this is param2 action"}];
    
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    
    NSInvocation *invo = self.eventStrategy[eventName];
    [invo setArgument:&userInfo atIndex:2];
    [invo invoke];
    
    //需要继续往上传递：                    如果方法多的时候可以写在字典对应的每个方法里面来来决定单个方法是否要继承。
//    [super routerEventWithName:eventName userInfo:userInfo];
    
}

- (void)aEvent:(NSDictionary *)userInfo {
    NSLog(@"cell里面：   %@",userInfo);
}
- (void)aEvent2:(NSDictionary *)userInfo {
    NSLog(@"需要上传递cell里面2：   %@",userInfo);
    [super routerEventWithName:ATableViewCellAEvent2 userInfo:userInfo];

}


/**
 如果事件来源有多个，那就无法避免需要if-else语句来针对具体事件作相应的处理。这种情况下，会导致if-else语句极多。所以，可以考虑采用strategy模式来消除if-else语句。
self.eventStrategy是一个字典，这个字典以eventName作key，对应的处理逻辑封装成NSInvocation来做value。
 在这种场合下使用Strategy模式，即可避免多事件处理场景下导致的冗长if-else语句。
 */
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy
{
    if (!_eventStrategy) {
        _eventStrategy = @{
                           ATableViewCellAEvent: [self createInvocationWithSelector:@selector(aEvent:)],
                           ATableViewCellAEvent2: [self createInvocationWithSelector:@selector(aEvent2:)],
                           };
    }
    return _eventStrategy;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
