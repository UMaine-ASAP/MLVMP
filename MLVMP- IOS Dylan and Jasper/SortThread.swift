//
//  SortThread.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Administrator on 6/18/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import Foundation


class SortThread: NSObject {
    var species = [Species]()
    var matches = [Species]()
    var misMatches = [Species]()
    var stackOfMismatches = Stack<[Species]>()
    var pTagQueueCount = 0
    var corruptJsons = 0
    
    static var globalSortThread: SortThread?
    var sortThread: NSThread?

    static func getSortThread() -> SortThread{
        if(globalSortThread==nil){
            globalSortThread = SortThread()
            globalSortThread?.sortThread = NSThread(target: globalSortThread!, selector: "doStuff:", object: nil)
        }
        return globalSortThread!
    }
    
    func getThread() -> NSThread{
        return sortThread!
    }
    
     let lockQueue = dispatch_queue_create("com.asap.LockQueue", nil)
     var tagQueue: Array<String> = [];

     func addToQueue(tag: String){
        
        dispatch_sync(lockQueue) {
            self.tagQueue.append(tag)
            
            
        }
    }
    
     func retrieveMatches() -> [Species]{
        var tempMatches = [Species]()
        
        dispatch_sync(lockQueue){
            
        tempMatches = self.matches
        }
        
        return tempMatches
    }
    
    func back(){
        
        
        dispatch_sync(lockQueue){
            
        }
    
        if(self.stackOfMismatches.items.count != 0){
        
            var tempArray = self.stackOfMismatches.pop() as [Species]
            
        
            for(var i = 0; i < tempArray.count; i++){

                self.matches.append(tempArray[i])
            
        }
            
            
    }
}
    
    
    func resetMatches(){
        dispatch_sync(lockQueue){
            
        }

        if(self.stackOfMismatches.items.count != 0){

            let stackedArrays = self.stackOfMismatches.items.count
            
            for(var index: Int = 0; index < stackedArrays; index++){
                var tempArray = self.stackOfMismatches.pop() as [Species]

                for(var index2: Int = 0; index2 < tempArray.count; index2++){

                    
                    self.matches.append(tempArray[index2])

                }
                
            }
            
        }
        
        
    }
    
    func jsonSpeciesResponse(location: String) -> [String : AnyObject] {
        let path = NSBundle.mainBundle().pathForResource("species JSON files (updated/" + location, ofType: "json")
        let data = try? NSData(contentsOfFile: path!, options: NSDataReadingOptions.DataReadingUncached)
        let json: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
        
        if(!(json == nil)){
        return json as! [String : AnyObject]
        }else{
            return ["key":"value"]
        }
    }
    
   func doStuff(o: AnyObject?){
        
        //Sets up path to folder containing species json files.----------
        var error: NSError? = nil
        let mainBundle: NSBundle = NSBundle.mainBundle()
        //Adjusts resource path name to designated folder.
        let pathToSpeciesJsonFiles: String = (mainBundle.resourcePath! as NSString).stringByAppendingPathComponent("species JSON files (updated")
        let defaultManager = NSFileManager()
        //Stores the names of files in the designated folder in a String array.
        let speciesJsonFiles: NSArray = try! defaultManager.contentsOfDirectoryAtPath(pathToSpeciesJsonFiles)
    
        for( var index: Int = 1; index < speciesJsonFiles.count; index++){
            
            //Grabs json file name and parses out the file type extension.
            var parsedSpeciesName = speciesJsonFiles[index].componentsSeparatedByString(".")
            //First index (0) would be the name of the species while the second (1) is the file type extension.
            let speciesFileName: String = parsedSpeciesName[0] 
            //Creates an AnyObject array with String Keys (dictionary) and stores the appropriate species json file within.
            var speciesJsonFile = [String : AnyObject]()
            speciesJsonFile = jsonSpeciesResponse(speciesFileName)
            
            //JsonSpeciesResponse will return a dictionary with less than 3 keys if the json file returns nil. Json files that return nil contain invsibile characters which disrupt parsing. These files must be fixed.
            if(speciesJsonFile.count > 3){
            //Parses appropriate json file into species class parameters.
                
                
                
                //Name
                let speciesName = speciesJsonFile["name"] as! String
                
                //Optional scientific name.
                var scientificName = String?()
                if(!(speciesJsonFile["scientific name"] == nil)){
                    scientificName = speciesJsonFile["scientific name"] as? String
                  
                }else{
                    scientificName = nil
                }
                
                //Species tag.
                let targetSpeciesTags = speciesJsonFile["tags"] as! [String]
                
                //Species pictures.
                let targetSpeciesPictureNames = speciesJsonFile["pictures"] as! [String]
              
                
                //Grabs information dictionary within each species json file.
                var informationDictionary = [String : AnyObject]()
                informationDictionary = speciesJsonFile["information"] as! [String : AnyObject]
                var info = [informationSectionObject]()
                for section in informationDictionary
                {   let sectionName = section.0
                    let sectionParser = section.1 as! NSArray
                    var sectionArray = [String]()
                    
                    for bullet in sectionParser
                    {
                        sectionArray.append(bullet as! String)
                    }
                    let newSection = informationSectionObject(title: sectionName, bullets: sectionArray)
                    info.append(newSection)
                }
                info.sortInPlace { return $0.order < $1.order}
                
                
                
                
                
                //Optional invasive.
                var invasive = [String]?()
                if(!(informationDictionary["Invasive"] == nil)){
                    
                    
                    
                    invasive = informationDictionary["Invasive"] as? [String]
                    
                    invasive!.append("Invasive")
                    
                }else{
                    invasive = nil
                }
                
                
                //Creates species class from json parsed information.
                self.species.append(Species(name: speciesName,
                    scientificName: scientificName,
                    tags: targetSpeciesTags,
                    pictures: targetSpeciesPictureNames,
                    invasive: invasive, information: info))
                
            } else{
                corruptJsons += 1
                
            }
            
        }
    
        
        for(var index: Int = 0; index < self.species.count; index++){
            self.matches.append(species[index])
        }
        
        while(true){
            dispatch_sync(self.lockQueue) {
                
                if(self.tagQueue.count == 1){

                    for(var index: Int = 0; index < self.matches.count; index++){
                        var matched = false
                    
                        for(var index2: Int = 0; index2 < self.matches[index].tags.count; index2++){
                        
                            if(self.matches[index].tags[index2] == self.tagQueue.last){
                                matched = true
                                

                                
                            }
                        }
                        
                        if(matched == false){
                            self.misMatches.append(self.matches[index])
                            self.matches.removeAtIndex(index)
                            index--
                        }
                    
                    
                    }
                    
                self.stackOfMismatches.push(self.misMatches)
                self.misMatches.removeAll(keepCapacity: false)
                self.tagQueue.removeAtIndex(0)
                
                }
                
            }
        }
    }
}

struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}
