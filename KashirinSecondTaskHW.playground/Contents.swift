//: Playground - noun: a place where people can play

import UIKit

// 1 task method trim()
func trim(_ word: String, with: String) -> String{
    var string = String()
    var cur = 0
    var add = String()
    if with.isEmpty{
        return word
    }
    let size = with.characters.count;
    for char in word.characters{
        let index = with.index(with.startIndex, offsetBy: cur)
        if char == with[index]{
            add.append(char)
            if cur == size - 1{
                cur = -1
                add = ""
            }
            cur += 1
           
        }
        else{
            string += add;
            string.append(char);
            add = ""
            cur = 0
        }
    
        
    }
    return string
}

print(trim("irSirtirinig", with: "ir"))

// 2 Task
class Unit{
    var health: Int = 0
    var damage: Int = 0
    var defence: Int = 0
    var agility: Int = 0
    var name: String = ""
    let attackConstant = 100
    init(){
        health = 0
        damage = 0
        defence = 0
        agility = 0
        name = ""
    }

    
    func attack(to:Unit){
        to.health -= self.damage * self.agility * (attackConstant - to.defence) / (attackConstant * attackConstant)
    }
    func isAlive() -> Bool{
        if health > 0 {
            return true
        }
        return false
    }
    
}
class Mag: Unit{
    let capacityOfHeal = 40
    var amountOfHealed = 0
    var amounfOfHeal = 3
    init(health: Int, damage: Int, def: Int,
         agility:Int, name: String){
        super.init()
        self.health = health
        self.damage = damage
        self.defence = def
        self.agility = agility
        self.name = name

        }
    convenience init(name:String){
      self.init(health: 100, damage: 30, def: 50, agility: 25, name: name)
    }
    func heal(){
        
        if(amountOfHealed < capacityOfHeal){
            self.health += amounfOfHeal
        }
        amountOfHealed += amounfOfHeal
    }
    override func attack(to: Unit) {
        
        heal()
        super.attack(to: to)
    }

}
class Assasin: Unit{
    init(health: Int, damage: Int, def: Int,
         agility:Int, name: String){
        super.init()
        self.health = health
        self.damage = damage
        self.defence = def
        self.agility = agility
        self.name = name
    }
    convenience init(name:String){
        self.init(health: 85, damage: 50, def: 30, agility: 95, name: name)
    }

}
class Knight: Unit{
    init(health: Int, damage: Int, def: Int,
         agility:Int, name: String){
        super.init()
        self.health = health
        self.damage = damage
        self.defence = def
        self.agility = agility
        self.name = name
    }
    convenience init(name:String){
        self.init(health: 110, damage: 75, def: 60, agility: 10, name: name)
    }

}
// Class Pair собственный для хранения пар значений
// в Java нет такого, в С++ есть
struct Pair{
    var x,y : Int
    init(x:Int,y:Int){
        self.x = x;
        self.y = y;
    }
    public var description: String { let s = String(x)
        let s1 = String(y)
        let s2 = s + " - " + s1
        return s2 }
}
class Field{
    var results = [String: Pair]()
    let amountOfPlayersToShow = 3
    init(){
    }
    func beginBattle(with units: Array<Unit>){
        
        var numbersOfAlivePlayers = Array<Int>()
        for i in 0 ..< units.count{
            let key = units[i].name
            if results[key] == nil{
                results[key] = Pair(x: 0,y: 0)
            }
            numbersOfAlivePlayers.append(i)
        }
        var currentPlayer : Int = 0
        // все возможные удары
        while(numbersOfAlivePlayers.count > 1){
            print(units[currentPlayer].name + ", your move")
            for i in numbersOfAlivePlayers{
                if i != currentPlayer{
                    print(String(i) + " - " + units[i].name)
                }
                
            }
            var randomNum: Int = -1
            repeat{
                let rand: Int = Int(arc4random_uniform(UInt32(numbersOfAlivePlayers.count)))
                randomNum = rand
            }while numbersOfAlivePlayers[randomNum] == currentPlayer
            print("Chose " + String(numbersOfAlivePlayers[randomNum]))
            
            units[currentPlayer].attack(to: units[numbersOfAlivePlayers[randomNum]])
            print(units[numbersOfAlivePlayers[randomNum]].name + " health " + String(units[numbersOfAlivePlayers[randomNum]].health))
            if !units[numbersOfAlivePlayers[randomNum]].isAlive(){
                numbersOfAlivePlayers.remove(at: randomNum)
            }
            
            let prevPlayer = currentPlayer
            for i in numbersOfAlivePlayers{
                if i > currentPlayer{
                    currentPlayer = i
                    break
                }
            }
            if prevPlayer == currentPlayer{
                currentPlayer = numbersOfAlivePlayers[0]
            }
            
            
        }
        
        print(units[numbersOfAlivePlayers[0]].name + " won")
        results[units[numbersOfAlivePlayers[0]].name]?.x += 1;
        results[units[numbersOfAlivePlayers[0]].name]?.y -= 1;
        print("Top results")
        let itemResult = results.sorted { (first: (key: String, value: Pair), second: (key: String, value: Pair)) -> Bool in
            return first.value.x - first.value.y >
                second.value.x - second.value.y
        }
        var countOfPlayers = 0
        for i in itemResult{
            if countOfPlayers >= amountOfPlayersToShow{
                break
            }
            print(i.key + " " + i.value.description)
            countOfPlayers += 1
        }
        
        for i in units{
            
            let key = i.name
            if let xValue = results[key]?.x,
                let yValue = results[key]?.y {
                
                results[key] = Pair(x: xValue, y:yValue + 1)
             }
            
            
        }
        
        
    }
}

let field = Field()
for i in 0...7 {
    var players: Array<Unit> = [ Mag(name : "Mag"), Assasin(name: "Assasin1"), Assasin(name: "Assasin2"), Knight(name: "Kni1"), Knight(name: "Kni2")]
    field.beginBattle(with: players)
    
}


