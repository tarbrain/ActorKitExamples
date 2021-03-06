//
//  Table.m
//  TestActorKit
//
//  Created by Julian Krumow on 15.12.15.
//  Copyright © 2015 Julian Krumow. All rights reserved.
//

#import <ActorKit/Supervision.h>

#import "Constants.h"
#import "Table.h"
#import "Philosopher.h"

@implementation Table

- (instancetype)initWithChopsticks:(NSUInteger)chopSticks
{
    self = [super init];
    if (self) {
        _philosopherNames = [NSMutableOrderedSet new];
        _philosophers = [NSMutableDictionary new];
        _eating = [NSMutableOrderedSet new];
        _chopsticks = [NSMutableArray new];
        
        for (int i=0; i < chopSticks; i++) {
            [_chopsticks addObject:@(CHOPSTICK_FREE)];
        }
    }
    
    NSLog(@"Table is ready to serve you.");
    
    return self;
}

- (void)welcome:(Philosopher *)philosopher
{
    [self.philosopherNames addObject:philosopher.name];
    [self.philosophers setObject:philosopher forKey:philosopher.name];
    
    NSLog(@"%@ has sat down at the table", philosopher.name);
    [philosopher.async think];
}

- (void)hungry:(NSString *)name
{
    if (![self.philosopherNames containsObject:name]) {
        NSLog(@"ERROR: philosopher %@ is not even sat down", name);
    }
    Philosopher *philosopher = self.philosophers[name];
    
    NSUInteger index = [self.philosopherNames indexOfObject:name];
    NSUInteger leftPosition = index;
    NSUInteger rightPosition = (index + 1) % self.chopsticks.count;
    
    if ([self.chopsticks[leftPosition] integerValue] == CHOPSTICK_FREE &&
        [self.chopsticks[rightPosition] integerValue] == CHOPSTICK_FREE) {
        self.chopsticks[leftPosition] = @(CHOPSTICK_USED);
        self.chopsticks[rightPosition] = @(CHOPSTICK_USED);
        [self.eating addObject:name];
        
        [self printTableStatus];
        [philosopher.async eat];
        
        if (self.eating.count == self.chopsticks.count) {
            NSLog(@"ERROR: too many philosophers are eating");
        }
    } else {
        [self printTableStatus];
        [philosopher.async think];
    }
}

- (void)dropChopsticks:(NSString *)name
{
    if (![self.philosopherNames containsObject:name]) {
        NSLog(@"ERROR: philosopher %@ is not even sat down", name);
    }
    Philosopher *philosopher = self.philosophers[name];
    
    NSUInteger index = [self.philosopherNames indexOfObject:name];
    NSUInteger leftPosition = index;
    NSUInteger rightPosition = (index + 1) % self.chopsticks.count;
    
    if (!([self.chopsticks[leftPosition] integerValue] == CHOPSTICK_USED &&
          [self.chopsticks[rightPosition] integerValue] == CHOPSTICK_USED)) {
        NSLog(@"ERROR: philosopher %@ without both chopsticks thinks he had eaten", name);
    }
    self.chopsticks[leftPosition] = @(CHOPSTICK_FREE);
    self.chopsticks[rightPosition] = @(CHOPSTICK_FREE);
    [self.eating removeObject:name];
    
    [self printTableStatus];
    [philosopher.async think];
}

- (void)printTableStatus
{
    NSLog(@"| eating: %@ chopsticks: %@ |",
          [self.eating.array componentsJoinedByString:@" "],
          [self.chopsticks componentsJoinedByString:@" "]);
}

@end
