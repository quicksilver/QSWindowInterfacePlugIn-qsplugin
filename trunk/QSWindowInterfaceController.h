/* QSController */

#import <Cocoa/Cocoa.h>
#import <QSInterface/QSResizingInterfaceController.h>

#define kQSWindowInterfaceType @"QSWindowInterfaceType"

@interface QSWindowInterfaceController : QSResizingInterfaceController{
    IBOutlet NSTextField *details;
}
@end