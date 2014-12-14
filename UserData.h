#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface UserData : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * gender;

@end
