# DEMON_EP = 100
DEMON_EP = 200

class Fighter 
  attr_reader :name
  def initialize(name, health_point, type)
    @name = name
    @health_point = health_point
    @type = type
    puts @name + " has entered the game!"
  end
  
  def attack(demon)
    if !self.dead?
      case @type.downcase
      when "knight" 
        puts @name + " slash!"
        demon.attacked(20)
      when "mage"
        puts @name + " cast a spell!"
        demon.attacked(15)
      when "assassin"
        puts @name + " stab!"
        demon.attacked(10)
      end
    end
  end

  def attacked(damage_point)
    if !self.dead?
      @health_point -= damage_point
      puts @name + " took " + damage_point.to_s + " damages"
      if self.dead?
        puts @name + " is defeated"
      end
    end
  end

  def dead?
    return @health_point <= 0
  end
end
  
class Demon 
  attr_reader :name
  def initialize(name, health_point)
    @name = name
    @health_point = health_point
  end

  def attack(fighter)
    if !self.dead?
      puts @name + " attack " + fighter.name
      fighter.attacked(50)
    end
  end

  def attacked(damage_point)
    if !self.dead?
      @health_point -= damage_point
      puts @name + " took " + damage_point.to_s + " damages"
      if self.dead?
        puts @name + " is slayed!"
      end
    end
  end

  def dead?
    return @health_point <= 0
  end
end
  
class Game
  attr_reader :demon, :available_fighters
  def start
    puts "Picking game avatars"
    @jon = Fighter.new("Jon", 50, "Knight")
    @harry = Fighter.new("Harry", 60, "Mage")
    @ezo = Fighter.new("Ezo", 40, "Assassin")
    @demon = Demon.new("Demon", DEMON_EP)
    @round = 1
    @available_fighters = [@jon, @harry, @ezo]
    puts "Start game"
  end
  
  def play
    puts "=" * 20
    puts "Round " + @round.to_s 
    @jon.attack(@demon) if continue?
    @harry.attack(@demon) if continue?
    @ezo.attack(@demon) if continue?
    @demon.attack(@available_fighters[rand(0..(@available_fighters.length - 1))]) if continue?
    @round += 1
  end

  def continue?
    @available_fighters.each{ |fighter| @available_fighters.delete(fighter) if fighter.dead? }
    return !@demon.dead? && @available_fighters.length > 0
  end
end
  
game = Game.new
game.start

while game.continue?
  game.play
end

puts "=" * 20
if !game.demon.dead?
  puts "You lose!"
elsif !game.available_fighters.empty?
  puts "You win!"
else 
  puts "Nobody wins :("
end