//
//  ViewController.m
//  StarWars
//
//  Created by Sam Meech-Ward on 2019-01-24.
//  Copyright © 2019 meech-ward. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSDictionary *> *people;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController


- (void)anotherWay {
  NSURL *url = [NSURL URLWithString:@"https://swapi.co/api/people/"];
  NSURLSession *urlSession = [NSURLSession sharedSession];
  NSURLSessionDataTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error) {
      NSLog(@"AHHHH ERRRORRRRR!!!!!!!!!! %@", error);
      return;
    }
    
    NSError *jsonError;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
      NSLog(@"AHHHH ERRRORRRRR!!!!!!!!!! %@", jsonError);
      return;
    }
    
    self.people = json[@"results"];
    
    // Update the ui on the main queue.
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self.tableView reloadData];
    }];
    
  }];
  
  [task resume];
}

- (NSMutableURLRequest *)constructStarWarsURLRequest {
  NSString *method = @"GET";
  NSString *uri = @"https://swapi.co/api/";
  NSString *path = @"people/";
  
  // Just the URL
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", uri, path]];
  
  // The URL and all of the other HTTP options
  NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
  urlRequest.URL = url;
  urlRequest.HTTPMethod = method;
  [urlRequest setValue:@"application/json" forHTTPHeaderField:@"accept"];
  
  return urlRequest;
}

- (void)makeRequest:(NSURLRequest *)urlRequest {
  // setup the url session object
  NSURLSession *urlSession = [NSURLSession sharedSession];
  
//  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  
//  config.timeoutIntervalForRequest = 0.5;
  
  
//  NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config];
  
  // create a data task object from the url session
  // This is the thing that makes the HTTP request
  NSURLSessionDataTask *task = [urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error) {
      NSLog(@"AHHHH ERRRORRRRR!!!!!!!!!! %@", error);
      return;
    }
    
//    NSString *json = [[NSString alloc] initWithData:data encoding:kCFStringEncodingUTF8];
    
    NSError *jsonError;
    // dataWithJSONObject
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
      NSLog(@"AHHHH ERRRORRRRR!!!!!!!!!! %@", jsonError);
      return;
    }
    
    NSArray *people = json[@"results"];
    NSDictionary *firstPerson = people[0];
    NSLog(@"first person's name: %@", firstPerson[@"name"]);
    
    NSLog(@"%@\n%@\n%@", json, response, error);
    
    self.people = people;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self.tableView reloadData];
    }];
  }];
  
  // resume teh data task
  [task resume];
  
  // here i have access to the data.
}

- (IBAction)doAThing:(id)sender {
//  NSLog(@"start a thing");
//  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    [NSThread sleepForTimeInterval:5.0];
//    NSLog(@"hello");
//  });
//  NSLog(@"🤗");
  
  NSURLRequest *request = [self constructStarWarsURLRequest];
  [self makeRequest:request];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
  NSDictionary *person = self.people[indexPath.row];
  
  cell.textLabel.text = person[@"name"];
  
  return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.people.count;
}

@end
