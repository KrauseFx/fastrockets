require './tools'

module FastRockets
  class Launcher
    WIDTH = 32

    def recent_launches
      @recent ||= []
    end

    def fire!(tool_name)
      if recent_launches.count >= WIDTH * 0.75
        tow_away_a_rockt_and_file_a_traffic_ticket # make space for more rockets
      end

      color = Tools.color_for_tool(tool_name)
      puts "Launching rocket '#{tool_name}' with color #{color}  3....2....1....."

      x = -1
      loop do
        x = Random.rand(WIDTH) || -1
        if recent_launches.include?x
          # repeat
        else
          if x > -1
            break
          end
        end
      end

      recent_launches << x

      color << x # the X position of the rocket
      color << Random.rand # that's the speed

      return color
    end

    def tow_away_a_rockt_and_file_a_traffic_ticket
      recent_launches.shift
    end
  end
end