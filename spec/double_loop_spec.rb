# frozen_string_literal: true

RSpec.describe DoubleLoop do
  it "has a version number" do
    expect(DoubleLoop::VERSION).not_to be nil
  end

  describe ".api_token=" do
    it "sets the API token" do
      described_class.api_token = nil

      expect do
        described_class.api_token = "foobarbaz"
      end.to change(described_class, :api_token).from(nil).to("foobarbaz")
    end
  end

  describe ".endpoint=" do
    it "sets the endpoint" do
      described_class.endpoint = described_class::ENDPOINT

      expect do
        described_class.endpoint = "https://staging.doubleloop.app/api"
      end.to change(described_class, :endpoint).from(described_class::ENDPOINT).to("https://staging.doubleloop.app/api")
    end
  end
end
