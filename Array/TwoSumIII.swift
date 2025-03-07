/**
    The "Two Sum III - Data Structure Design" problem on LeetCode requires designing a data structure that supports two operations:
    
    add(number): Add the number to an internal data structure.
    find(value): Determine if there exists any pair of numbers whose sum equals the specified value.
    Example:
    
    twoSum = TwoSum()
    twoSum.add(1)    # [1]
    twoSum.add(3)    # [1, 3]
    twoSum.add(5)    # [1, 3, 5]
    twoSum.find(4)   # Returns True (1 + 3 = 4)
    twoSum.find(7)   # Returns False (No two numbers sum up to 7)
    Constraints:
    
    -10^5 <= number <= 10^5
    -2^31 <= value <= 2^31 - 1
    At most 5 * 10^4 calls will be made to add and find.
    For more details, you can refer to the problem statement on LeetCode: 

*/


/**
 * Question Link: https://leetcode.com/problems/two-sum-iii-data-structure-design/
 * 
 * Note: This answer offers a different solution instead of the one requsted by leetcode.
 *       Assuming the use case is find API is called many more times than add API.
 *       For the answer accepted by leetcode, you could reference Two Sum and Two Sum II.
 *
 * Primary idea: Use a set for all two sums value, and array to keep all numbers added.
 * Time Complexity: add - O(n), find - O(1), Space Complexity: O(n)
 */

class TwoSumIII {

    var nums: [Int]
    var twoSums: Set<Int>()
    
    /** Initialize your data structure here. */
    init() {
        nums = [Int]()
        twoSums = Set<Int>()
    }
    
    /** Add the number to an internal data structure.. */
    func add(_ number: Int) {
        nums.forEach { twoSums.insert($0 + number) }
        nums.append(number)
    }
    
    /** Find if there exists any pair of numbers which sum is equal to the value. */
    func find(_ value: Int) -> Bool {
        return twoSums.contains(value)
    }
}
// ======================================
//         HOME MADE SOLUTION
// ======================================
struct DataStruct {
    private var values: [Int] = []
    mutating func add(_ num: Int) {
        if values.isEmpty {
            values.append(num)
            return
        }
        print("before: \(values)")
        
        /*
        // Insertion keeping the non-decreasing order
        var insertIndex = 0
        while insertIndex < values.count &&
             values[insertIndex] < num {
            insertIndex += 1
        }
        if insertIndex == 0 {
            // incoming number is < 0th element
            values.insert(num, at: 0)
        } else if insertIndex >= values.count {
            values.append(num)
        } else {
            values.insert(num, at: insertIndex)
        }
        */
        
        // Insertion using bin-search
        let (found, index) = search(num)
        
        if found {
            values.insert(num, at: index)
        } else {
            if index == values.count {
                values.append(num)
            } else if index == 0 {
                values.insert(num, at: 0)
            } else {
                var insertIndex = index
                while values[insertIndex] < num && 
                     insertIndex < values.count {
                    insertIndex += 1
                }
                if insertIndex == values.count {
                    values.append(num)
                } else {
                    values.insert(num, at: insertIndex)
                }
            }
        }
        
        print("after insert : \(values)")
    }
    func find(_ num: Int) -> Bool {
        // find two elements in values where item1 + item2 == num
        // if found return true
        // else false
        for (i, item) in values.enumerated() {
            let target = num - item
            let (found, index) = search(target)
            if found && index != i {
            print("Found match: \(item) + \(target) = \(num)")
                return true
            }
        }
        
        return false
    }
    
    private func search(_ num: Int) -> (Bool, Int) {
        var l = 0, r = values.count - 1
        while l <= r {
            let mid = (l + r) / 2
            //print(values[mid], mid, num)
            if values[mid] == num {
                return (true, mid)
            } else if num < values[mid] {
                r = mid - 1
            } else {
                l = mid + 1
            }
        }
        return (false, l)
    }
}

var ds = DataStruct()
ds.add(1)
ds.add(0)
ds.add(8)
ds.add(1)
ds.add(5)
ds.add(10)
ds.add(4)
ds.add(7)
ds.add(-7)

print(ds.find(18))

