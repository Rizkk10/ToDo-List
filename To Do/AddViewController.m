//
//  AddViewController.m
//  To Do
//
//  Created by Rezk on 17/01/2023.
//

#import "AddViewController.h"



@interface AddViewController ()

@end

@implementation AddViewController
{
    Tasks *task;
    NSMutableArray *allTasks;
    NSUserDefaults *defaults;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    allTasks = [NSMutableArray new];
    defaults = [NSUserDefaults standardUserDefaults];
    
}

- (IBAction)addTaskBtn:(id)sender {
    
    ViewController *todo = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    _date = [formatter stringFromDate:today];
    
    task= [Tasks new];
    task.taskName = _addTaskName.text;
    task.taskDes = _addTaskDescription.text;
    task.taskPriority = [NSNumber numberWithLong:_addTaskPriority.selectedSegmentIndex];
    task.taskDate = _date ;
    
    NSData *data2 = [defaults objectForKey:@"task"];
    allTasks = [[NSKeyedUnarchiver unarchiveObjectWithData:data2] mutableCopy];
    
    [allTasks addObject:task];
    

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:allTasks];
    
    [defaults setObject:data forKey:@"task"];
    [defaults synchronize];
    
    [todo.todoTableView reloadData];
    
    //_addTaskName.text = @"";
    
    [self.navigationController popToRootViewControllerAnimated:YES];
   
}


@end
