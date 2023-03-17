//
//  AddViewController.h
//  To Do
//
//  Created by Rezk on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController

@property NSString *date;

@property (weak, nonatomic) IBOutlet UITextField *addTaskName;

@property (weak, nonatomic) IBOutlet UITextView *addTaskDescription;

@property (weak, nonatomic) IBOutlet UISegmentedControl *addTaskPriority;


@end

NS_ASSUME_NONNULL_END
