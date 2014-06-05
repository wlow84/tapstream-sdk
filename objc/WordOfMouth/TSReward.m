//
//  TSReward.m
//  WordOfMouth
//
//  Created by Eric on 2014-05-09.
//  Copyright (c) 2014 Tapstream. All rights reserved.
//

#import "TSReward.h"

@interface TSReward()

@property(assign, nonatomic, readwrite) NSUInteger offerIdent;
@property(STRONG_OR_RETAIN, nonatomic, readwrite) NSString *insertionPoint;
@property(STRONG_OR_RETAIN, nonatomic, readwrite) NSString *sku;
@property(assign, nonatomic, readwrite) NSUInteger quantity;
@property(assign, nonatomic, readwrite) NSInteger installs;
@property(assign, nonatomic, readwrite) NSInteger minimumInstalls;

@end

@implementation TSReward

@synthesize offerIdent, insertionPoint, sku, installs, minimumInstalls, quantity;


- (id)initWithDescription:(NSDictionary *)descriptionVal
{
    if(self = [super init]) {
        self.offerIdent = [[descriptionVal objectForKey:@"offer_id"] unsignedIntegerValue];
        self.insertionPoint = [descriptionVal objectForKey:@"insertion_point"];
        self.sku = [descriptionVal objectForKey:@"reward_sku"];
        self.installs = [[descriptionVal objectForKey:@"installs"] integerValue];
        self.minimumInstalls = [[descriptionVal objectForKey:@"reward_minimum_installs"] integerValue];
        self.quantity = 0;
    }
    return self;
}

- (void)calculateQuantity:(NSInteger)alreadyConsumed
{
    NSInteger rewardCount = self.installs / self.minimumInstalls;
    self.quantity = (NSUInteger)MAX(0, rewardCount - alreadyConsumed);
}

- (void)dealloc
{
    SUPER_DEALLOC;
    
    RELEASE(self->insertionPoint);
    RELEASE(self->sku);
}

@end