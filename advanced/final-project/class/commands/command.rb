class Command
  def args_valid?(args)
    raise NotImplementedError
  end

  def execute(args)
    raise NotImplementedError
  end
end