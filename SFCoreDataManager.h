#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface SFCoreDataManager : NSObject

@property(nonatomic,strong) NSManagedObjectContext* context;
@property(nonatomic, strong) NSManagedObjectModel* model;
@property(nonatomic, strong) NSPersistentStoreCoordinator* coordinator;
@property(nonatomic, strong) NSPersistentStore* store;

+ (SFCoreDataManager *)sharedManager;
- (void)saveContext;
- (void)setupCoreData;
-(void)insertEntityWithEntityName:(NSString*)entityName andAttributesDictionary:(NSDictionary*) attributesDictionary;
-(void)searchEntityWithEntityName:(NSString*)entityName andAttributesDictionary:(NSArray*) predicatesArray;
@end