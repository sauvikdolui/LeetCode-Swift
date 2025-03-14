/**
 * Question Link: https://leetcode.com/problems/missing-ranges/
 * Primary idea: Scan the array and compare each element with previous one and generate  corresponding ranges
 *
 * Time Complexity: O(n), Space Complexity: O(1)
 *
 */

 class MissingRanges {
    func findMissingRanges(_ nums: [Int], _ lower: Int, _ upper: Int) -> [String] {     
        var res = [String]()
        
        guard !nums.isEmpty else {
            addRange(&res, lower, upper)
            return res
        }
        
        addRange(&res, lower, nums[0] - 1)
        
        for i in 1..<nums.count {
            addRange(&res, nums[i - 1] + 1, nums[i] - 1)
        }
        
        addRange(&res, nums[nums.count - 1] + 1, upper)
        
        return res
    }
    
    private func addRange(_ res: inout [String], _ start: Int, _ end: Int) {
        if start > end {
            return
        } else if start == end {
            res.append("\(end)")
        } else {
            res.append("\(start)->\(end)")
        }
    }
}


infix operator **
extension Int {
    static func ** (_ num: Int, _ power: Int) -> Int {
        var result = 1
        for _ in 0..<power {
            result *= num
        }
        return result
    }
}

// let nums = [0, 1, 3, 50, 75], lower = 0, upper = 99
// Output: ["2", "4->49", "51->74", "76->99"]
// let nums = [1, 2, 3, 4, 5], lower = 1, upper = 5
// let nums = [1, 10], lower = 1, upper = 10
// let nums = [-10, 0, 10], lower = 1, upper = 5
// let nums = [1, 2, 4, 5], lower = 1, upper = 5
// let nums: [Int] = [], lower: Int = 1, upper: Int = 3
// let nums = [5], lower = 5, upper = 5
// let nums = [3, 4, 5, 8, 9], lower = 1, upper = 10
// let nums = [-3, -2, 2, 3], lower = -5, upper = 5
let nums = [-(10**6), 0, 10**6], lower = -(10**6), upper = 10**6
print(missingRange(nums, lower, upper))

func missingRange(_ nums: [Int], _ lower: Int, _ upper: Int) -> [String] {

    var result = [String]()
    var prev = lower - 1
    
    // Iterate through nums with an extra iteration for the upper bound
    for i in 0...nums.count {
        let num = (i < nums.count) ? nums[i] : upper + 1
        if num - prev == 2 {
            // Single missing number
            result.append("\(prev + 1)")
        } else if num - prev > 2 {
            // Range of missing numbers
            result.append("\(prev + 1)->\(num - 1)")
        }
        prev = num
    }
    
    return result
}
