import Foundation

func bubbleSort(arr : inout [Int])
{
    var flag : Bool = true
    let n : Int = arr.count
    var i : Int = 0
    
    while flag
    {
        flag = false
        i += 1
        
        for j in 0..<(n-i)
        {
            if arr[j] > arr[j+1]
            {
                arr.swapAt(j, j+1)
                flag = true
            }
        }
    }
}

func insertionSort(arr : inout [Int])
{
    let n : Int = arr.count
    var j : Int = 0
    
    for i in 1..<n
    {
        j = i-1
        
        while j >= 0 && arr[i] < arr[j]
        {
            j -= 1
        }
        
        for k in stride(from: i, to: j+1, by: -1)
        {
            arr.swapAt(k, k-1)
        }
        
    }
}

func selectionSort(arr : inout [Int])
{
    let n : Int = arr.count
    var min : Int
    
    for i in 0..<n-1
    {
        min = i
        
        for j in i+1..<n
        {
            if arr[j] < arr[min]
            {
                min = j
            }
        }
        
        arr.swapAt(i, min)
    }
}

func merge(arr : inout [Int], ini : Int, mid : Int, fin : Int)
{
    var i : Int = ini
    var l : [Int] = []
    var r : [Int] = []
    
    for i in ini..<mid+1
    {
        l.append(arr[i])
    }
    
    for i in mid+1..<fin+1
    {
        r.append(arr[i])
    }
    
    while !l.isEmpty && !r.isEmpty
    {
        if l[0] < r[0]
        {
            arr[i] = l[0]
            l.remove(at: 0)
        }
        else
        {
            arr[i] = r[0]
            r.remove(at: 0)
        }
        
        i += 1
    }
    
    while !l.isEmpty
    {
        arr[i] = l[0]
        l.remove(at: 0)
        i += 1
    }
    
    while !r.isEmpty
    {
        arr[i] = r[0]
        r.remove(at: 0)
        i += 1
    }
}

func mergeSortRecursivo(arr : inout [Int], ini : Int, fin : Int)
{
    if ini >= fin
    {
        return
    }
    
    let mid : Int = ini + (fin - ini)/2
    mergeSortRecursivo(arr: &arr, ini: ini, fin: mid)
    mergeSortRecursivo(arr: &arr, ini: mid+1, fin: fin)
    merge(arr: &arr, ini: ini, mid: mid, fin: fin)
}

func mergeSort(arr : inout [Int])
{
    mergeSortRecursivo(arr: &arr, ini:0, fin:arr.count-1)
}

func particion(arr : inout [Int], ini : Int, fin : Int) -> Int
{
    var pivote : Int = arr[ini]
    
    var i : Int = ini - 1
    var j : Int = fin + 1
    
    while(true)
    {
        repeat { i += 1 } while arr[i] < pivote
        repeat { j -= 1 } while arr[j] > pivote
        if i >= j { return j }
        arr.swapAt(i, j)
    }
}

func quickSortRecursivo(arr : inout [Int], ini : Int, fin : Int)
{
    if ini >= fin
    {
        return
    }
    
    let p : Int = particion(arr: &arr, ini: ini, fin: fin)
    quickSortRecursivo(arr: &arr, ini: ini, fin: p)
    quickSortRecursivo(arr: &arr, ini: p+1, fin: fin)
}

func quickSort(arr : inout [Int])
{
    quickSortRecursivo(arr: &arr, ini:0, fin:arr.count-1)
}

var arr : [Int] = []

for _ in 0..<20
{
    arr.append(Int.random(in: 0..<1000))
}

print("Original =\t\t\t \(arr)")

var arrCopia : [Int]

arrCopia = arr
bubbleSort(arr: &arrCopia)
print("BubbleSorted =\t\t \(arrCopia)")

arrCopia = arr
insertionSort(arr: &arrCopia)
print("InsertionSorted =\t \(arrCopia)")

arrCopia = arr
selectionSort(arr: &arrCopia)
print("SelectionSorted =\t \(arrCopia)")

arrCopia = arr
mergeSort(arr: &arrCopia)
print("MergeSorted =\t\t \(arrCopia)")

arrCopia = arr
quickSort(arr: &arrCopia)
print("QuickSorted =\t\t \(arrCopia)")
