# frozen_string_literal: true

RSpec.describe DoubleLoop::Metric do
  describe "#create" do
    let(:response) do
      <<~JSON
        {
          "ok": true,
          "metric": {
            "id": 266,
            "organization_id": 2058,
            "name": "mpd test metric",
            "created_at": "2022-01-16T04:27:17Z",
            "updated_at": "2022-01-16T04:27:17Z",
            "metric_type": "counts",
            "strategy_id": null,
            "external_url": null,
            "strategy_type": null,
            "source_name": null,
            "description": null,
            "json_attributes": {
              "strategy_stats_7d": {
                "total": 69.0,
                "change": null
              },
              "strategy_stats_6w": {
                "total": 69.0,
                "change": null
              },
              "strategy_stats_12m": {
                "total": 69.0,
                "change": null
              }
            },
            "technical_description": null
          },
          "metric_data_point": {
            "id": 1192,
            "date": "2022-01-15",
            "value": 69.0,
            "metric_id": 266,
            "created_at": "2022-01-16T04:27:17Z",
            "updated_at": "2022-01-16T04:27:17Z"
          },
          "metric_type": "counts"
        }
      JSON
    end

    it "creates and returns a Metric Data Point with the specified params" do
      DoubleLoop.api_token = "foobarbaz"

      params = { name: "mpd test metric", date: Time.now, value: 69, metric_type: "counts" }

      stub = stub_request(:post, "#{DoubleLoop.endpoint}/metrics/v1")
             .with(
               headers: {
                 "Content-Type": "application/json"
               },
               body: {
                 **params,
                 api_token: DoubleLoop.api_token
               }.to_json
             )
             .to_return(body: response)

      task = described_class.create(params)

      expect(stub).to have_been_made
      expect(task).to be_a described_class
      expect(task.metric.name).to eq "mpd test metric"
      expect(task.metric_data_point.value).to eq 69.0
    end
  end
end
