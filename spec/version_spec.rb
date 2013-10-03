require 'helper'

describe "Version" do

  it "should be correct" do
    expect(MultiScheduler::VERSION).to eq(File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')))
  end
end
