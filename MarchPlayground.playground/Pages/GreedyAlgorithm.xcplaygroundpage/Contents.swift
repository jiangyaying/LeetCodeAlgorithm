import UIKit
//贪心算法

//455有一群孩子和一堆饼干，每个孩子有一个饥饿度，每个饼干都有一个大小。每个孩子只吃最多一个饼干，且只有饼干的大小等于孩子的饥饿度时，这个孩子才能吃饱。求解最多有多少孩子可以吃饱。
//输入两个数组，分别代表孩子的饥饿度和饼干的大小。输出最多有多少孩子可以吃饱的数量。
func text(_ child: [Int], _ cookies: [Int]) -> Int {
    guard child.count > 0, cookies.count > 0 else {
        return 0
    }
    
    let childSortList = child.sorted()
    let cookiesSortList = cookies.sorted()
    var count = 0
    for i in 0...childSortList.count {
        if i < cookiesSortList.count, childSortList[i] <= cookiesSortList[i] {
            count += 1
        }
    }
    return count
}


//print(text([1, 2], [1, 2, 3]))


func countChilds(_ children: [Int], _ cookies: [Int]) -> Int {
    var children = children
    var cookies = cookies
    //贪心算法，局部最优解，首先将孩子的饥饿度与饼干大小进行正向排序
    children.sort()
    cookies.sort()
    
    var childNum = 0
    var cookieNum = 0
    //先以饼干为准进行遍历
    while cookieNum < cookies.count {
        //当饼干的大小大于或等于孩子的饥饿度的时候，并且孩子数量没有超过数组大小，将孩子的数量相加
        if childNum < children.count, children[childNum] <= cookies[cookieNum] {
            childNum += 1
        }
        cookieNum += 1
    }
    return childNum
}

//print(countChilds([1, 2], [1, 2, 3]))

//135.一群孩子站成一排，每一个孩子有自己的评分。现在需要给这些孩子发糖果，规则是如果一 个孩子的评分比自己身旁的一个孩子要高，那么这个孩子就必须得到比身旁孩子更多的糖果;所有孩子至少要有一个糖果。求解最少需要多少个糖果。
//输入是一个数组，表示孩子的评分。输出是最少糖果的数量。 Input: [1,0,2] Output: 5

func candy(ratings: [Int]) -> Int {
    var ratings = ratings
    let size = ratings.count
    //所有的孩子至少有一个糖果，所以分析只有一个孩子的情况
    if size < 2 {
        return size
    }
    
    //创建初始每个孩子只有一个糖果的数组num
    var num = [Int](repeating: 1, count: size)
    //先将数组进行正向遍历，判断左边孩子小于右边孩子评分的情况将num对应的右边孩子糖果数量等于左边孩子数量加一
    for i in 0...size - 2 {
        if ratings[i] < ratings[i + 1] {
            num[i + 1] = num[i] + 1
        }
    }
    
    //然后进行反向遍历，判断左边孩子大于右边孩子的情况， 并且左边孩子的糖果数量小于或者等于右边孩子，然后将左边孩子数量等于右边孩子数量加1
    num = num.reversed()
    ratings = ratings.reversed()
    
    for i in  0...size - 2 {
        if ratings[i] < ratings[i + 1], num[i] >= num[i + 1] {
            num[i + 1] = num[i] + 1
        }
    }
    
    //将num数组累加，得到总的糖果数量
    let numSum = num.reduce(0, +)
    return numSum
}

//print(candy(ratings: [1, 0, 2, 3]))

//435.区间问题  给定多个区间，计算让这些区间互不重叠所需要移除区间的最少个数。起止相连不算重叠。
//输入是一个数组，数组由多个长度固定为2的数组组成，表示区间的开始和结尾。输出一个整数，表示需要移除的区间数量。
func nonOverLappingIntervals(intervals: [[Int]]?) -> Int {
    guard var intervals = intervals, intervals.count > 1 else {
        return 0
    }
    
    let n = intervals.count
    for i in 0..<intervals.count {
        intervals[i] = intervals[i].sorted()
    }
        
    intervals.sort { (a, b) -> Bool in
        return a[1] < b[1] 
    }

    print(intervals)
    var total = 0
    var pre = intervals[0]
    for i in 1...n - 1 {
        let a = intervals[i]
        if a.count == 2, pre[1] > a[0] {
            total += 1
        } else {
            pre = a
            print(pre)
        }
    }
    
    return total
}

//print(nonOverLappingIntervals(intervals: [[-100,-87],[-99,-44],[-98,-19],[-97,-33],[-96,-60],[-95,-17],[-94,-44],[-93,-9],[-92,-63],[-91,-76],[-90,-44],[-89,-18],[-88,10],[-87,-39],[-86,7],[-85,-76],[-84,-51],[-83,-48],[-82,-36],[-81,-63],[-80,-71],[-79,-4],[-78,-63],[-77,-14],[-76,-10],[-75,-36],[-74,31],[-73,11],[-72,-50],[-71,-30],[-70,33],[-69,-37],[-68,-50],[-67,6],[-66,-50],[-65,-26],[-64,21],[-63,-8],[-62,23],[-61,-34],[-60,13],[-59,19],[-58,41],[-57,-15],[-56,35],[-55,-4],[-54,-20],[-53,44],[-52,48],[-51,12],[-50,-43],[-49,10],[-48,-34],[-47,3],[-46,28],[-45,51],[-44,-14],[-43,59],[-42,-6],[-41,-32],[-40,-12],[-39,33],[-38,17],[-37,-7],[-36,-29],[-35,24],[-34,49],[-33,-19],[-32,2],[-31,8],[-30,74],[-29,58],[-28,13],[-27,-8],[-26,45],[-25,-5],[-24,45],[-23,19],[-22,9],[-21,54],[-20,1],[-19,81],[-18,17],[-17,-10],[-16,7],[-15,86],[-14,-3],[-13,-3],[-12,45],[-11,93],[-10,84],[-9,20],[-8,3],[-7,81],[-6,52],[-5,67],[-4,18],[-3,40],[-2,42],[-1,49],[0,7],[1,104],[2,79],[3,37],[4,47],[5,69],[6,89],[7,110],[8,108],[9,19],[10,25],[11,48],[12,63],[13,94],[14,55],[15,119],[16,64],[17,122],[18,92],[19,37],[20,86],[21,84],[22,122],[23,37],[24,125],[25,99],[26,45],[27,63],[28,40],[29,97],[30,78],[31,102],[32,120],[33,91],[34,107],[35,62],[36,137],[37,55],[38,115],[39,46],[40,136],[41,78],[42,86],[43,106],[44,66],[45,141],[46,92],[47,132],[48,89],[49,61],[50,128],[51,155],[52,153],[53,78],[54,114],[55,84],[56,151],[57,123],[58,69],[59,91],[60,89],[61,73],[62,81],[63,139],[64,108],[65,165],[66,92],[67,117],[68,140],[69,109],[70,102],[71,171],[72,141],[73,117],[74,124],[75,171],[76,132],[77,142],[78,107],[79,132],[80,171],[81,104],[82,160],[83,128],[84,137],[85,176],[86,188],[87,178],[88,117],[89,115],[90,140],[91,165],[92,133],[93,114],[94,125],[95,135],[96,144],[97,114],[98,183],[99,157]]))

//605. Can Place Flowers (Easy)
//采取什么样的贪心策略，可以种植最多的花朵呢?
func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
    var flowerbed = flowerbed
    if flowerbed.isEmpty {
        return false
    }
    
    if flowerbed[0] == 0 {
        flowerbed.insert(0, at: 0)
    }
    if flowerbed[flowerbed.count - 1] == 0 {
        flowerbed.append(0)
    }
    
    print(flowerbed)
    
    var sum = 0
    var cnt = 0
    for i in 0...flowerbed.count {
        if i < flowerbed.count, flowerbed[i] == 0 {
            cnt += 1
        } else {
            sum += (cnt - 1) / 2
            cnt = 0
        }
    }
    
    print(sum)
    
    return sum >= n
}

//print(canPlaceFlowers([1, 0, 0, 0, 1, 0, 0], 2))

//452
func findMinArrowShots(_ points: [[Int]]) -> Int {
    guard points.count > 0 else {
        return 0
    }
    
    var points = points
    
    points.sort { a, b -> Bool in
        return b[0] >= a[0]
    }
    
    var num = 1
    var pre = points[0]
    
    for i in 1..<points.count {
        if points[i][0] <= pre[1] {
            pre[0] = points[i][0]
            pre[1] = min(pre[1], points[i][1])
        } else {
            num += 1
            pre = points[i]
        }
    }
    
    return num
}

//print(findMinArrowShots([[1,2],[2,3],[3,4],[4,5]]))

//763
func partitionLabels(_ S: String) -> [Int] {
    guard S.count > 0 else {
        return []
    }
    
    var res = [Int]()
    let chars = Array(S)
    var map = [Character: Int]()
    
    var start = 0
    var end = 0
    for i in 0..<chars.count {
        map[chars[i]] = i
    }
    
    print(map)
    
    for i in 0..<chars.count {
        if let loc = map[chars[i]] {
            end = max(end, loc)
        }
        
        if i == end {
            res.append(end - start + 1)
            start = end + 1
        }
    }
    return res
}

//print(partitionLabels("ababcbacadefegdehijhklij"))
//122
func maxProfit(_ prices: [Int]) -> Int {
    guard  prices.count >= 1, prices.count <= 3 * 10000 else {
        return 0
    }
    
    var result = 0
    for i in 1..<prices.count {
        let learn = prices[i] - prices[i - 1]
        if learn > 0 {
            result += learn
        }
    }
    return result
}
//406
func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
    guard people.count > 0 else {
        return [[]]
    }
    
    var queue = [[Int]]()
    
    let people = people.sorted { h1, h2 -> Bool in
        if h1[0] == h2[0] {
            return h1[1] < h2[1]
        }
        
        return h1[0] >= h2 [0]
    }
    
    print(people)
    
    for i in 0..<people.count {
        let index = people[i][1]
        queue.insert(people[i], at: index)
        print(queue)
    }
    
    return queue
}

//print(reconstructQueue([[6,0],[5,0],[4,0],[3,2],[2,2],[1,4]]))
//665
func checkPossibility(_ nums: [Int]) -> Bool {
    guard nums.count > 1 else {
        return false
    }
    
    var deleteItem = 0
    var nums = nums
    for i in 0..<nums.count - 1 {
        if nums[i] > nums[i + 1] {
            if i == 0 {
                nums[i] = nums[i + 1]
            } else {
                // a b c , a>c c=b, a<c
                if nums[i - 1] > nums[i + 1] {
                    nums[i + 1] = nums[i]
                } else {
                    nums[i] = nums[i + 1]
                }
            }
            deleteItem += 1
        }
        print(nums[i])
    }
    
    return deleteItem <= 1
}

//print(checkPossibility([2,4,3,5,3]))
