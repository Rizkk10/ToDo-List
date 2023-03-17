//
//  EditViewController.h
//  To Do
//
//  Created by Rezk on 17/01/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *editTaskName;
@property (weak, nonatomic) IBOutlet UITextView *editTaskDescripition;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editTaskPriority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editTaskState;
@property (weak, nonatomic) IBOutlet UILabel *editTaskDateLabel;
@property int indexNum ;
@property int expectedVC ; // 0 for todo, 1 for progress, 2 for done
@property NSString *date;
@end

NS_ASSUME_NONNULL_END
