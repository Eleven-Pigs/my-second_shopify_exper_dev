# typed: true
# frozen_string_literal: true

require 'smart_properties'
require 'active_support/all'
require 'baz'

# Fake as much of Rails as we can
module Rails
  class Application
    attr_reader :config
  end

  def self.application
    Application.new
  end
end

# A type with a DSL
class Post
  include SmartProperties
  property :title, accepts: String
end

# Another type with a DSL in a namespace
module Namespace
  class Comment
    include SmartProperties
    property! :body, accepts: String
  end
end

# A simple type
class User
end
