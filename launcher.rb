require './tools'

module FastRockets
  class Launcher
    WIDTH = 32

    def recent_launches
      @recent ||= []
    end

    def fire!(tool_name)
      if recent_launches.count >= WIDTH / 2.0
        tow_away_a_rockt_and_file_a_traffic_ticket # make space for more rockets
      end

      color = Tools.color_for_tool(tool_name)
      puts "Launching rocket '#{tool_name}' with color #{color}  3....2....1....."

      x = -1
      loop do
        x = Random.rand(WIDTH)
        break unless recent_launches.include?x
      end

      recent_launches << x

      color << x
      return color
    end

    def tow_away_a_rockt_and_file_a_traffic_ticket
      recent_launches.shift
    end
  end
end