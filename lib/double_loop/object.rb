# frozen_string_literal: true

require "ostruct"

module DoubleLoop
  # Base Object class
  class Object < OpenStruct # rubocop:disable Style/OpenStructUse
    attr_reader :_data

    def initialize(data = {})
      attributes = data.dup

      attributes.transform_values! do |val|
        if val.is_a?(Hash)
          self.class.new(val)
        else
          val
        end
      end

      super(attributes)
    end
  end
end
