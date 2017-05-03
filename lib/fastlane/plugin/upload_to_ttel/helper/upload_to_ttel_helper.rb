module Fastlane
  module Helper
    class UploadToTtelHelper
      # class methods that you define here become available in your action
      # as `Helper::UploadToTtelHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the upload_to_ttel plugin helper!")
      end
    end
  end
end
