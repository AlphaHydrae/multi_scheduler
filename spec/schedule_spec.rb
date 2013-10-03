require 'helper'

describe MultiScheduler::Schedule do
  let(:schedule_identifier){ 'com.example.app' }
  let(:schedule_options){ { command: 'foo', command_arguments: %w(bar baz) } }
  subject{ MultiScheduler::Schedule }

  it "should require an identifier" do
    expect{ new_schedule id: nil }.to raise_error
  end

  it "should require a command" do
    expect{ new_schedule command: nil, command_arguments: nil }.to raise_error
  end

  def new_schedule options = {}
    id = options.key?(:id) ? options[:id] : schedule_identifier
    MultiScheduler::Schedule.new id, options
  end
end
