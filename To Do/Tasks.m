//
//  Tasks.m
//  To Do
//
//  Created by Rezk on 17/01/2023.
//

#import "Tasks.h"

@implementation Tasks

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    //NSNumber *priorityNum = [[NSNumber alloc] initWithInteger:self.taskPriority];
    //NSNumber *stateNum = [[NSNumber alloc] initWithInteger:self.taskState];
    [coder encodeObject:_taskName forKey:@"tName"];
    [coder encodeObject:_taskDes forKey:@"tDes"];
    [coder encodeObject:_taskDate forKey:@"tDate"];
    [coder encodeObject:_taskPriority forKey:@"tPriorty"];
    [coder encodeObject:_taskState forKey:@"tState"];
    
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    
    //NSNumber *priorityNum = [[NSNumber alloc] initWithInteger:self.taskPriority];
    //NSNumber *stateNum = [[NSNumber alloc] initWithInteger:self.taskState];
    self.taskName =  [coder decodeObjectForKey:@"tName"];
    self.taskDes = [coder decodeObjectForKey:@"tDes"];
    self.taskDate = [coder decodeObjectForKey:@"tDate"];
    self.taskPriority = [coder decodeObjectForKey:@"tPriorty"];
    self.taskState = [coder decodeObjectForKey:@"tState"];
    return  self;
}

@end
