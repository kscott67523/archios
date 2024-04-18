RSpec.describe EmailProcessor do
  subject(:processor) { described_class.new(email) }

  let(:email) do
    instance_double("Griddler::Email",
                    body: "Test body content",
                    from: { email: "sender@example.com" })
  end

  describe "#process" do
    before do
      allow(Employee).to receive(:exists?).and_return(employee_exists)
    end

    context "when the employee is verified" do
      let(:employee_exists) { true }

      context "and the request is successfully created" do
        before do
          allow(Request).to receive(:create!).and_return(true)
        end

        it "logs the success" do
          expect(Rails.logger).to receive(:info).with("Request processed successfully.")
          processor.process
        end
      end

      context "when the request creation fails" do
        before do
          allow(Request).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
        end

        it "handles the failure" do
          expect(processor).to receive(:handle_processing_failure).with("We're sorry, but we were unable to process your request. Please try again.")
          processor.process
        end
      end
    end

    context "when the employee is not verified" do
      let(:employee_exists) { false }

      it "handles unauthorized attempts" do
        expect(processor).to receive(:handle_processing_failure).with("Unauthorized request attempt detected.")
        processor.process
      end
    end
  end

  describe "#sender_email" do
    it "returns the sender email" do
      expect(processor.sender_email).to eq("sender@example.com")
    end
  end

  describe "#body" do
    it "returns the email body" do
      expect(processor.body).to eq("Test body content")
    end
  end
end
