# encoding: UTF-8

module MultiScheduler
  VERSION = '0.1.0'

  def schedule options = {}
    scheduler(options).start
  end

  def unschedule id
    scheduler({ identifier: id }).stop
  end

  def scheduler options = {}
    case RbConfig::CONFIG['host_os']
    when /darwin/i
      Launchd.new options
    else
      Whenever.new options
    end
  end

  class Scheduler
    
    def initialize options = {}

      @identifier = options[:id]
      raise ":id is required" unless @identifier

      @command_arguments = options[:args] || []
      @command = options[:command] || @command_arguments.shift
      raise ":command is required" unless @command
    end
  end
end

Dir[File.join File.dirname(__FILE__), File.basename(__FILE__, '.*'), '*.rb'].each{ |lib| require lib }
