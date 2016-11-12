module DBC

  # Support pour l'approche DBC... tres informel et "light"!
  #

  class AssertionFailure < RuntimeError; end
  class PreconditionFailure < RuntimeError; end
  class PostconditionFailure < RuntimeError; end

  module_function

  def assert( condition, message = nil )
    fail AssertionFailure, "Assertion failed: #{message}" unless condition
  end

  def requires( condition, message = nil )
    fail PreconditionFailure, "Precondition failed: #{message}" unless condition
  end

  def ensures( condition, message = nil )
    fail PostconditionFailure, "Postcondition failed: #{message}" unless condition
  end

end

