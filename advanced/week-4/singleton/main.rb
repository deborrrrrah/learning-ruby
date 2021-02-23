require_relative 'logger'

while true
  message = gets.chomp
  Logger.instance.log(message)
end