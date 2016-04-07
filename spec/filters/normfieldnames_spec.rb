# encoding: utf-8
require 'spec_helper'
require "logstash/filters/normfieldnames"

describe LogStash::Filters::NormFieldnames do
  describe "Test normfieldnames" do
    let(:config) do <<-CONFIG
      filter {
         normfieldnames { }
      }
    CONFIG
    end

    sample({
        "message" => "some text",
        "with space" => "tea",
        "with  spaces" => "coffee",
        "a_b" => "x",
        "a b" => "y",
        "z&*x" => "spam"
    }) do
      expect(subject).to include("message")
      expect(subject["message"]).to eq('some text')
      expect(subject).to include("with_space")
      expect(subject["with_space"]).to eq('tea')
      expect(subject).to include("with__spaces")
      expect(subject["with__spaces"]).to eq("coffee")
      expect(subject).to include("a_b")
      expect(subject["a_b"]).to eq("x")
      expect(subject).to include("a_b_")
      expect(subject["a_b_"]).to eq("y")
      expect(subject).to include("z262ax")
      expect(subject["z262ax"]).to eq("spam")

      expect(subject).not_to include("with space")
      expect(subject).not_to include("with  spaces")
      expect(subject).not_to include("a b")
      expect(subject).not_to include("z&*z")
    end
  end
end
