require "rguidepost/version"
require "tty-prompt"
require 'yaml'
require "open3"
require_relative "./rguidepost/command"

module Rguidepost
  extend self

  def read_commands
    yaml = YAML.load_file('rguidepost.yml')
    raise "rguidepost.yml is not hash." unless yaml.is_a? Hash
    commands = yaml["commands"]
    raise %q{rguidepost.yml doesn't have 'commands' key. } if commands.nil?

    commands
  end
  
  
  def execute_repository_command
    commands = read_commands

    command = TTY::Prompt.new.select("repository commands:") do |menu|
      commands.keys.each do |key|
        menu.choice key, Command.new(commands, key)
      end
    end

    success = command.execute
    exit 1 unless success
  rescue TTY::Reader::InputInterrupt => e
    puts ""
    puts "aborted."
    exit 1
  rescue => e
    puts e.message
    puts "aborted."
    exit 1
  end
end
