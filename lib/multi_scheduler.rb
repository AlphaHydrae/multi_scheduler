# encoding: UTF-8

module MultiScheduler
  VERSION = '0.1.0'

  def self.schedule id, options = {}
    scheduler(id, options).start
  end

  def self.unschedule id, options = {}
    scheduler(id, options).stop
  end

  def self.scheduler id, options = {}
    case RbConfig::CONFIG['host_os']
    when /darwin/i
      Launchd.new id, options
    else
      Whenever.new id, options
    end
  end

  private

  class Scheduler
    
    def initialize id, options = {}

      @identifier = id
      raise "identifier is required" unless @identifier

      @command_arguments = [ options[:args] ].flatten.compact
      @command = options[:command] || @command_arguments.shift
    end
  end
end

Dir[File.join File.dirname(__FILE__), File.basename(__FILE__, '.*'), '*.rb'].each{ |lib| require lib }
