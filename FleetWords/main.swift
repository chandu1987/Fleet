#!/usr/bin/swift

import Foundation

class WordsGenerator{
    
    let kDefaultDictionary = "/usr/share/dict/words"
    var inputArray : [String]?
        
    @discardableResult func findCombinations(_ masterWord:String) -> [String] {
        
        var words = [String]()
        //Remove spaces from the string
        let masterWordWithoutWhiteSpaces = masterWord.replacingOccurrences(of: " ", with: "")
        
        if masterWord.count == 0 || masterWord.count == 1{
            print(masterWord)
            return [masterWord]
        }
        
        //Get all possible combinations of the string.
        let allPossibleCombinations = getAllCombinationsOfString(Array(masterWordWithoutWhiteSpaces))
            print("All possible combinations - \(allPossibleCombinations)")
        
        if inputArray == nil{
            inputArray = getDefaultDictionary()
        }
  
        for str in allPossibleCombinations {
            if inputArray!.contains(where: {$0.caseInsensitiveCompare(str) == .orderedSame}) {
                if str.count > 1 && !words.contains(str) {
                    print(str)
                    words.append(str)
                }
            }
        }
        
        return words
        
    }
    
    
    
    //get all combinations of the words using recursion
    func getAllCombinationsOfString(_ charArray : [Character]) -> [String] {
        
        var wordsArray = [String]()
        
        //if the array count is 0. stop the recursion
        if charArray.count == 0 {
            return []
        }
        
        for i in 0..<charArray.count
        {
            var reducedArray = charArray
            let removedElement = reducedArray.remove(at: i)
            let  oldArray =  getAllCombinationsOfString(reducedArray)
            for j in 0..<oldArray.count{
                let aStr = String(removedElement) + oldArray[j]
                wordsArray.append(aStr)
            }
            wordsArray = [String(removedElement)] + wordsArray
        }
        return  wordsArray
    }
    
    
    //Get Default Dictionary
    func getDefaultDictionary() -> [String]  {
        do{
            let dictionary = try String(contentsOfFile: kDefaultDictionary, encoding: .utf8)
            let arrayOfDictionary = dictionary.components(separatedBy: "\n")
            return arrayOfDictionary
        }catch{
            print(error.localizedDescription)
            return[]
        }
    }
    
}



let wordsGenerator = WordsGenerator()
var inputArray  = [String]()


//read line from input file
print("If input file is long, Please wait until all the words are processed. Press enter if you want to use default dictionary")
while let input = readLine()   {
    if input.count == 0{
        inputArray = wordsGenerator.getDefaultDictionary()
        break
    }else{
        // Check if array already contains the word and also remove the spaces in each word.
        if !inputArray.contains(input) {
            inputArray.append(input.replacingOccurrences(of: " ", with: ""))
        }
    }
}


//check for only 1 argument and pass it to the class
let argCount = CommandLine.argc
if argCount == 2{
    let arguments = CommandLine.arguments
    let stringToBeParsed = arguments[1]
    wordsGenerator.inputArray = inputArray
    let _ = wordsGenerator.findCombinations(stringToBeParsed)
}else{
    print("Invalid Input. Expecting 1 argument..")
}





