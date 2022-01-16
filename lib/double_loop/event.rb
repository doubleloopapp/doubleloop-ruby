# frozen_string_literal: true

module DoubleLoop
  class Event < DoubleLoop::Object
    VERSION = "v1"

    MINOR_IMPORTANCE = "minor"
    MEDIUM_IMPORTANCE = "medium"
    MAJOR_IMPORTANCE = "major"

    POSITIVE_IMPACT = "positive"
    NEGATIVE_IMPACT = "negative"

    def self.create(params = {})
      data = Client.post("/events/#{VERSION}", params)
      new(data)
    end
  end
end
