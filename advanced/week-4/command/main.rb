require_relative 'printer'

command = ARGV[0]
args = ARGV[1]
printer = Printer.new
printer.execute(command, args)