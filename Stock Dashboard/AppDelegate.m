#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSTextField *inputField;
@property (strong, nonatomic) NSTextField *displayLabel;
@property (strong, nonatomic) NSImageView *stockImageView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSWindow *mainWindow = [NSApplication sharedApplication].mainWindow;
        
        if (mainWindow) {
            NSLog(@"Main window found, setting up input field, button, and label.");
            [mainWindow setTitle:@"Stock Dashboard"];
            
            NSRect newFrame = NSMakeRect(0, 0, 600, 500);
            [mainWindow setFrame:newFrame display:YES];
            [mainWindow center];

            NSRect windowFrame = mainWindow.contentView.frame;

            self.inputField = [[NSTextField alloc] initWithFrame:NSMakeRect((windowFrame.size.width - 300) / 2, windowFrame.size.height - 100, 200, 30)];
            [self.inputField setPlaceholderString:@"Enter stock symbol"];
            [self.inputField setBezeled:YES];
            [self.inputField setBezelStyle:NSTextFieldRoundedBezel];
            [[mainWindow contentView] addSubview:self.inputField];

            NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect((windowFrame.size.width + 100) / 2, windowFrame.size.height - 100, 100, 30)];
            [button setTitle:@"Fetch Info"];
            [button setButtonType:NSButtonTypeMomentaryPushIn];
            [button setTarget:self];
            [button setAction:@selector(fetchStockInfo)];
            [[mainWindow contentView] addSubview:button];
            
            self.displayLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(20, windowFrame.size.height - 250, windowFrame.size.width - 40, 100)];
            [self.displayLabel setBezeled:NO];
            [self.displayLabel setDrawsBackground:NO];
            [self.displayLabel setEditable:NO];
            [self.displayLabel setSelectable:NO];
            [self.displayLabel setAlignment:NSTextAlignmentCenter];
            [self.displayLabel setStringValue:@""];
            [[mainWindow contentView] addSubview:self.displayLabel];
            
            self.stockImageView = [[NSImageView alloc] initWithFrame:NSMakeRect((windowFrame.size.width - 100) / 2, windowFrame.size.height - 360, 100, 100)];
            [self.stockImageView setImageScaling:NSImageScaleProportionallyUpOrDown];
            [[mainWindow contentView] addSubview:self.stockImageView];
        } else {
            NSLog(@"Main window is still nil.");
        }
    });
}

- (void)fetchStockInfo {
    NSString *symbol = [self.inputField stringValue];
    if (symbol.length == 0) {
        [self.displayLabel setStringValue:@"Please enter a stock symbol."];
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"https://financialmodelingprep.com/api/v3/profile/%@?apikey=3f8cca0bc1f6e66fc6cb8e701c556d60", symbol];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Error: %@", error.localizedDescription);
                [self.displayLabel setStringValue:@"Failed to fetch stock data."];
            });
            return;
        }
        
        NSError *jsonError;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError || jsonArray.count == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.displayLabel setStringValue:@"Invalid stock symbol or data unavailable."];
            });
            return;
        }
        
        NSDictionary *stockData = jsonArray.firstObject;
        NSString *companyName = stockData[@"companyName"];
        NSString *price = [NSString stringWithFormat:@"$%@", stockData[@"price"]];
        NSString *sector = stockData[@"sector"];
        NSString *imageURLString = stockData[@"image"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.displayLabel setStringValue:[NSString stringWithFormat:@"Company: %@\nPrice: %@\nSector: %@", companyName, price, sector]];
            
            NSURL *imageURL = [NSURL URLWithString:imageURLString];
            NSURLSessionDataTask *imageTask = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *imageData, NSURLResponse *response, NSError *error) {
                if (imageData && !error) {
                    NSImage *image = [[NSImage alloc] initWithData:imageData];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.stockImageView setImage:image];
                    });
                } else {
                    NSLog(@"Failed to load image: %@", error.localizedDescription);
                }
            }];
            [imageTask resume];
        });
    }];
    
    [task resume];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

@end
