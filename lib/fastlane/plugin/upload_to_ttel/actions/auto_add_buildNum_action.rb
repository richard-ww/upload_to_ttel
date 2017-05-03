module Fastlane
  module Actions
    class AutoAddBuildNumAction < Action
      def self.run(params)
        UI.message("The AutoAddBuildNumAction plugin is working!")
        
        updateProjectBuildNumber
      end
    
    def updateProjectBuildNumber
        #        fastlane build 号 处理代码
        # => https://developer.apple.com/library/content/qa/qa1827/_index.html
        # => currentTime    当前时间 20170401       string
        # => build          build 号               string
        # => lastStr        小数点后2位             string
        # => lastNum        小数点后2位（用于计算）   int
        
        currentTime = Time.new.strftime("%Y%m%d")
        
        build       = get_build_number()
        
        if build.include?"#{currentTime}."
            
            # => 为当天版本 计算迭代版本号
            
            lastStr      = build[build.length-2..build.length-1]
            
            lastNum      = lastStr.to_i
            
            lastNum      = lastNum + 1
            
            lastStr = lastNum.to_s
            
            if lastNum < 10
                
                lastStr = lastStr.insert(0,"0")
            end
            
            build = "#{currentTime}.#{lastStr}"
            
            else
            # => 非当天版本 build 号重置
            
            build = "#{currentTime}.01"
        end

      def self.description
        "hhhh"
      end

      def self.authors
        ["WeiWei"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "hhhh"
      end


      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "TEST_SUNFIT_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
