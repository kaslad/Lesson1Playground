//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

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
    var def: Int = 0
    var agility: Int = 0
    var name: String = ""
    /* init(){
        health = 0
        damage = 0
        def = 0
        agility = 0
        name = ""
    }
 */
    
    func attack(to:Unit){
        to.health -= self.damage * self.agility * (100 - to.def) / 10000
    }
    func isAlive() -> Bool{
        if health > 0 {
            return true
        }
        return false
    }
    
}
class Mag: Unit{
    let CAPACITY_HEAL = 40
    var am_heal = 0
    init(health: Int, damage: Int, def: Int,
         agility:Int, name: String){
        super.init()
        self.health = health
        self.damage = damage
        self.def = def
        self.agility = agility
        self.name = name

        }
    convenience init(name:String){
      self.init(health: 100, damage: 30, def: 50, agility: 25, name: name)
    }
    func heal(){
        
        if(am_heal < CAPACITY_HEAL){
            self.health += 3
        }
        am_heal += 3
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
        self.def = def
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
        self.def = def
        self.agility = agility
        self.name = name
    }
    convenience init(name:String){
        self.init(health: 110, damage: 75, def: 60, agility: 10, name: name)
    }

}
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
    var results = [String: Pair ]()
    init(){
    }
    func beginBattle(with: Array<Unit>){
        
        var set = Array<Int>()
        for i in 0 ..< with.count{
            let key = with[i].name
            if results[key] == nil{
                results[key] = Pair(x: 0,y: 0)
            }
            set.append(i)
        }
        var curPlayer : Int = 0
        // все возможные удары
        while(set.count > 1){
            print(with[curPlayer].name + ", your move")
            for i in set{
                if i != curPlayer{
                    print(String(i) + " - " + with[i].name)
                }
                
            }
            var randomNum: Int = -1
            repeat{
                let rand: Int = Int(arc4random_uniform(UInt32(set.count)))
                randomNum = rand
            }while set[randomNum] == curPlayer
            print("Chose " + String(set[randomNum]))
            
            with[curPlayer].attack(to: with[set[randomNum]])
            print(with[set[randomNum]].name + " health " + String(with[set[randomNum]].health))
            if !with[set[randomNum]].isAlive(){
                set.remove(at: randomNum)
            }
            
            let prevPlayer = curPlayer
            for i in set{
                if i > curPlayer{
                    curPlayer = i
                    break
                }
            }
            if prevPlayer == curPlayer{
                curPlayer = set[0]
            }
            
            
        }
        
        print(with[set[0]].name + " won")
        results[with[set[0]].name]?.x += 1;
        results[with[set[0]].name]?.y -= 1;
        print("Top results")
        let itemResult = results.sorted { (first: (key: String, value: Pair), second: (key: String, value: Pair)) -> Bool in
            return first.value.x - first.value.y >
                second.value.x - second.value.y
        }
        var cou = 0
        for i in itemResult{
            if cou >= 3{
                break
            }
            print(i.key + " " + i.value.description)
            cou += 1
        }
        
        for i in with{
            
            let key = i.name
            results[key] = Pair(x : (results[key]?.x)! ,y: (results[key]?.y)! + 1)
            
        }
        
        
    }
}

let field = Field()
for i in 0...7 {
    var players: Array<Unit> = [ Mag(name : "Mag"), Assasin(name: "Assasin1"), Assasin(name: "Assasin2"), Knight(name: "Kni1"), Knight(name: "Kni2")]
    field.beginBattle(with: players)
    
}


