# frozen_string_literal: true

module DoubleLoop
  class Metric < DoubleLoop::Object
    VERSION = "v1"

    # constants for the `metric_type` enum
    COUNTS = "counts"
    PERCENTAGES = "percentages"

    def self.create(params = {})
      data = Client.post("/metrics/#{VERSION}", params)
      new(data)
    end
  end
end
