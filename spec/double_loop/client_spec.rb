# frozen_string_literal: true

RSpec.describe DoubleLoop::Client do
  let(:post_url) { "#{DoubleLoop.endpoint}/tacos/v1" }

  before do
    DoubleLoop.api_token = "foobarbaz"
    DoubleLoop.endpoint = "https://endpoint-override.net/api"
  end

  describe "#post" do
    it "makes a POST request to the specified resource, parsing the JSON body into an Object" do
      params = {
        name: "param",
        api_token: DoubleLoop.api_token
      }
      stub = stub_request(:post, post_url)
             .with(
               headers: {
                 "Content-Type": "application/json"
               },
               body: params.to_json
             )
             .to_return(body: params.to_json)

      data = described_class.post("/tacos/v1", params)

      expect(stub).to have_been_made
      expect(data["name"]).to eq "param"
    end

    context "when the API returns an error with a body" do
      it "raises an Error" do
        stub_request(:post, post_url)
          .to_return(status: 422, body: { message: "Some error" }.to_json)

        expect do
          described_class.post("/tacos/v1", {})
        end.to raise_error(DoubleLoop::Error, { message: "Some error" }.to_json)
      end
    end

    context "when the API returns an error without a body" do
      it "raises an Error" do
        stub_request(:post, post_url)
          .to_return(status: 500)

        expect do
          described_class.post("/tacos/v1", {})
        end.to raise_error(DoubleLoop::Error)
      end
    end

    context "when the API is unavailable" do
      it "raises a ConnectionError" do
        stub_request(:post, post_url)
          .to_raise(Errno::ECONNRESET)

        expect do
          described_class.post("/tacos/v1", {})
        end.to raise_error(DoubleLoop::ConnectionError)
      end
    end
  end
end
