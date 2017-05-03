require 'faraday'
require 'faraday_middleware'

module Fastlane
    module Actions
        module SharedValues
            UPLOAD_TO_TTELL_CUSTOM_VALUE = :UPLOAD_TO_TTELL_CUSTOM_VALUE
        end
        
        class UploadToTtelAction < Action
            def self.run(params)
            # fastlane will take care of reading in the parameter and fetching the environment variable:
            UI.message("The upload_to_ttell action is working.")
            
            # host, envType, prodType, changeLog
            api_host = params[:host]
            if api_host.nil?
            UI.user_error!("You have to provide a host url")
        end
        
        envType = params[:envType]
        if envType.nil?
        
        UI.user_error!("You have to provide the envType")
    end
    
    prodType = params[:prodType]
    if prodType.nil?
    UI.user_error!("You have to provide the prodType")
end

changeLog = params[:changeLog]
if changeLog.nil?
    changeLog = ''
end
UI.message("host: #{api_host}")
UI.message("envType: #{envType}")
UI.message("prodType: #{prodType}")
UI.message("changeLog: #{changeLog}")
build_file = ENV["IPA_OUTPUT_PATH"]

UI.message("build_file: #{build_file}")
# start upload
conn_options = {
    request: {
        timeout:       1000,
        open_timeout:  300
    }
}

ttel_client = Faraday.new(nil, conn_options) do |c|
    c.request :multipart
    c.request :url_encoded
    c.response :json, content_type: /\bjson$/
    c.adapter :httpclient
    c.ssl.verify = false
end

params = {
    'envType' => "#{envType}",
    'prodType' => "#{prodType}",
    'changeLog' => "#{changeLog}",
    
    'package' => Faraday::UploadIO.new(build_file, 'application/octet-stream')
}

# UI.message "Start upload #{build_file} to pgyer..."

response = ttel_client.post api_host, params

info = response.body


if info["code"] == 1
    UI.success "Upload success. "
    else
    UI.user_error!("Upload failed. error info : #{info}")
    
end


# sh "shellcommand ./path"

# Actions.lane_context[SharedValues::UPLOAD_TO_TTELL_CUSTOM_VALUE] = "my_val"
end

#####################################################
# @!group Documentation
#####################################################

def self.description
"A short description with <= 80 characters of what this action does"
end

def self.details
# Optional:
# this is your chance to provide a more detailed description of this action
"You can use this action to do cool things..."
end

def self.available_options
# Define all options your action supports.

# Below a few examples
[
FastlaneCore::ConfigItem.new(key: :host,
                             env_name: "host",
                             description: "host",
                             is_string: true, # true: verifies the input is a string, false: every kind of value
                             default_value: ''), # the default value if the user didn't provide one

FastlaneCore::ConfigItem.new(key: :envType,
                             env_name: "envType",
                             description: "envType",
                             is_string: true, # true: verifies the input is a string, false: every kind of value
                             default_value: ''), # the default value if the user didn't provide one

#  host, envType, prodType, changeLog
FastlaneCore::ConfigItem.new(key: :prodType,
                             env_name: "prodType",
                             description: "prodType",
                             is_string: true, # true: verifies the input is a string, false: every kind of value
                             default_value: ''), # the default value if the user didn't provide one

FastlaneCore::ConfigItem.new(key: :changeLog,
                             env_name: "changeLog",
                             description: "changeLog",
                             is_string: true, # true: verifies the input is a string, false: every kind of value
                             default_value: '') # the default value if the user didn't provide one

]
end

def self.output
# Define the shared values you are going to provide
# Example
[
['UPLOAD_TO_TTELL_CUSTOM_VALUE', 'A description of what this value contains']
]
end

def self.return_value
# If you method provides a return value, you can describe here what it does
end

def self.authors
# So no one will ever forget your contribution to fastlane :) You are awesome btw!
["Your GitHub/Twitter Name"]
end

def self.is_supported?(platform)
# you can do things like
#
#  true
#
#  platform == :ios
#
#  [:ios, :mac].include?(platform)
#

platform == :ios
end
end
end
end
