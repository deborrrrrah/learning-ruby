class System
  @@instance = System.new

  def self.instance
    @@instance
  end

  def execute(command, args)
    exit
  end
end