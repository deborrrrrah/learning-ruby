class Weapon
  def used_by(hero)
    puts hero.name + " use the weapon"
  end
end

class Sword < Weapon
end

class Wand < Weapon
  def used_by(hero)
    puts hero.name + " swing the wand"
  end
end

class Dagger < Weapon
  def used_by(hero)
    puts hero.name + " throw the dagger"
  end
end

class Character 
  attr_reader :name
  def initialize(name, health_point)
    @name = name
    @health_point = health_point
    puts @name + " has entered the game!"
  end

  def attacked(damage_point)
    if !self.dead?
    @health_point -= damage_point
    puts @name + " took " + damage_point.to_s + " damages"
    puts @name + " is defeated" if self.dead?
    end
  end

  def attack(character)
    if !self.dead?
      puts @name + " attack " + character.name
      character.attacked(50)
    end
  end

  def dead?
    return @health_point <= 0
  end
end

class Knight < Character
  def initialize(name, health_point)
    super(name, health_point)
    @weapon = Sword.new
  end

  def attack(demon)
    @weapon.used_by(self)
    puts @name + " slash!"
    demon.attacked(20)
  end
end

class Mage < Character
  def initialize(name, health_point)
    super(name, health_point)
    @weapon = Wand.new
  end

  def attack(demon)
    @weapon.used_by(self)
    puts @name + " cast a spell!"
    demon.attacked(15)
  end
end

class Assassin < Character
  def initialize(name, health_point)
    super(name, health_point)
    @weapon = Dagger.new
  end

  def attack(demon)
    @weapon.used_by(self)
    puts @name + " stab!"
    demon.attacked(10)
  end
end

class Game
  attr_reader :demon, :available_fighters
  def start
    puts "Picking game avatars"
    @available_fighters = [Knight.new("Jon", 50), Mage.new("Harry", 60), Assassin.new("Ezo", 40)]
    @demon = Character.new("Demon", DEMON_HP)
    @round = 1
    puts "Start game"
  end

  def play
    puts "=" * 20
    puts "Round " + @round.to_s 
    @available_fighters.each do |fighter|
      fighter.attack(@demon) if continue?
    end
    @demon.attack(@available_fighters.sample) if continue?
    @round += 1
  end

  def continue?
    @available_fighters.each{ |fighter| @available_fighters.delete(fighter) if fighter.dead? }
    return !@demon.dead? && @available_fighters.length > 0
  end
end

DEMON_HP = 100
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