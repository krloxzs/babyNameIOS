//
//  RealmHelper.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 1/3/18.
//  Copyright © 2018 Carlos Rodriguez. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
/**
 Class for help in the Realm DB behavior.
 example of usage  for strings
  let predicate = NSPredicate(format: "id = %@", BN.id)
  let flags = realm.objects(babyNameRO.self).sorted(byKeyPath: "id", ascending: true).filter("id == '\(BN.id)'")
  let flags = realm.objects(babyNameRO.self).sorted(byKeyPath: "id", ascending: true).filter("id == 'Lol'")
 :
 */
class realmHelper {
    
    //MARK:- Methods
    /**
     Add a babyName In the dB, if already exist, update it.
     */
    func addBabyName(_ BN : babyNameRO)  {
        let realm = try! Realm()
        try! realm.write {
            logger.log("added to DB.... \(BN.id)")
            realm.add(BN)
        }
    }
    
    func updateBabyName(_ BN : babyNameRO)  {
        let realm = try! Realm()
        try! realm.write {
            logger.log("updated.... \(BN.id)")
            realm.add(BN, update: true)
        }
    }
    
    /**
     check if the object already exist, if not, return true as a flag...
     using a sort for bring the objects ascending (we can use it later) .
     */
    func checkIfBabyNameExist(_ BN : babyNameRO) -> Bool {
        let realm = try! Realm()
        if let flag = realm.objects(babyNameRO.self).filter("id == '\(BN.id)'").first{
            logger.log("object with the id \(flag.id) already exist... ")
            return true
        }else{
             logger.log("object with the id \(BN.id) doesnot exist, is going to be added")
          return false
        }
        
    }
    
    func checkIfBabyidExist(_ id : String) -> Bool {
        let realm = try! Realm()
        if let flag = realm.objects(babyNameRO.self).filter("id == '\(id)'").first{
            logger.log("object with the id \(flag.id) already exist... ")
            return true
        }else{
            logger.log("object with the id \(id) doesnot exist, is going to be added")
            return false
        }
        
    }
    
    func checkIfBabyidIsALikeId(_ id : String) -> Bool {
        let realm = try! Realm()
        if let flag = realm.objects(babyNameRO.self).filter("id == '\(id)'").first{
            logger.log("object with the id \(flag.id) already exist... ")
            if flag.like{
                  return true
            }else{
                  return false
            }
          
        }else{
            logger.log("object with the id \(id) doesnot exist, is going to be added")
            return false
        }
        
    }
    
    func getAllBNFromDB() -> Results<babyNameRO> {
        let realm = try! Realm()
        let babys = realm.objects(babyNameRO.self)
        return babys
    }
    
    func deletObjectFromBD(_ BabyNRO : babyNameRO, success:@escaping () -> Void) {
        // Delete an object with a transaction
        let realm = try! Realm()
        try! realm.write {
            realm.delete(BabyNRO)
         success()
        }
    }
    
    func deletAllFromDB() {
         let realm = try! Realm()
        // Delete all objects from the realm
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
    func migrateBD( migrationDone:@escaping () -> Void, noMigration:@escaping (String) -> Void)  {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 0,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                    noMigration(String(oldSchemaVersion))
                }
        })
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
       _ = try! Realm()
        migrationDone()
    }
}


/*
 -----Filtering -----
 
 ----- example let sortedDogs = realm.objects(Dog.self).filter("color = 'tan' AND name BEGINSWITH 'B'")
 
 The comparison operands can be property names or constants. At least one of the operands must be a property name.
 The comparison operators ==, <=, <, >=, >, !=, and BETWEEN are supported for Int, Int8, Int16, Int32, Int64, Float, Double and Date property types, e.g. age == 45
 Identity comparisons ==, !=, e.g. Results<Employee>().filter("company == %@", company).
 The comparison operators == and != are supported for boolean properties.
 For String and Data properties, the ==, !=, BEGINSWITH, CONTAINS, and ENDSWITH operators are supported, e.g. name CONTAINS 'Ja'
 For String properties, the LIKE operator may be used to compare the left hand property with the right hand expression: ? and * are allowed as wildcard characters, where ? matches 1 character and * matches 0 or more characters. Example: value LIKE '?bc*' matching strings like “abcde” and “cbc”.
 Case-insensitive comparisons for strings, such as name CONTAINS[c] 'Ja'. Note that only characters “A-Z” and “a-z” will be ignored for case. The [c] modifier can be combined with the [d]` modifier.
 Diacritic-insensitive comparisons for strings, such as name BEGINSWITH[d] 'e' matching étoile. This modifier can be combined with the [c] modifier. (This modifier can only be applied to a subset of strings Realm supports: see limitations for details.)
 Realm supports the following compound operators: “AND”, “OR”, and “NOT”, e.g. name BEGINSWITH 'J' AND age >= 32.
 The containment operand IN, e.g. name IN {'Lisa', 'Spike', 'Hachi'}
 Nil comparisons ==, !=, e.g. Results<Company>().filter("ceo == nil"). Note that Realm treats nil as a special value rather than the absence of a value; unlike with SQL, nil equals itself.
 ANY comparisons, e.g. ANY student.age < 21.
 The aggregate expressions @count, @min, @max, @sum and @avg are supported on List and Results properties, e.g. realm.objects(Company.self).filter("employees.@count > 5") to find all companies with more than five employees.
 Subqueries are supported with the following limitations:
 @count is the only operator that may be applied to the SUBQUERY expression.
 The SUBQUERY(…).@count expression must be compared with a constant.
 Correlated subqueries are not yet supported.
 See Results().filter(_:...).
 
  -----Sorting: -----
 
  -----example let ownersByDogAge = dogOwners.sorted(byKeyPath: "dog.age")
 
 Note that sorted(byKeyPath:) and sorted(byProperty:) do not support multiple properties as sort criteria, and cannot be chained (only the last call to sorted will be used). To sort by multiple properties, use the sorted(by:) method with multiple SortDescriptor objects.
 
 For more, see:
 
 Results().sorted(_:)
 Results().sorted(byKeyPath:ascending:)
 
  ----- and together let sortedDogs = realm.objects(Dog.self).filter("color = 'tan' AND name BEGINSWITH 'B'").sorted(byKeyPath: "name")
 
 
  -----for update information in a search/....
 
 try! realm.write {
    for person in realm.objects(Person.self).filter("age == 10") {
        person.age += 1
    }
 }   the age from the object in the db is going to change.....we can update the hole object to....
 */
