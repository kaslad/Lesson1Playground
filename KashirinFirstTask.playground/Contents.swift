//: Playground - noun: a place where people can play

import UIKit

//ClassWork
var str = "Hello, playground"
// Bubble Sort
    func bubbleSort(_ array: [Int]) -> [Int] {
        var arr = array
        let size: Int = arr.count
        for _ in 1 ..< size{
            for j in 0 ..< size - 1{
                if arr[j] > arr[j + 1]{
                    swap( &arr[j], &arr[j+1])
                }
            }
        }
        print(arr)
        return arr
    }


var arr = [2,3,5,7,10,-1]
bubbleSort(arr)
// OOП
// Наследование
class Vehicle {
    var curSpeed = 0.0
    var description: String {
        return "движется на скорости \(curSpeed) миль в час"
    }
    func go(){
    }
    //Полиморфизм
    func makeNoise() {
    }
}
class Bicycle: Vehicle {
    var hasBasket = false
    //Полиморфизм
    override func makeNoise() {
        print("Звук велосипеда")
    }
}
class MotorByke: Vehicle{
    //Полиморфизм
    override func makeNoise() {
        print("РРРРРРРРРРРР")
    }
    override func go(){
        //инкапсулированный метод
        startEngine()
        //and more
    }
    // инкапсуляция
    private func startEngine(){
     /////
    }
}
//Полиморфизм
MotorByke().makeNoise();
Bicycle().makeNoise();

//MyStack
struct MyStack<Element> {
    fileprivate var array: [Element] = []
    
    mutating func push(_ element: Element) {
        array.append(element)
    }
    
    mutating func pop() -> Element? {
        return array.popLast()
    }
    
    func peek() -> Element? {
        return array.last
    }
}
var stack = MyStack<Int>()
stack.push(5)
print(stack.pop()!)
