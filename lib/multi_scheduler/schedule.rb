
module MultiScheduler

  class Schedule
    attr_reader :identifier, :command, :command_arguments
    
    def initialize id, options = {}

      @identifier = id
      raise "identifier is required" unless @identifier

      @command_arguments = [ options[:args] ].flatten.compact
      @command = options[:command] || @command_arguments.shift
      raise "command is required" unless @command
    end
  end
end

Dir[File.join File.dirname(__FILE__), File.basename(__FILE__, '.*'), '*.rb'].each{ |lib| require lib }
