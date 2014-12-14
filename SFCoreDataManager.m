#import "SFCoreDataManager.h"
#import "UserData.h"

@implementation SFCoreDataManager

NSString *storeFilename = @"SFDatabase.sqlite";

static SFCoreDataManager *coreDataManager;

+ (instancetype)sharedManager
{
    if (!coreDataManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            coreDataManager = [[SFCoreDataManager alloc] init];
            
        });
        
    }
    
    return coreDataManager;
}

- (id)init {
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator:_coordinator];
    
    return self;
}

- (NSURL *)storeURL {
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    return [[self applicationStoresDirectory]
            URLByAppendingPathComponent:storeFilename];
}

- (void)loadStore {
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if (_store) {
        return;
    }
    
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                        configuration:nil
                                                  URL:[self storeURL]
                                              options:nil
                                                error:&error];
    
    if (!_store) {
        NSLog(@"Failed to add store. Error: %@", error);
        abort();
    } else {
        NSLog(@"Successfully added store: %@", _store);
    }
}

- (void)setupCoreData {
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    [self loadStore];
}

- (NSString *)applicationDocumentsDirectory {
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    return [NSSearchPathForDirectoriesInDomains(
                                                NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)saveContext {
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if ([_context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            NSLog(@"_context SAVED changes to persistent store");
        } else {
            NSLog(@"Failed to save _context: %@", error);
        }
    } else {
        NSLog(@"SKIPPED _context save, there are no changes!");
    }
}

- (NSURL *)applicationStoresDirectory {
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    NSURL *storesDirectory =
    [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]]
     URLByAppendingPathComponent:@"Stores"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storesDirectory path]]) {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL:storesDirectory
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:&error]) {
            NSLog(@"Successfully created Stores directory");
        } else {
            NSLog(@"FAILED to create Stores directory: %@", error);
        }
    }
    return storesDirectory;
}

-(void)insertEntityWithEntityName:(NSString*)entityName andAttributesDictionary:(NSDictionary*) attributesDictionary;
{
    
    UserData *entity = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                     inManagedObjectContext:self.context];
    
    [entity setValue:[attributesDictionary valueForKey:@"username"] forKey:@"username"];
    [entity setValue:[attributesDictionary valueForKey:@"password"] forKey:@"password"];
    [entity setValue:[attributesDictionary valueForKey:@"firstname"] forKey:@"firstname"];
    [entity setValue:[attributesDictionary valueForKey:@"lastname"] forKey:@"lastname"];
    [entity setValue:[attributesDictionary valueForKey:@"gender"] forKey:@"gender"];
    
    [self.context insertObject:entity];
    
    [self saveContext];
    
}

-(BOOL)hasEntityWithEntityName:(NSString *)entityName andPassword:(NSString*) password andUsername:(NSString*) username
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *obj = [NSEntityDescription entityForName:@"UserData"
                                           inManagedObjectContext:self.context];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"username LIKE %@ and password LIKE %@",username, password];
    
    [fetchRequest setEntity:obj];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (!results || error) {
        return NO;
    }
    else if(results.count >= 1){
        return YES;
    }
    return NO;
    
}

-(NSDictionary*)loggedUserDataWithPassword:(NSString*)password andUsername:(NSString*)username{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *obj = [NSEntityDescription entityForName:@"UserData"
                                           inManagedObjectContext:self.context];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"username LIKE %@ and password LIKE %@",username, password];
    
    [fetchRequest setEntity:obj];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:fetchRequest error:&error];
    UserData* user;
    if (!results || error) {
        return nil;
    }
    else if(results.count >= 1){
        user = results[0];
    }
    return [NSDictionary dictionaryWithObjects:@[user.gender, user.lastname] forKeys:@[@"gender", @"lastname"]];
    
    
}

@end
