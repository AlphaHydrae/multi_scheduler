#require 'whenever'

module MultiScheduler

  class Whenever < Schedule

    def start
      raise 'Not yet implemented on this operating system'
      ::Whenever::CommandLine.execute block: mount_schedule, write: true, identifier: @identifier
    end

    def stop
      raise 'Not yet implemented on this operating system'
      ::Whenever::CommandLine.execute block: mount_schedule, clear: true, identifier: @identifier
    end

    private

    def self.mount_schedule
      Proc.new do
        every 1.minute do
          command 'echo $(date) > /tmp/bar.txt'
        end
      end
    end
  end
end
