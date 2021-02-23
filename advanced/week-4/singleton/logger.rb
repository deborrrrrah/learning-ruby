# Singleton design pattern exercise

class Logger
  def initialize
    filename = 'log.txt'
    @file = File.open(filename,'w')
  end

  @@instance = Logger.new     # this is the lazy instantiation

  def self.instance           # this is the public static accessor
    @@instance
  end

  def log(message)
    @file.puts message
  end

  private_class_method :new   # new method is made private
end