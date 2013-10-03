# encoding: UTF-8

module MultiScheduler
  VERSION = '0.1.1'

  def self.schedule id, options = {}
    host_os = RbConfig::CONFIG['host_os']
    case host_os
    when /darwin/i
      Launchd.new id, options
    when /linux/i
      Whenever.new id, options
    else
      raise "Unsupported host operating system '#{host_os}'"
    end
  end
end

Dir[File.join File.dirname(__FILE__), File.basename(__FILE__, '.*'), '*.rb'].each{ |lib| require lib }
