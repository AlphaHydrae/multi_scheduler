require 'launchdr'
require 'fileutils'

module MultiScheduler

  class Launchd < Schedule

    def start
      stop
      plist.dump USER_AGENT
      plist.load!
    end

    def stop
      return false unless plist_exists?
      plist.unload!
      FileUtils.rm_f plist.file
    end

    private

    USER_AGENT = LaunchDr::Launchd::Paths[:user_agent]

    def plist_exists?
      begin
        File.exists? plist.file
      rescue
        false
      end
    end

    def plist
      @plist ||= LaunchDr::Launchd.new(@identifier).tap do |plist|
        plist[:ProgramArguments] = @command_arguments.dup.unshift(@command)
        plist[:RunAtLoad] = true
        plist[:EnvironmentVariables] = { 'PATH' => ENV['PATH'] } # TODO: add path option
      end
    end
  end
end
