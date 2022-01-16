# frozen_string_literal: true

RSpec.describe DoubleLoop::Object do
  describe "#initialize" do
    it "recursively creates objects for any Hash values in the data" do
      data = {
        foo: {
          bar: {
            baz: {
              quux: "sweet!"
            }
          },
          marf: 22,
          tacos: [1, 2, 3, { a: 1 }]
        }
      }

      result = described_class.new(data)

      expect(result.foo.bar.baz.quux).to eq "sweet!"
      expect(result.foo.marf).to eq 22
      expect(result.foo.tacos).to eq [1, 2, 3, { a: 1 }] # does not convert hashes within arrays
    end
  end
end
