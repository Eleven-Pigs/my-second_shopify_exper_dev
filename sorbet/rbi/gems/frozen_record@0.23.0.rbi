# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `frozen_record` gem.
# Please instead update this file by running `bin/tapioca gem frozen_record`.

module FrozenRecord
  class << self
    # Returns the value of attribute deprecated_yaml_erb_backend.
    def deprecated_yaml_erb_backend; end

    # Sets the attribute deprecated_yaml_erb_backend
    #
    # @param value the value to set the attribute deprecated_yaml_erb_backend to.
    def deprecated_yaml_erb_backend=(_arg0); end

    def eager_load!; end
  end
end

module FrozenRecord::Backends; end

module FrozenRecord::Backends::Json
  extend ::FrozenRecord::Backends::Json

  def filename(model_name); end
  def load(file_path); end
end

module FrozenRecord::Backends::Yaml
  extend ::FrozenRecord::Backends::Yaml

  # Transforms the model name into a valid filename.
  #
  # @param format [String] the model name that inherits
  #   from FrozenRecord::Base
  # @return [String] the file name.
  def filename(model_name); end

  # Reads file in `file_path` and return records.
  #
  # @param format [String] the file path
  # @return [Array] an Array of Hash objects with keys being attributes.
  def load(file_path); end

  private

  def load_file(path); end
  def load_string(yaml); end
end

class FrozenRecord::Base
  include ::ActiveModel::Conversion
  include ::ActiveModel::AttributeMethods
  include ::ActiveModel::Serialization
  include ::ActiveModel::Serializers::JSON
  extend ::ActiveSupport::DescendantsTracker
  extend ::ActiveModel::Naming
  extend ::ActiveModel::Conversion::ClassMethods
  extend ::ActiveModel::AttributeMethods::ClassMethods

  # @return [Base] a new instance of Base
  def initialize(attrs = T.unsafe(nil)); end

  def ==(other); end
  def [](attr); end
  def attribute(attr); end
  def attribute_aliases; end
  def attribute_aliases?; end
  def attribute_method_matchers; end
  def attribute_method_matchers?; end
  def attributes; end
  def id; end
  def include_root_in_json; end
  def include_root_in_json?; end
  def model_name(*_arg0, **_arg1, &_arg2); end

  # @return [Boolean]
  def persisted?; end

  def to_key; end

  private

  # @return [Boolean]
  def attribute?(attribute_name); end

  # @return [Boolean]
  def attribute_method?(attribute_name); end

  class << self
    # Returns the value of attribute abstract_class.
    def abstract_class; end

    # Sets the attribute abstract_class
    #
    # @param value the value to set the attribute abstract_class to.
    def abstract_class=(_arg0); end

    # @return [Boolean]
    def abstract_class?; end

    def add_index(attribute, unique: T.unsafe(nil)); end
    def all; end
    def attribute_aliases; end
    def attribute_aliases=(value); end
    def attribute_aliases?; end
    def attribute_method_matchers; end
    def attribute_method_matchers=(value); end
    def attribute_method_matchers?; end
    def attributes; end
    def auto_reloading; end
    def auto_reloading=(value); end
    def auto_reloading?; end
    def average(*_arg0, **_arg1, &_arg2); end
    def backend; end
    def backend=(value); end
    def backend?; end
    def base_path; end
    def base_path=(base_path); end
    def base_path?; end
    def count(*_arg0, **_arg1, &_arg2); end
    def current_scope; end
    def current_scope=(scope); end
    def default_attributes; end
    def default_attributes=(default_attributes); end
    def default_attributes?; end
    def each(*_arg0, **_arg1, &_arg2); end
    def eager_load!; end

    # @raise [ArgumentError]
    def file_path; end

    def find(*_arg0, **_arg1, &_arg2); end
    def find_by(*_arg0, **_arg1, &_arg2); end
    def find_by!(*_arg0, **_arg1, &_arg2); end
    def find_by_id(*_arg0, **_arg1, &_arg2); end
    def find_each(*_arg0, **_arg1, &_arg2); end
    def first(*_arg0, **_arg1, &_arg2); end
    def first!(*_arg0, **_arg1, &_arg2); end
    def ids(*_arg0, **_arg1, &_arg2); end
    def include_root_in_json; end
    def include_root_in_json=(value); end
    def include_root_in_json?; end
    def index_definitions; end
    def index_definitions=(value); end
    def index_definitions?; end
    def last(*_arg0, **_arg1, &_arg2); end
    def last!(*_arg0, **_arg1, &_arg2); end
    def limit(*_arg0, **_arg1, &_arg2); end
    def load_records(force: T.unsafe(nil)); end
    def maximum(*_arg0, **_arg1, &_arg2); end
    def memsize(object = T.unsafe(nil), seen = T.unsafe(nil)); end
    def minimum(*_arg0, **_arg1, &_arg2); end
    def new(attrs = T.unsafe(nil)); end
    def offset(*_arg0, **_arg1, &_arg2); end
    def order(*_arg0, **_arg1, &_arg2); end
    def pluck(*_arg0, **_arg1, &_arg2); end
    def primary_key; end
    def primary_key=(primary_key); end
    def primary_key?; end

    # @return [Boolean]
    def respond_to_missing?(name, *_arg1); end

    def scope(name, body); end
    def sum(*_arg0, **_arg1, &_arg2); end
    def where(*_arg0, **_arg1, &_arg2); end

    private

    def assign_defaults!(record); end
    def dynamic_match(expression, values, bang); end

    # @return [Boolean]
    def file_changed?; end

    def list_attributes(records); end
    def load(*_arg0); end
    def method_missing(name, *args); end
    def set_base_path(value); end
    def set_default_attributes(value); end
    def set_primary_key(value); end
    def store; end
  end
end

FrozenRecord::Base::FALSY_VALUES = T.let(T.unsafe(nil), Set)
FrozenRecord::Base::FIND_BY_PATTERN = T.let(T.unsafe(nil), Regexp)

class FrozenRecord::Base::ThreadSafeStorage
  # @return [ThreadSafeStorage] a new instance of ThreadSafeStorage
  def initialize(key); end

  def [](key); end
  def []=(key, value); end
end

module FrozenRecord::Compact
  extend ::ActiveSupport::Concern

  mixes_in_class_methods ::FrozenRecord::Compact::ClassMethods

  def initialize(attrs = T.unsafe(nil)); end

  def [](attr); end
  def attributes; end

  private

  # @return [Boolean]
  def attribute?(attribute_name); end

  def attributes=(attributes); end
end

module FrozenRecord::Compact::ClassMethods
  # Returns the value of attribute _attributes_cache.
  def _attributes_cache; end

  def define_method_attribute(attr, **_arg1); end
  def load_records(force: T.unsafe(nil)); end

  private

  def build_attributes_cache; end
end

class FrozenRecord::Index
  # @return [Index] a new instance of Index
  def initialize(model, attribute, unique: T.unsafe(nil)); end

  # Returns the value of attribute attribute.
  def attribute; end

  def build(records); end
  def lookup(value); end
  def lookup_multi(values); end

  # Returns the value of attribute model.
  def model; end

  def query(matcher); end
  def reset; end

  # @return [Boolean]
  def unique?; end
end

class FrozenRecord::Index::AttributeNonUnique < ::StandardError; end
FrozenRecord::Index::EMPTY_ARRAY = T.let(T.unsafe(nil), Array)
class FrozenRecord::RecordNotFound < ::StandardError; end

class FrozenRecord::Scope
  # @return [Scope] a new instance of Scope
  def initialize(klass); end

  def ==(other); end
  def all?(*_arg0, **_arg1, &_arg2); end
  def as_json(*_arg0, **_arg1, &_arg2); end
  def average(attribute); end
  def collect(*_arg0, **_arg1, &_arg2); end
  def count(*_arg0, **_arg1, &_arg2); end
  def each(*_arg0, **_arg1, &_arg2); end

  # @return [Boolean]
  def exists?; end

  # @raise [RecordNotFound]
  def find(id); end

  def find_by(criterias); end
  def find_by!(criterias); end
  def find_by_id(id); end
  def find_each(*_arg0, **_arg1, &_arg2); end
  def first(*_arg0, **_arg1, &_arg2); end
  def first!; end
  def hash; end
  def ids; end
  def include?(*_arg0, **_arg1, &_arg2); end
  def last(*_arg0, **_arg1, &_arg2); end
  def last!; end
  def length(*_arg0, **_arg1, &_arg2); end
  def limit(amount); end
  def map(*_arg0, **_arg1, &_arg2); end
  def maximum(attribute); end
  def minimum(attribute); end
  def offset(amount); end
  def order(*ordering); end
  def pluck(*attributes); end
  def sum(attribute); end
  def to_a; end
  def to_ary(*_arg0, **_arg1, &_arg2); end
  def to_json(*_arg0, **_arg1, &_arg2); end
  def where(criterias = T.unsafe(nil)); end
  def where_not(criterias); end

  protected

  # @return [Boolean]
  def array_delegable?(method); end

  def clear_cache!; end
  def comparable_attributes; end
  def compare(record_a, record_b); end
  def delegate_to_class(*args, &block); end
  def limit!(amount); end
  def matching_records; end
  def method_missing(method_name, *args, **_arg2, &block); end
  def offset!(amount); end
  def order!(*ordering); end
  def query_results; end
  def scoping; end
  def select_records(records); end
  def slice_records(records); end
  def sort_records(records); end
  def spawn; end
  def where!(criterias); end
  def where_not!(criterias); end

  private

  # @return [Boolean]
  def respond_to_missing?(method_name, *_arg1); end
end

class FrozenRecord::Scope::CoverMatcher < ::FrozenRecord::Scope::Matcher
  # @return [Boolean]
  def match?(other); end

  # @return [Boolean]
  def ranged?; end
end

FrozenRecord::Scope::DISALLOWED_ARRAY_METHODS = T.let(T.unsafe(nil), Set)

class FrozenRecord::Scope::IncludeMatcher < ::FrozenRecord::Scope::Matcher
  # @return [Boolean]
  def match?(other); end

  # @return [Boolean]
  def ranged?; end
end

class FrozenRecord::Scope::Matcher
  # @return [Matcher] a new instance of Matcher
  def initialize(value); end

  def ==(other); end
  def eql?(other); end
  def hash; end

  # @return [Boolean]
  def match?(other); end

  # @return [Boolean]
  def ranged?; end

  # Returns the value of attribute value.
  def value; end

  class << self
    def for(value); end
  end
end

class FrozenRecord::Scope::WhereChain
  # @return [WhereChain] a new instance of WhereChain
  def initialize(scope); end

  def not(criterias); end
end

class FrozenRecord::UniqueIndex < ::FrozenRecord::Index
  def build(records); end
  def lookup(value); end
  def lookup_multi(values); end

  # @return [Boolean]
  def unique?; end
end

FrozenRecord::VERSION = T.let(T.unsafe(nil), String)
