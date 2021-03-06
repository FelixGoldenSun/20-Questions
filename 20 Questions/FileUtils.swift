//
//  FileUtils.swift
//  20 Questions
//
//  Created by WALLS BENAJMIN A on 1/20/16.
//  Copyright © 2016 WALLS BENAJMIN A. All rights reserved.
//

import Foundation

class FileUtils{
    
    var fileName = "";
    var defaultDirectory = "~/Desktop";
    var path = "";
    
    init(fileName: String, location: String){
        self.fileName = fileName;
        path = location + "/" + fileName;
    }
    
    init(fileName: String){
        self.fileName = fileName;
        path = defaultDirectory + "/" + fileName;
        
    }
    
    
    func readFile()->String{
        var retString = ""
        let location = NSString(string:path).stringByExpandingTildeInPath
        let content = NSData(contentsOfFile: location)
        
        if(content != nil){
            let dataString = String(data: content!, encoding:NSUTF8StringEncoding )
            if let c = dataString {
                retString = c
            }
            
        }else{
            retString = "error"
            
        }

        
        return retString;
    }
    
    
    func writeFile(data: String)->Bool{
        var retVal = false;
        let location = NSString(string:path).stringByExpandingTildeInPath
        
        do{
            try data.writeToFile(location, atomically: true, encoding:NSUTF8StringEncoding)
                retVal = true;
            
        }catch let error as NSError{
            print("Error: \(error)");
            
        }
        
        return retVal;
    }
}
