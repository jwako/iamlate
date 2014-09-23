module Iamlate
  # Base Exception class and such.
  class Exception < ::StandardError
    attr_accessor :opstat, :code, :msg

    def initialize(opstat, code, msg)
      @opstat = opstat
      @code = code
      @msg = msg
    end
  end
end
