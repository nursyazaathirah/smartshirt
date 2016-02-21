//
//  DataCollectionViewController.m
//  ArcShirt
//
//  Created by john on 4/5/15.
//  Copyright (c) 2015 CS 145 Team. All rights reserved.
//

#import "DataCollectionViewController.h"
#import "DataCell.h"
#import "PBBlueDotView.h"
#import "JSBatteryLevel.h"

#define kCNCoinBLEServiceUUID @"3870cd80-fc9c-11e1-a21f-0800200c9a66"
#define kCNCoinBLEWriteCharacteristicUUID @"E788D73B-E793-4D9E-A608-2F2BAFC59A00"
#define kCNCoinBLEReadCharacteristicUUID @"4585C102-7784-40B4-88E1-3CB5C4FD37A3"

@interface DataCollectionViewController ()

@property CGRect screenRect;
@property (nonatomic,strong) UIImageView *shirtImageView;
@property (nonatomic,strong) PBBlueDotView *leftNeckDot;
@property (nonatomic,strong) PBBlueDotView *rightNeckDot;
@property (nonatomic,strong) PBBlueDotView *leftArmDot;
@property (nonatomic,strong) PBBlueDotView *rightArmDot;
@property (nonatomic,strong) JSBatteryLevel *batteryLevel;
@property int count;
@property bool decrease;
@property (nonatomic) NSMutableArray *datas;

/* Model */
@property (strong,nonatomic) CBCentralManager *centralManager;
@property (strong,nonatomic) NSNumber *rssi;
@property (strong,nonatomic) CBPeripheral *peripheral;
@property (strong,nonatomic) NSMutableArray *peripherals;
@property (strong,nonatomic) CBCharacteristic *CoinWriteCharacteristic;

@end

@implementation DataCollectionViewController

static NSString * const reuseIdentifier = @"Data";

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.screenRect = [[UIScreen mainScreen] bounds];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(self.screenRect.size.width/2 - 1.0
                                     , self.screenRect.size.width/2.5);
        layout.minimumInteritemSpacing = 1.0;
        layout.minimumLineSpacing = 1.5;
        layout.headerReferenceSize = CGSizeMake(0,0);
        self = [super initWithCollectionViewLayout:layout];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpDevice];
    [self setUpView];
    
    /* check the connection every 5 seconds */
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(makeBright)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)setUpDevice
{
    self.centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    
    self.peripherals = [[NSMutableArray alloc]init];
}

- (void)setUpView
{
    self.view.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[DataCell class] forCellWithReuseIdentifier:@"Data"];
    UIImage *shirtImage = [UIImage imageNamed:@"shirt"];
    self.shirtImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.screenRect.size.width/10,
                                                                       self.screenRect.size.height/16,
                                                                       (8 * self.screenRect.size.width/10),
                                                                       self.screenRect.size.height/2.5)];
    self.shirtImageView.image = shirtImage;
    [self.view addSubview:self.shirtImageView];
    self.collectionView.frame = CGRectMake(0,
                                           self.screenRect.size.height/2.3,
                                           self.screenRect.size.width,
                                           self.screenRect.size.height/1.5);
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.count = 0;
    self.decrease = false;
    
    [self setUpDatas];
    [self addDotsAndBattery];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.leftArmDot removeFromSuperview];
    [self.rightArmDot removeFromSuperview];
    [self.leftNeckDot removeFromSuperview];
    [self.rightNeckDot removeFromSuperview];
}

#pragma mark helper

- (void)addDotsAndBattery
{
    self.leftArmDot = [[PBBlueDotView alloc]initWithFrame:CGRectMake(self.screenRect.size.width/10,
                                                                     self.screenRect.size.height/8,
                                                                     self.screenRect.size.width/5,
                                                                     self.screenRect.size.width/5)];
    [self.view addSubview:self.leftArmDot];
    
    self.rightArmDot = [[PBBlueDotView alloc]initWithFrame:CGRectMake((9 * self.screenRect.size.width/10) -
                                                                      self.screenRect.size.width/5,
                                                                      self.screenRect.size.height/8,
                                                                      self.screenRect.size.width/5,
                                                                      self.screenRect.size.width/5)];
    [self.view addSubview:self.rightArmDot];
    
//    self.leftNeckDot = [[PBBlueDotView alloc]initWithFrame:CGRectMake(self.screenRect.size.width/4,
//                                              3                        self.screenRect.size.height/10,
//                                                                      self.screenRect.size.width/5,
//                                                                      self.screenRect.size.width/5)];
//    [self.view addSubview:self.leftNeckDot];
//    
//    self.rightNeckDot = [[PBBlueDotView alloc]initWithFrame:CGRectMake((3 * self.screenRect.size.width/4) -
//                                                                       self.screenRect.size.width/5,
//                                                                       self.screenRect.size.height/10,
//                                                                       self.screenRect.size.width/5,
//                                                                       self.screenRect.size.width/5)];
    [self.view addSubview:self.rightNeckDot];
    
    self.batteryLevel = [[JSBatteryLevel alloc]initWithFrame:CGRectMake(self.screenRect.size.width/2 - self.screenRect.size.width/10,
                                                                        self.screenRect.size.height/5,
                                                                        self.screenRect.size.width/5,
                                                                        self.screenRect.size.width/5)];
    [self.batteryLevel addTarget:self
                        action:@selector(blink)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.batteryLevel];
}

- (void)setUpDatas
{
    /* Clear the user defaults for testing purpose */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defaults dictionaryRepresentation];
    for (id key in dict) {
        [defaults removeObjectForKey:key];
    }
    
    self.datas =  [defaults objectForKey:@"rooms"];
    if (!self.datas) {
    
        self.datas = [[NSMutableArray alloc]init];
        [self addData:@"Heart Rate"];
        [self addData:@"Calories"];
        [self addData:@"Temperature"];
        [self addData:@"Steps Taken"];
        [self addData:@" "];
        [self addData:@" "];

        [defaults setObject:self.datas forKey:@"rooms"];
    }
    [defaults synchronize];
}

- (void)addData:(NSString*)name
{
    [self.datas addObject:name];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [defaults setObject:array forKey:name];
    [defaults synchronize];
}

- (void)makeBright
{
    
    if (self.count > 11 || self.decrease) {
        self.count--;
        [self.batteryLevel dimDown:self.count];
        if (self.count <= 0) {
            self.decrease = false;
        }
    }
    
    else {
        [self.batteryLevel lightUp:self.count];
        self.count++;
        if (self.count > 11) {
            self.decrease = true;
        }
    }
}

- (void)blink
{
    NSString *str;
    str = [NSString stringWithFormat:@"b"];
    [self sendDataWithoutResponse:str];
    NSLog(@"Sending b");
}

- (void)sendDataWithoutResponse:(NSString *)dataStr
{
    //Cut and send in 20 character size
    NSString *tmpStr;
    int x = 0;

        for (x = 0; x + 20 < [dataStr length]; x = x + 20)
        {
            tmpStr = [dataStr substringWithRange:NSMakeRange(x, 20)];
            [self.peripheral writeValue:[tmpStr dataUsingEncoding:NSUTF8StringEncoding]
                 forCharacteristic:self.CoinWriteCharacteristic
                              type:CBCharacteristicWriteWithResponse];
        }
        
        [self.peripheral writeValue:[[dataStr substringWithRange:NSMakeRange(x, [dataStr length] - x)] dataUsingEncoding:NSUTF8StringEncoding]
             forCharacteristic:self.CoinWriteCharacteristic
                          type:CBCharacteristicWriteWithResponse];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DataCell *cell = (DataCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSString *data = [self.datas objectAtIndex:indexPath.row];

    cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                              0,
                                                              self.screenRect.size.width/2,
                                                              self.screenRect.size.width/10)];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:@"GillSans-Light" size:15.0];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = data;
    [cell addSubview:label];

    UIImage *image = [UIImage imageNamed:data];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                         self.screenRect.size.width/6,
                                                                         self.screenRect.size.width/8,
                                                                         self.screenRect.size.width/8)];
    imageView.image = image;
    [cell addSubview:imageView];
    
    UILabel *units = [[UILabel alloc]initWithFrame:CGRectMake(self.screenRect.size.width/3,
                                                              self.screenRect.size.width/4.3,
                                                              self.screenRect.size.width/8,
                                                              self.screenRect.size.width/8)];
    units.textAlignment = NSTextAlignmentLeft;
    units.font = [UIFont fontWithName:@"GillSans-Light" size:15.0];
    units.textColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    units.textAlignment = NSTextAlignmentCenter;

    if ([data isEqualToString:@"Calories"]) {
        units.text = @"Cal";
    }
    
    else if ([data isEqualToString:@"Steps Taken"]) {
        units.text = @"Steps";
    }
    
    else if ([data isEqualToString:@"Temperature"]) {
        units.text = @" C";
    }

    else if ([data isEqualToString:@"Heart Rate"]){
        units.text = @"BPM";
    }
    
    else {
        units.text = @" ";
    }
    
    [cell addSubview:units];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/



#pragma mark - CBCentralManager delegate

-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    [self.collectionView reloadData];
    if (central.state != CBCentralManagerStatePoweredOn) {
        
    }
    else {
        [central scanForPeripheralsWithServices:nil options:nil];
    }
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Discovered: %@",peripheral.name);

    if ([peripheral.name hasPrefix:@"Coin"]) {
        peripheral.delegate = self;
        self.peripheral = peripheral;
        [central connectPeripheral:peripheral options:nil];
    }

//    if ([peripheral.name hasPrefix:@"Coin"]) {
//        
//        [self.peripherals addObject:peripheral];
//        [central connectPeripheral:peripheral options:nil];
//    }
    
    /* Create a NSUserDefualt to store the array */
    
    /* Create a NSArray to store the rooms */
    
    /* Store the array in User Defaults */
    
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Connected: %@",peripheral.name);
    [self.collectionView reloadData];
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Disconnected: %@",peripheral.name);

}


#pragma mark - CBPeripheral delegate

- (void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"Discovering Service in: %@",peripheral.name);

    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCNCoinBLEWriteCharacteristicUUID]])
        {
            NSLog(@"Found CoinWriteCharacteristic!");

            self.CoinWriteCharacteristic = characteristic;
        }
    }
}



@end
