#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserData.h"
@interface SFCoreDataManager : NSObject

@property(nonatomic,strong) NSManagedObjectContext* context;
@property(nonatomic, strong) NSManagedObjectModel* model;
@property(nonatomic, strong) NSPersistentStoreCoordinator* coordinator;
@property(nonatomic, strong) NSPersistentStore* store;

+ (SFCoreDataManager *)sharedManager;

- (void)saveContext;

- (void)setupCoreData;

- (void)insertEntityWithEntityName:(NSString*)entityName andAttributesDictionary:(NSDictionary*) attributesDictionary;

- (BOOL)hasEntityWithEntityName:(NSString *)entityName andPassword:(NSString*) password andUsername:(NSString*) username;

-(NSDictionary*)loggedUserDataWithPassword:(NSString*)password andUsername:(NSString*)username;

@end
