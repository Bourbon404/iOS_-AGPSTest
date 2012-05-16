#import "YMSViewController.h"

@interface YMSViewController ()

@end

@implementation YMSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)getInfo:(id)sender{
    CoreTelephony *ct = [[CoreTelephony alloc] init];
    [ct getCellInfo];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
