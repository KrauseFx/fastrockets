module FastRockets
  class Tools
    def self.color_for_tool(tool_name)
      tool_colors[tool_name.to_sym]
    end

    private
      def self.tool_colors
        {
          fastlane: [255, 255, 255],
          deliver: [232, 63, 26],
          snapshot: [27, 127, 251],
          frameit: [136, 194, 88],
          pem: [143, 61, 229],
          sigh: [31, 188, 210],
          produce: [252, 214, 72],
          cert: [96, 125, 140],
          codes: [121, 85, 72],
          pilot: [76, 163, 235]
        }
      end
  end
end