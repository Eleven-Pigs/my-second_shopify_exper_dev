# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `activemodel-serializers-xml` gem.
# Please instead update this file by running `tapioca sync`.

# typed: true

module ActiveModel
  extend(::ActiveSupport::Autoload)

  class << self
    def eager_load!; end
    def gem_version; end
    def version; end
  end
end

module ActiveModel::Serializers
  extend(::ActiveSupport::Autoload)
end

ActiveModel::Serializers::VERSION = T.let(T.unsafe(nil), String)

module ActiveModel::Serializers::Xml
  include(::ActiveModel::Serialization)
  extend(::ActiveSupport::Concern)

  mixes_in_class_methods(::ActiveModel::Naming)

  def from_xml(xml); end
  def to_xml(options = T.unsafe(nil), &block); end
end

class ActiveModel::Serializers::Xml::Serializer
  def initialize(serializable, options = T.unsafe(nil)); end

  def options; end
  def serializable_collection; end
  def serializable_hash; end
  def serialize; end

  private

  def add_associations(association, records, opts); end
  def add_attributes_and_methods; end
  def add_extra_behavior; end
  def add_includes; end
  def add_procs; end
end

class ActiveModel::Serializers::Xml::Serializer::Attribute
  def initialize(name, serializable, value); end

  def decorations; end
  def name; end
  def type; end
  def value; end

  protected

  def compute_type; end
end

class ActiveModel::Serializers::Xml::Serializer::MethodAttribute < ::ActiveModel::Serializers::Xml::Serializer::Attribute
end

module ActiveRecord
  extend(::ActiveSupport::Autoload)

  class << self
    def eager_load!; end
    def gem_version; end
    def version; end
  end
end

class ActiveRecord::MigrationProxy < ::Struct
  def initialize(name, version, filename, scope); end

  def announce(*args, &block); end
  def basename; end
  def disable_ddl_transaction(*args, &block); end
  def filename; end
  def filename=(_); end
  def migrate(*args, &block); end
  def mtime; end
  def name; end
  def name=(_); end
  def scope; end
  def scope=(_); end
  def version; end
  def version=(_); end
  def write(*args, &block); end

  private

  def load_migration; end
  def migration; end

  class << self
    def [](*_); end
    def inspect; end
    def members; end
    def new(*_); end
  end
end

module ActiveRecord::Serialization
  extend(::ActiveSupport::Concern)

  include(::ActiveModel::Serializers::JSON)
  include(::ActiveModel::Serializers::Xml)

  def serializable_hash(options = T.unsafe(nil)); end
  def to_xml(options = T.unsafe(nil), &block); end
end

ActiveRecord::UnknownAttributeError = ActiveModel::UnknownAttributeError

class ActiveRecord::XmlSerializer < ::ActiveModel::Serializers::Xml::Serializer
end

class ActiveRecord::XmlSerializer::Attribute < ::ActiveModel::Serializers::Xml::Serializer::Attribute

  protected

  def compute_type; end
end
