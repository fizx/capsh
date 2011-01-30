#!/usr/bin/env ruby
require "rubygems"
require "capistrano"
require "capistrano/shell"

class Capsh
  module Ext
    def current_task
      super || task_list(true).first
    end
  end
  
  attr_reader :cfg
  
  def initialize(hosts, options = {}, cfg = Capistrano::Configuration.new)
    @cfg = cfg
    cfg.set :ssh_options, { :forward_agent => true, :auth_methods => "publickey" }
    cfg.extend(Ext)
    options.each do |k, v|
      cfg.set(k, v)
    end
    cfg.role :app, *hosts    
    cfg.task :a_fake_caph_task do
    end
  end
  
  def run()
    Capistrano::Shell.run(cfg)
  end
end