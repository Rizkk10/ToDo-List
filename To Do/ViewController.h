//
//  ViewController.h
//  To Do
//
//  Created by Rezk on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"

@interface ViewController : UIViewController <UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate>
//@property (nonatomic, strong) NSMutableArray *taskTodoArr;
@property Tasks *addTask;
@property (weak, nonatomic) IBOutlet UITableView *todoTableView;

//@property NSMutableArray *taskTodoArr;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

