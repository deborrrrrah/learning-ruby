require_relative 'print_command'

class PrintMultiplePagesCommand < PrintCommand
  def print(args)
    pages = args.split(',')
    for page in pages
      puts "printing page #{ page }"
    end
  end
end
