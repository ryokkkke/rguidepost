module Rguidepost
  class Command
    def initialize(entire_data, command_key)
      @entire_data = entire_data
      command_data = @entire_data[command_key]
      @command_string = command_data if command_data.is_a? String

      if command_data.is_a? Hash
        @command_string = command_data["command"]
        @pre_command = Command.new(@entire_data, command_data["pre_command"]) unless command_data["pre_command"].nil?
        @ignore_pre = command_data["ignore_pre"] || false
        @post_command = Command.new(@entire_data, command_data["post_command"]) unless command_data["post_command"].nil?
        @ensure_post = command_data["ensure_post"] || false
      end

      raise "#{command_key}: undefined command." if @command_string.nil? || @command_string == ""
    end

    def execute
      unless @pre_command.nil?
        success = @pre_command.execute
        return false if !success && !@ignore_pre
      end

      status = execute_command(@command_string)

      return status.success? if @post_command.nil?
      return false if !status.success? && !@ensure_post

      success = @post_command.execute
      success
    end

    private

    def execute_command command
      Open3.popen3(%Q{bash -lc "#{command}"}) do |stdin, stdout, stderr, wait_thread|
        stdout.each { |line| puts line }
        stderr.each { |line| puts line }
        wait_thread.value
      end
    end
  end
end