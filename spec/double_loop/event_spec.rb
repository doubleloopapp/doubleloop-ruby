# frozen_string_literal: true

RSpec.describe DoubleLoop::Event do
  describe "#create" do
    let(:response) do
      <<~JSON
        {
          "ok": true,
          "entity": {
            "id": 1412,
            "organization_id": 2058,
            "foreign_id": "8bf2e597-cadb-4094-8d97-b29153d6d973",
            "foreign_type": "api",
            "headline": "my headline",
            "summary": "`suuuuuup` dude",
            "importance": "medium",
            "results": null,
            "goal_hypothesis": null,
            "source_name": "api",
            "metadata": {},
            "activity_id": null,
            "impact": "positive",
            "created_at": "2022-01-16T05:54:29Z",
            "updated_at": "2022-01-16T05:54:29Z",
            "entities_classifications_count": 0,
            "entity_groups_count": 0,
            "labels_count": 3,
            "user_id": null,
            "source_summary": null,
            "last_event_happened_at": "2022-01-16T05:54:29Z",
            "hide_in_feed": false,
            "link_title": null,
            "link_url": null,
            "entity_type": null,
            "has_edited_headline": true,
            "source_headline": null,
            "foreign_state": null
          }
        }
      JSON
    end

    it "creates and returns an Event with the specified params" do
      DoubleLoop.api_token = "foobarbaz"

      params = {
        headline: "my headline",
        happened_at: DateTime.parse("2022-01-01 11:45:31"),
        summary: "`suuuuuup` dude",
        importance: described_class::MEDIUM_IMPORTANCE,
        impact: described_class::POSITIVE_IMPACT,
        labels: %w[foo bar baz]
      }

      stub = stub_request(:post, "#{DoubleLoop.endpoint}/events/v1")
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
      expect(task.ok).to be true
      expect(task.entity.headline).to eq "my headline"
    end
  end
end
