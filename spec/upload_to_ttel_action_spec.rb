describe Fastlane::Actions::UploadToTtelAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The upload_to_ttel plugin is working!")

      Fastlane::Actions::UploadToTtelAction.run(nil)
    end
  end
end
