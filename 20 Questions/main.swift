//
//  main.swift
//  20 Questions
//
//  Created by WALLS BENAJMIN A on 1/20/16.
//  Copyright © 2016 WALLS BENAJMIN A. All rights reserved.
//

import Foundation

//All of this is just to get .shuffle from ruby--------------------------------------------------------------------------------------------------
extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
//-------------------------------------------------------------------------------------------------------

func testInput(input: String, regex: String)->Bool{
    
    let options: NSStringCompareOptions = [.RegularExpressionSearch, .CaseInsensitiveSearch]
    if input.rangeOfString(regex, options:options) != nil {
       return true
    }
    else {
        return false
    }
}

let fileName = "AnimalNames-1.txt";
let fileUtils = FileUtils(fileName: fileName)

var mainAnimalArray = [Animal]()
var animalFileData = fileUtils.readFile();

var gameRunning = true

if(animalFileData != "error"){ //Checks if there is a data file-----------------
    
    var animalFileLines : Array = animalFileData.componentsSeparatedByString("\n")
    
    for animal in animalFileLines{
        let animalInfo = animal.componentsSeparatedByString(",")
        
        if(animalInfo[0] != "" && animalInfo[1] != "" && animalInfo[2] != ""  ){ //checks the data
            let animalClass = Animal(aName:animalInfo[0], aColor:animalInfo[1], aLegs:Int(animalInfo[2])!)
            mainAnimalArray.append(animalClass)
            
        }
        
        if(mainAnimalArray.count == 0){// If no data is found, adds this to the array so the game has somthing to guess
            let animalClass = Animal(aName:"dog", aColor:"brown", aLegs:4)
            mainAnimalArray.append(animalClass)
        }
        
    }


}else{
    print("Error 404 - file not found")
    gameRunning = false
}


while(gameRunning == true){ //so that program does not need to be started over to start new game
    
    var animalColor = [String]()
    var animalLegs = [Int]()
    for animal in mainAnimalArray{ //This loop gets uneque values for color and legs so that I can ask that to the user
        animalColor.append(animal.getColor())
        animalLegs.append(animal.getLegs())
    }
    
    animalColor = Array(Set(animalColor)).shuffle()
    animalLegs = Array(Set(animalLegs)).shuffle()
    mainAnimalArray = mainAnimalArray.shuffle()
    
    var giveUp = false //For if computer does not have enough information to guess
    var correctGuess = false
    var playerInput = ""
    var guessesLeft = 20
    
    while( guessesLeft > 0){
        
        print("Hello, guess a animal!")
        
        var playerColor = ""
        var playerLegs = -1
        var colorCounter = 0
        
        while(colorCounter < animalColor.count){ //get color, runs through array.
            print("Is your animal \(animalColor[colorCounter])? (y/n): ", terminator:"")
            playerInput = String(readLine(stripNewline: true)!)
            
            if(playerInput.lowercaseString  == "y"){
                playerColor = animalColor[colorCounter]
                colorCounter = animalColor.count
                
            }else{
                colorCounter += 1
            }
            guessesLeft -= 1
            
            if(guessesLeft == 0){
                colorCounter = animalColor.count
                giveUp = true
                guessesLeft = 0
            }
        }
        //where number of leg guessing begins-------------------------------------------------------------------------------------------------------
        if(playerColor == ""){
            giveUp = true
            guessesLeft = 0
            
        }else{
            var legCounter = 0
            
            while(legCounter < animalLegs.count){ //get num legs
                print("Does your animal have \(animalLegs[legCounter]) legs? (y/n): ", terminator:"")
                playerInput = String(readLine(stripNewline: true)!)
                
                if(playerInput.lowercaseString == "y"){
                    playerLegs = animalLegs[legCounter]
                    legCounter = animalLegs.count
                    
                }else{
                    legCounter += 1
                }
                
                guessesLeft -= 1
                
                if(guessesLeft == 0){
                    legCounter = animalLegs.count
                    print("was called")
                    giveUp = true
                }
                
            }
            
        }
        //Where name guessing begins-------------------------------------------------------------------------------------------------------
        if(playerLegs == -1){
            giveUp = true
            guessesLeft = 0
            
        }else{
    
            var nameCounter = 0
            while(nameCounter < mainAnimalArray.count){
                
                if(playerColor == mainAnimalArray[nameCounter].getColor() && playerLegs == mainAnimalArray[nameCounter].getLegs()){
                    print("Is your animal a \(mainAnimalArray[nameCounter].getName())? (y/n): ", terminator:"")
                    playerInput = String(readLine(stripNewline: true)!)
                    
                    if(playerInput.lowercaseString == "y"){
                        nameCounter = mainAnimalArray.count
                        guessesLeft = 0
                        correctGuess = true
                    
                    }else{
                        guessesLeft -= 1
                        nameCounter += 1
                    }
                    
                }else{
                    nameCounter += 1
                    if(nameCounter == mainAnimalArray.count){
                        guessesLeft = 0
                    }
                }
                
                if(guessesLeft <= 0 && correctGuess == false || nameCounter == mainAnimalArray.count && correctGuess == false){
                    nameCounter = mainAnimalArray.count
                    giveUp = true
                    
                }
                
            }
        }
        
    }
    
    if(giveUp == true){
        var newName = "";
        var newColor = "";
        var newNumLegsTest = ""
        var newNumLegs = 0;
        
        print("I give up, you win!")
        
        //NAME-------------------------------------------------------------------------------------------------------
        var correctInputName = false
        while(correctInputName == false){// TESTS COLOR INPUT
            print("What was your animal's name? ", terminator:"")
            newName = String(readLine(stripNewline: true)!)
            
            if(testInput(newName, regex: "^[a-zA-Z]{1,20}\\s{0,1}[a-zA-Z]{1,20}$")){
                newName = newName.lowercaseString
                correctInputName = true
                
            }else{
                
                print("Please enter a name that is less than 50 charaters\n")
            }
            
            
        }
        
        //COlOR-------------------------------------------------------------------------------------------------------
        var correctInputColor = false
        while(correctInputColor == false){// TESTS COLOR INPUT
            print("What was your animal's color? ", terminator:"")
            newColor = String(readLine(stripNewline: true)!)
            
            if(testInput(newColor, regex: "^[a-zA-Z]{2,30}$")){
                newColor = newColor.lowercaseString
                correctInputColor = true
                
            }else{
                
                print("Please enter a color that is less than 30 charaters.\n")
            }
        
        
        }
 
        //LEGS-------------------------------------------------------------------------------------------------------
        var correctInputNumlegs = false
        while(correctInputNumlegs == false){// TESTS NUM LEGS SO IT WONT CRASH, AND IS ACUALY A NUMBER
            print("How many legs does your animal have? ", terminator:"")
            newNumLegsTest = String(readLine(stripNewline: true)!)
            
            if(testInput(newNumLegsTest, regex: "^[0-9]{1,3}$")){
                newNumLegs = Int(newNumLegsTest)!
                correctInputNumlegs = true
                
            }else{
            
                print("Please enter a number less than 99.\n")
            }
        
        }
        
        print("\nThank you, your animal is now in my braaain.\n")
        
        mainAnimalArray.append(Animal(aName:newName, aColor:newColor, aLegs:newNumLegs))
        
    }else{
        print("I win!")
    }
    
    var writeOutString = ""
    var counter = 0
    
    for animal in mainAnimalArray{
        writeOutString += "\(animal.getName()),\(animal.getColor()),\(String(animal.getLegs()))"
        
        counter += 1
        
        if(mainAnimalArray.count > counter){
            writeOutString += "\n"
        }
    }
    
    fileUtils.writeFile(writeOutString)
    
    print("Do you want to play again? (y/n): ", terminator:"")
    playerInput = String(readLine(stripNewline: true)!)
    print("\n")
    
    if(playerInput.lowercaseString != "y"){
        print("Goodbye!")
        gameRunning = false
        
    }
    
}











