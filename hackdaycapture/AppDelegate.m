//
//  AppDelegate.m
//  hackdaycapture
//
//  Copyright (c) 2014 Dave Rice. No rights reserved.
//  Copyright (c) 2014 Tommy Aschenbach. No rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@property (weak) IBOutlet NSTextField *T_FEILD_1;
@property (weak) IBOutlet NSButton *Start_Button;
@property (weak) IBOutlet NSSegmentedControl *Video_Input_Selector;


@property (weak) IBOutlet NSSegmentedControl *BitDepthSelect;
@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate
 bool is_running;
NSTask *task ;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    is_running = false;
 }

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)Start:(id)sender{
    if(!is_running)
    {
    NSString * Depth;
    NSString * Video_Input;
    self.Start_Button.title=@"Capture/Stop";
   task = [[NSTask alloc] init];
    if (self.BitDepthSelect.selectedSegment==0)
    {
    
    Depth =@"8";
    }
    else
    {
        
        
     Depth =@"10";
        
    }
    Video_Input= [NSString stringWithFormat:@"%ld",(long)self.Video_Input_Selector.selectedSegment+1];
    task.launchPath= @"/Users/drice/github/local/vrecord/dumbvrecord";
[task setArguments:[NSArray arrayWithObjects:Depth,Video_Input, nil]];
 
    
    [task launch];
        is_running=true;
    }
    else
        
    {
        task = [[NSTask alloc] init];
        task.launchPath= @"/Users/drice/github/local/vrecord/dumbvstop";
        [task setArguments:[NSArray arrayWithObjects:nil]];
        self.Start_Button.title=@"Capture Stop";
        [task launch];
        is_running=FALSE;
        
    }
    //[task waitUntilExit];

}

@end
