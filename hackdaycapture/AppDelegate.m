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
@property (weak) IBOutlet NSTextField *Write_Directory_Field;
@property (weak) IBOutlet NSTextField *FileName_Field;
@property (weak) IBOutlet NSSegmentedControl *Audio_Input_Select;
@property (weak) IBOutlet NSButtonCell *Play_Button;
@property (weak) IBOutlet NSButton *Stop_Button;
@property (weak) IBOutlet NSButton *Rewind_Button;
@property (weak) IBOutlet NSButton *Fast_Word;
@property (weak) IBOutlet NSButtonCell *Preview_Button;
@property (weak) IBOutlet NSSegmentedControl *wrapper_selector;

@property (weak) IBOutlet NSSegmentedCell *Compression_Selector;

@property (weak) IBOutlet NSSegmentedControl *BitDepthSelect;
@property (weak) IBOutlet NSWindow *window;


@end

@implementation AppDelegate
@synthesize Write_Directory_Field;
@synthesize FileName_Field;
 bool is_running;
NSString *DeckControl_Script ;
NSString *Dumbvrecord_Script ;
NSString *Dumbvplay_Script ;
NSString *Dumbvstop_Script ;
NSTask *task ;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    is_running = false;
    NSBundle *mainBundle = [NSBundle mainBundle];
    DeckControl_Script = [mainBundle pathForResource: @"deckcontrol" ofType: @"app"];
      Dumbvrecord_Script = [mainBundle pathForResource: @"dumbvrecord" ofType: @"sh"];
      Dumbvplay_Script = [mainBundle pathForResource: @"dumbvplay" ofType: @"sh"];
      Dumbvstop_Script = [mainBundle pathForResource: @"dumbvstop" ofType: @"sh"];
    
 }

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)Deck_Play:(id)sender {
    
    NSTask *controltask = [[NSTask alloc] init];
    
    controltask.launchPath= DeckControl_Script;
    [controltask setArguments:[NSArray arrayWithObjects:@"play",nil]];
    
    [controltask launch];
    
   
    
}
- (IBAction)Deck_Rewind:(id)sender {
    NSTask *controltask = [[NSTask alloc] init];
    
    controltask.launchPath= DeckControl_Script;
    [controltask setArguments:[NSArray arrayWithObjects:@"rewind",nil]];
    
    [controltask launch];
    
    
}
- (IBAction)Deck_FastFoward:(id)sender {
    NSTask *controltask = [[NSTask alloc] init];
    
    controltask.launchPath= DeckControl_Script;
    [controltask setArguments:[NSArray arrayWithObjects:@"fastforward",nil]];
    
    [controltask launch];
    
    
}

- (IBAction)Deck_Stop:(id)sender {
    NSTask *controltask = [[NSTask alloc] init];
    
    controltask.launchPath= DeckControl_Script;
    [controltask setArguments:[NSArray arrayWithObjects:@"stop",nil]];
    
    [controltask launch];
    
    
}

- (IBAction)Start_Preview:(id)sender {
    NSString * Depth;
    NSString * Video_Input;
    NSString * Audio_Input;
    NSString * Compression;
    self.Start_Button.title=@"Stop Capture";
    NSTask *ptask = [[NSTask alloc] init];

    if (self.BitDepthSelect.selectedSegment==0)
    {
        
        Depth =@"8";
    }
    else
    {
        
        
        Depth =@"10";
        
    }

    
    Video_Input= [NSString stringWithFormat:@"%ld",(long)self.Video_Input_Selector.selectedSegment+1];
    Audio_Input= [NSString stringWithFormat:@"%ld",(long)self.Audio_Input_Select.selectedSegment+1];
    ptask.launchPath=Dumbvplay_Script;
    [ptask setArguments:[NSArray arrayWithObjects:Depth,Video_Input,Audio_Input, nil]];
    
    
    [ptask launch];

    
    
    
}


- (IBAction)Start:(id)sender{
    if(!is_running)
    {
    NSString * Depth;
    NSString * Video_Input;
    NSString * Audio_Input;
        NSString * Wrapper;
        NSString * Compression;
        self.Start_Button.title=@"Stop Capture";
   task = [[NSTask alloc] init];
        NSString * directoryloc = [Write_Directory_Field stringValue];
        NSString * fileloc = [FileName_Field stringValue];
    if (self.BitDepthSelect.selectedSegment==0)
    {
    
    Depth =@"8";
    }
    else
    {
        
        
     Depth =@"10";
        
    }
        if (self.Compression_Selector.selectedSegment==0)
        {
            
            Compression =@"uncompressed";
        }
        else if (self.Compression_Selector.selectedSegment==1)
        {
            
            
            Compression =@"ffv1";
            
        }
        else if (self.Compression_Selector.selectedSegment==2)
        {
            
            
            Compression =@"jpeg2000";
            
        }
        else if (self.Compression_Selector.selectedSegment==3)
        {
            
            
            Compression =@"prores";
            
        }
        
    
        
        if (self.wrapper_selector.selectedSegment==0)
        {
            
            Wrapper =@"mov";
        }
        else if (self.wrapper_selector.selectedSegment==1)
        {
            
            
            Wrapper =@"avi";
            
        }
        else if (self.wrapper_selector.selectedSegment==2)
        {
            
            
            Wrapper =@"mxf";
            
        }
        else if (self.wrapper_selector.selectedSegment==3)
        {
            
            
            Wrapper =@"mkv";
            
        }
        
    Video_Input= [NSString stringWithFormat:@"%ld",(long)self.Video_Input_Selector.selectedSegment+1];
        Audio_Input= [NSString stringWithFormat:@"%ld",(long)self.Audio_Input_Select.selectedSegment+1];
    task.launchPath=Dumbvrecord_Script;
        [task setArguments:[NSArray arrayWithObjects:Depth,Video_Input,Audio_Input,directoryloc,fileloc,Compression,Wrapper, nil]];
 
    
    [task launch];
        is_running=true;
    }
    else
        
    {
        task = [[NSTask alloc] init];
        task.launchPath= Dumbvstop_Script;
        [task setArguments:[NSArray arrayWithObjects:nil]];
        self.Start_Button.title=@"Start Capture";
        [task launch];
        is_running=FALSE;
        
    }
    //[task waitUntilExit];

}
- (IBAction)Select_Check:(id)sender {
    if(self.Compression_Selector.selectedSegment==1 && self.wrapper_selector.selectedSegment==2)
    {
        self.wrapper_selector.selectedSegment=1;
        
    }
}

@end
