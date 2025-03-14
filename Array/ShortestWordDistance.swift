/**
 * Question Link: https://leetcode.com/problems/shortest-word-distance/
 * Primary idea: Iterate and update index and distance when encounter word1 or word2
 * Time Complexity: O(n), Space Complexity: O(1)
 */

class ShortestWordDistance {
    func shortestDistance(_ words: [String], _ word1: String, _ word2: String) -> Int {
        var minDistance = Int.max, word1Idx = -1, word2Idx = -1
        
        for (i, word) in words.enumerated() {
            if word == word1 {
                word1Idx = i
                
                if word2Idx != -1 {
                    minDistance = min(i - word2Idx, minDistance)
                }
            } else if word == word2 {
                word2Idx = i
                
                if word1Idx != -1 {
                    minDistance = min(i - word1Idx, minDistance)
                }
            }
        }
        
        return minDistance
    }
}

// let wordsDict = ["practice", "makes", "perfect", "coding", "makes"], word1 = "coding", word2 = "practice"
let wordsDict = ["practice", "makes", "perfect", "coding", "makes"], word1 = "makes", word2 = "coding"
func minDist(_ words: [String], _ word1: String, _ word2: String) -> Int {
    
    var minDist = Int.max
    var word1Index: Int? = nil
    var word2Index: Int? = nil
    for (i, word) in words.enumerated() {
        if word == word1 {
            word1Index = i
        }
        if word == word2 {
            word2Index = i
        }
        if let word1Index = word1Index, 
           let word2Index = word2Index {
            minDist = min(minDist, 
                         abs(word1Index - word2Index)
            )
        }
    }
    
    return minDist
}
print(minDist(wordsDict, word1, word2))
