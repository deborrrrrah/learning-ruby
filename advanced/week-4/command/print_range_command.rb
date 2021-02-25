require_relative 'print_command'

class PrintRangeCommand < PrintCommand
  def print(args)
    page_range = args.split('-')
    min_range = page_range[0].to_i
    max_range = page_range[1].to_i
    min_range.upto(max_range) do |page|
      puts "printing page #{ page }"
    end
  end
end
