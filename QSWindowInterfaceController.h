/* QSController */

#import <Cocoa/Cocoa.h>

#define kQSWindowInterfaceType @"QSWindowInterfaceType"

@interface QSWindowInterfaceController : QSResizingInterfaceController{
    IBOutlet NSTextField *details;
}
@end