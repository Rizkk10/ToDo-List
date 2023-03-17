//
//  EditViewController.m
//  To Do
//
//  Created by Rezk on 17/01/2023.
//

#import "EditViewController.h"
#import "Tasks.h"
#import "ViewController.h"
#import "ProgressViewController.h"
#import "DoneViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController{
    
    NSUserDefaults *defaults;
    Tasks *task;
    NSData *data;
    NSData *d;
    NSData *d1;
    NSData *data2;
}
static NSMutableArray *progressArr;;
static NSMutableArray *editArr;
static NSMutableArray *doneArr;

+(void)initialize{
    progressArr = [NSMutableArray new];
    editArr = [NSMutableArray new];
    doneArr = [NSMutableArray new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    
    switch (_expectedVC) {
        case 0:
            d =  [defaults objectForKey:@"task"];
            editArr = [NSKeyedUnarchiver unarchiveObjectWithData:d];
            _editTaskName.text = [[editArr objectAtIndex:_indexNum ] taskName];
            _editTaskDescripition.text = [[editArr objectAtIndex:_indexNum ] taskDes];
            _editTaskPriority.selectedSegmentIndex = [[[editArr objectAtIndex:_indexNum ] taskPriority] intValue];
            _editTaskDateLabel.text = [[editArr objectAtIndex:_indexNum ] taskDate];
            _editTaskState.selectedSegmentIndex = 0;
            break;
        case 1:
            d =  [defaults objectForKey:@"Protask"];
            progressArr = [NSKeyedUnarchiver unarchiveObjectWithData:d];
            _editTaskName.text = [[progressArr objectAtIndex:_indexNum ] taskName];
            _editTaskDescripition.text = [[progressArr objectAtIndex:_indexNum ] taskDes];
            _editTaskPriority.selectedSegmentIndex = [[[progressArr objectAtIndex:_indexNum ] taskPriority] intValue];
            _editTaskDateLabel.text = [[progressArr objectAtIndex:_indexNum ] taskDate];
            _editTaskState.selectedSegmentIndex = 1;
            
            break;
        case 2:
            d =  [defaults objectForKey:@"Donetask"];
            doneArr = [NSKeyedUnarchiver unarchiveObjectWithData:d];
            _editTaskName.text = [[doneArr objectAtIndex:_indexNum ] taskName];
            _editTaskDescripition.text = [[doneArr objectAtIndex:_indexNum ] taskDes];
            _editTaskPriority.selectedSegmentIndex = [[[doneArr objectAtIndex:_indexNum ] taskPriority]intValue];
            _editTaskDateLabel.text = [[doneArr objectAtIndex:_indexNum ] taskDate];
            _editTaskState.selectedSegmentIndex = 2;
            
            break;
    }
    

}
 
- (IBAction)editBtn:(id)sender {
    
     Tasks *task = [Tasks new];
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    _date = [formatter stringFromDate:today];
    
    task.taskName = _editTaskName.text;
    task.taskDes = _editTaskDescripition.text;
    task.taskPriority  = [NSNumber numberWithLong:_editTaskPriority.selectedSegmentIndex];
    task.taskDate = _date ;

    switch (_expectedVC) {
            //coming from todo
        case 0:
            //coming from todo to progress array
            if (_editTaskState.selectedSegmentIndex == 1){
                data2= [defaults objectForKey:@"Protask"];
                if ([NSKeyedUnarchiver unarchiveObjectWithData:data2] != nil){
                    progressArr = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
                }
                task.taskState = [NSNumber numberWithLong:_editTaskState.selectedSegmentIndex];
                [progressArr addObject:task];
                
                data = [NSKeyedArchiver archivedDataWithRootObject:progressArr];
                [defaults setObject:data forKey:@"Protask"];
                
                
                
                d = [defaults objectForKey:@"task"];
                editArr = [NSKeyedUnarchiver unarchiveObjectWithData:d];
                [editArr removeObjectAtIndex:_indexNum];
                d1 = [NSKeyedArchiver archivedDataWithRootObject:editArr];
                [defaults setObject:d1 forKey:@"task"];
    
                
                //coming from todo to done array
            } else if (_editTaskState.selectedSegmentIndex == 2 ){
                data2 = [defaults objectForKey:@"Donetask"];
                if ([NSKeyedUnarchiver unarchiveObjectWithData:data2] != nil){
                    doneArr = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
                }
                
                
                task.taskState = [NSNumber numberWithLong:_editTaskState.selectedSegmentIndex];
                [doneArr addObject:task];
            
                data = [NSKeyedArchiver archivedDataWithRootObject:doneArr];
                [defaults setObject:data forKey:@"Donetask"];
                
                d = [defaults objectForKey:@"task"];
                editArr = [NSKeyedUnarchiver unarchiveObjectWithData:d];
                [editArr removeObjectAtIndex:_indexNum];
                d1 = [NSKeyedArchiver archivedDataWithRootObject:editArr];
                [defaults setObject:d1 forKey:@"task"];
                
                
            }
            if ( _editTaskState.selectedSegmentIndex == 0){
                data2= [defaults objectForKey:@"task"];
                editArr = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
                //[editArr removeObjectAtIndex:_indexNum];
                task.taskName = _editTaskName.text;
                task.taskDes = _editTaskDescripition.text;
                task.taskPriority  = [NSNumber numberWithLong:_editTaskPriority.selectedSegmentIndex];
                task.taskDate = _date ;
                [editArr replaceObjectAtIndex:_indexNum withObject:task];
          //      if ([NSKeyedUnarchiver unarchiveObjectWithData:data2] != nil){
//                    editArr = [NSKeyedUnarchiver unarchiveObjectWithData:data2];}
                data2 = [NSKeyedArchiver archivedDataWithRootObject:editArr];
                [defaults setObject:data2 forKey:@"task"];
            }
            break;
            
        case 1:
            
            //coming from progress to todo array
            if (_editTaskState.selectedSegmentIndex == 0){
                data2= [defaults objectForKey:@"task"];
                if ([NSKeyedUnarchiver unarchiveObjectWithData:data2] != nil){
                    editArr = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
                }
                task.taskState = [NSNumber numberWithLong:_editTaskState.selectedSegmentIndex];
                [editArr addObject:task];
                
                data = [NSKeyedArchiver archivedDataWithRootObject:editArr];
                [defaults setObject:data forKey:@"task"];
                
                d = [defaults objectForKey:@"Protask"];
                progressArr = [NSKeyedUnarchiver unarchiveObjectWithData:d];
                [progressArr removeObjectAtIndex:_indexNum];
                d1 = [NSKeyedArchiver archivedDataWithRootObject:progressArr];
                [defaults setObject:d1 forKey:@"Protask"];
                
                //coming from progress to done array
            } else if (_editTaskState.selectedSegmentIndex == 2 ){
                data2 = [defaults objectForKey:@"Donetask"];
                if ([NSKeyedUnarchiver unarchiveObjectWithData:data2] != nil){
                    doneArr = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
                }
                task.taskState = [NSNumber numberWithLong:_editTaskState.selectedSegmentIndex];
                [doneArr addObject:task];
                data = [NSKeyedArchiver archivedDataWithRootObject:doneArr];
                [defaults setObject:data forKey:@"Donetask"];
                
                
                d = [defaults objectForKey:@"Protask"];
                progressArr = [NSKeyedUnarchiver unarchiveObjectWithData:d];
                [progressArr removeObjectAtIndex:_indexNum];
                d1 = [NSKeyedArchiver archivedDataWithRootObject:progressArr];
                [defaults setObject:d1 forKey:@"Protask"];
            }
            if ( _editTaskState.selectedSegmentIndex == 1){
                data2= [defaults objectForKey:@"Protask"];
                progressArr = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
                //[progressArr removeObjectAtIndex:_indexNum];
                task.taskName = _editTaskName.text;
                task.taskDes = _editTaskDescripition.text;
                task.taskPriority  = [NSNumber numberWithLong:_editTaskPriority.selectedSegmentIndex];
                task.taskDate = _date ;
                [progressArr replaceObjectAtIndex:_indexNum withObject:task];
                data2 = [NSKeyedArchiver archivedDataWithRootObject:progressArr];
                [defaults setObject:data2 forKey:@"Protask"];
            }
            break;
            
        case 2:
            
            //coming from done to todo array
            if (_editTaskState.selectedSegmentIndex == 0){
                data2= [defaults objectForKey:@"task"];
                if ([NSKeyedUnarchiver unarchiveObjectWithData:data2] != nil){
                    editArr = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
                }
                task.taskState = [NSNumber numberWithLong:_editTaskState.selectedSegmentIndex];
                [editArr addObject:task];
                
                data = [NSKeyedArchiver archivedDataWithRootObject:editArr];
                [defaults setObject:data forKey:@"task"];
                //coming from done to progress array
            }   else if (_editTaskState.selectedSegmentIndex == 1){
                data2= [defaults objectForKey:@"Protask"];
                if ([NSKeyedUnarchiver unarchiveObjectWithData:data2] != nil){
                    progressArr = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
                }
                task.taskState = [NSNumber numberWithLong:_editTaskState.selectedSegmentIndex];
                [progressArr addObject:task];
                
                data = [NSKeyedArchiver archivedDataWithRootObject:progressArr];
                [defaults setObject:data forKey:@"Protask"];
                //coming from todo to done array
            }
            if ( _editTaskState.selectedSegmentIndex != 2){
                data2= [defaults objectForKey:@"Donetask"];
                doneArr = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
                //[doneArr removeObjectAtIndex:_indexNum];
                task.taskName = _editTaskName.text;
                task.taskDes = _editTaskDescripition.text;
                task.taskPriority  = [NSNumber numberWithLong:_editTaskPriority.selectedSegmentIndex];
                task.taskDate = _date ;
                [doneArr replaceObjectAtIndex:_indexNum withObject:task];
                data2 = [NSKeyedArchiver archivedDataWithRootObject:doneArr];
                [defaults setObject:data2 forKey:@"Donetask"];
            }
    
            
            break;
        default:
            break;
    }
    task.taskName = _editTaskName.text;
    task.taskDes = _editTaskDescripition.text;
    task.taskPriority  = [NSNumber numberWithLong:_editTaskPriority.selectedSegmentIndex];
    task.taskDate = _date ;

    

    [self.navigationController popViewControllerAnimated:YES];

    

    }
    
@end

