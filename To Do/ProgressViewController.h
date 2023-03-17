//
//  ProgressViewController.h
//  To Do
//
//  Created by Rezk on 17/01/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *progTable;
@property int indexNum ;
@property NSMutableArray *proArr;

@end

NS_ASSUME_NONNULL_END
