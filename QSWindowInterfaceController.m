#import "QSWindowInterfaceController.h"

#import <IOKit/IOCFBundle.h>
#import <ApplicationServices/ApplicationServices.h>
//#import "QSMenuButton.h"

#define EXPAND_HEIGHT 28


@implementation QSWindowInterfaceController

- (id)init {
	if ((self = [super initWithWindowNibName:@"QSWindowInterface"])){
    }
    return self;
}

- (NSSize)maxIconSize{
    return NSMakeSize(32,32);
}

- (void) windowDidLoad{
	[super windowDidLoad];
    [[self window] setLevel:NSModalPanelWindowLevel];
    [[self window] setFrameAutosaveName:@"WindowInterfaceWindow"];
    
    // Set the window to be visible on all spaces
    [[self window] setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];

    
    [[self window]setFrame:constrainRectToRect([[self window]frame],[[[self window]screen]visibleFrame]) display:NO];
    [(QSWindow *)[self window]setHideOffset:NSMakePoint(0,-99)];
    [(QSWindow *)[self window]setShowOffset:NSMakePoint(0,99)];

    [self contractWindow:self];
}

- (void)updateViewLocations{
    [super updateViewLocations];
}


- (void)hideMainWindow:(id)sender{
    [[self window] saveFrameUsingName:@"WindowInterfaceWindow"];
    [super hideMainWindow:sender];
	[self contractWindow:self];
}



- (NSRect)window:(NSWindow *)window willPositionSheet:(NSWindow *)sheet usingRect:(NSRect)rect{
    return NSOffsetRect(NSInsetRect(rect,8,0),0,-21);
}

- (void)showIndirectSelector:(id)sender{
    if (![iSelector superview] && !expanded)
        [iSelector setFrame:NSOffsetRect([aSelector frame],0,-26)];
    [super showIndirectSelector:sender];
}

- (void)expandWindow:(id)sender{ 
    if (![self expanded]) {
        NSRect expandedRect=[[self window]frame];
        
        expandedRect.size.height+=EXPAND_HEIGHT;
        expandedRect.origin.y-=EXPAND_HEIGHT;
        constrainRectToRect(expandedRect, [[[self window] screen] frame]);
        [[self window]setFrame:expandedRect display:YES animate:YES];
    }
    [super expandWindow:sender];
}

- (void)contractWindow:(id)sender{
    if([self expanded]) {
        NSRect contractedRect=[[self window]frame];
        
        contractedRect.size.height-=EXPAND_HEIGHT;
        contractedRect.origin.y+=EXPAND_HEIGHT;
        
        [[self window]setFrame:contractedRect display:YES animate:YES];
    }
    [super contractWindow:sender];
}


- (void)updateDetailsString {
    NSString *commandName = [[self currentCommand] name];
	[details setStringValue:(commandName ? commandName : @"")];
	return;
	NSResponder *firstResponder = [[self window] firstResponder];
	if ([firstResponder respondsToSelector:@selector(objectValue)]) {
		id object = [firstResponder performSelector:@selector(objectValue)];
		if ([object respondsToSelector:@selector(details)]) {
			NSString *string = [object details];
			if (string) {
				[details setStringValue:string];
				return;
			}
		}
	}
	[details setStringValue:[[self currentCommand] name]];}

- (void)searchObjectChanged:(NSNotification*)notif {
	[super searchObjectChanged:notif];
	[self updateDetailsString];
}

@end