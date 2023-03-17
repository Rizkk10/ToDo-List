//
//  Tasks.h
//  To Do
//
//  Created by Rezk on 17/01/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tasks : NSObject <NSCoding>

@property NSString *taskName;
@property NSString *taskDes;
@property NSString *taskDate;
@property NSNumber *taskPriority;
@property NSNumber *taskState;

@end

NS_ASSUME_NONNULL_END
