# frozen_string_literal: true

module DoubleLoop
  class Metric < DoubleLoop::Object
    VERSION = "v1"

    SUM = "sum"
    AVERAGE = "average"
    INCREASE = "increase"
    WEIGHTED_AVERAGE = "weighted_average"
    LAST_MONTH_AVAILABLE = "last_month_available"

    ROLL_UP_TYPES = [SUM, AVERAGE, INCREASE, WEIGHTED_AVERAGE, LAST_MONTH_AVAILABLE].freeze

    def self.create(params = {})
      data = Client.post("/metrics/#{VERSION}", params)
      new(data)
    end
  end
end
