require "appdev_support/version"

module AppdevSupport
  class Error < StandardError; end

  class << self
    attr_writer :active_record, :action_dispatch, :pryrc

    def action_dispatch
      @action_dispatch || true
    end

    def active_record
      @active_record || true
    end

    def pryrc
      @pryrc || :minimal
    end

    def config
      yield self
    end
  end

  def self.init
    if @active_record
      load "appdev_support/active_record/delegation.rb"
      load "appdev_support/active_record/attribute_methods.rb"
      load "appdev_support/active_record/relation/to_s.rb"
    end
    if @action_dispatch
      load "appdev_support/action_dispatch/request/session/fetch.rb"
      load "appdev_support/action_dispatch/request/session/store.rb"
      load "appdev_support/action_dispatch/cookies/cookie_jar/fetch.rb"
      load "appdev_support/action_dispatch/cookies/cookie_jar/store.rb"
    end
    return unless Object.const_defined?("Pry")
    case @pryrc
    when :minimal, true
      load "appdev_support/pryrc/minimal.rb"
    when :debug
      load "appdev_support/pryrc/debug.rb"
    end
  end
end
