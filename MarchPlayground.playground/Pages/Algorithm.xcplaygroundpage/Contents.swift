import UIKit

//1有一群孩子和一堆饼干，每个孩子有一个饥饿度，每个饼干都有一个大小。每个孩子只吃最多一个饼干，且只有饼干的大小等于孩子的饥饿度时，这个孩子才能吃饱。求解最多有多少孩子可以吃饱。
//输入两个数组，分别代表孩子的饥饿度和饼干的大小。输出最多有多少孩子可以吃饱的数量。

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

//2.一群孩子站成一排，每一个孩子有自己的评分。现在需要给这些孩子发糖果，规则是如果一 个孩子的评分比自己身旁的一个孩子要高，那么这个孩子就必须得到比身旁孩子更多的糖果;所有孩子至少要有一个糖果。求解最少需要多少个糖果。
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
