# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `activerecord-typedstore` gem.
# Please instead update this file by running `bin/tapioca gem activerecord-typedstore`.

module ActiveRecord
  class << self
    def action_on_strict_loading_violation; end
    def action_on_strict_loading_violation=(_arg0); end
    def application_record_class; end
    def application_record_class=(_arg0); end
    def async_query_executor; end
    def async_query_executor=(_arg0); end
    def default_timezone; end
    def default_timezone=(default_timezone); end
    def dump_schema_after_migration; end
    def dump_schema_after_migration=(_arg0); end
    def dump_schemas; end
    def dump_schemas=(_arg0); end
    def eager_load!; end
    def error_on_ignored_order; end
    def error_on_ignored_order=(_arg0); end
    def gem_version; end
    def global_executor_concurrency; end
    def global_executor_concurrency=(global_executor_concurrency); end
    def global_thread_pool_async_query_executor; end
    def index_nested_attribute_errors; end
    def index_nested_attribute_errors=(_arg0); end
    def lazily_load_schema_cache; end
    def lazily_load_schema_cache=(_arg0); end
    def legacy_connection_handling; end
    def legacy_connection_handling=(_arg0); end
    def maintain_test_schema; end
    def maintain_test_schema=(_arg0); end
    def query_transformers; end
    def query_transformers=(_arg0); end
    def queues; end
    def queues=(_arg0); end
    def reading_role; end
    def reading_role=(_arg0); end
    def schema_cache_ignored_tables; end
    def schema_cache_ignored_tables=(_arg0); end
    def schema_format; end
    def schema_format=(_arg0); end
    def suppress_multiple_database_warning; end
    def suppress_multiple_database_warning=(_arg0); end
    def timestamped_migrations; end
    def timestamped_migrations=(_arg0); end
    def verbose_query_logs; end
    def verbose_query_logs=(_arg0); end
    def verify_foreign_keys_for_fixtures; end
    def verify_foreign_keys_for_fixtures=(_arg0); end
    def version; end
    def warn_on_records_fetched_greater_than; end
    def warn_on_records_fetched_greater_than=(_arg0); end
    def writing_role; end
    def writing_role=(_arg0); end
  end
end

class ActiveRecord::MigrationProxy < ::Struct
  def initialize(name, version, filename, scope); end

  def announce(*_arg0, **_arg1, &_arg2); end
  def basename; end
  def disable_ddl_transaction(*_arg0, **_arg1, &_arg2); end
  def filename; end
  def filename=(_); end
  def migrate(*_arg0, **_arg1, &_arg2); end
  def name; end
  def name=(_); end
  def scope; end
  def scope=(_); end
  def version; end
  def version=(_); end
  def write(*_arg0, **_arg1, &_arg2); end

  private

  def load_migration; end
  def migration; end

  class << self
    def [](*_arg0); end
    def inspect; end
    def keyword_init?; end
    def members; end
    def new(*_arg0); end
  end
end

module ActiveRecord::TypedStore; end

module ActiveRecord::TypedStore::Behavior
  extend ::ActiveSupport::Concern

  mixes_in_class_methods ::ActiveRecord::TypedStore::Behavior::ClassMethods

  # @return [Boolean]
  def attribute?(attr_name); end

  def changes; end
  def clear_attribute_change(attr_name); end
  def read_attribute(attr_name); end
end

module ActiveRecord::TypedStore::Behavior::ClassMethods
  def define_attribute_methods; end
  def define_typed_store_attribute_methods; end
  def undefine_attribute_methods; end
  def undefine_before_type_cast_method(attribute); end
end

class ActiveRecord::TypedStore::DSL
  # @return [DSL] a new instance of DSL
  # @yield [_self]
  # @yieldparam _self [ActiveRecord::TypedStore::DSL] the object that the method was called on
  def initialize(store_name, options); end

  def accessors; end
  def any(name, **options); end
  def boolean(name, **options); end

  # Returns the value of attribute coder.
  def coder; end

  def date(name, **options); end
  def date_time(name, **options); end
  def datetime(name, **options); end
  def decimal(name, **options); end
  def default_coder(attribute_name); end

  # Returns the value of attribute fields.
  def fields; end

  def float(name, **options); end
  def integer(name, **options); end
  def keys(*_arg0, **_arg1, &_arg2); end
  def string(name, **options); end
  def text(name, **options); end
  def time(name, **options); end

  private

  def accessor_key_for(name); end
end

ActiveRecord::TypedStore::DSL::NO_DEFAULT_GIVEN = T.let(T.unsafe(nil), Object)

module ActiveRecord::TypedStore::Extension
  def typed_store(store_attribute, options = T.unsafe(nil), &block); end
end

class ActiveRecord::TypedStore::Field
  # @return [Field] a new instance of Field
  def initialize(name, type, options = T.unsafe(nil)); end

  # Returns the value of attribute accessor.
  def accessor; end

  # Returns the value of attribute array.
  def array; end

  # Returns the value of attribute blank.
  def blank; end

  def cast(value); end

  # Returns the value of attribute default.
  def default; end

  # @return [Boolean]
  def has_default?; end

  # Returns the value of attribute name.
  def name; end

  # Returns the value of attribute null.
  def null; end

  # Returns the value of attribute type.
  def type; end

  # Returns the value of attribute type_sym.
  def type_sym; end

  private

  def extract_default(value); end
  def lookup_type(type, options); end
  def type_cast(value, arrayize: T.unsafe(nil)); end
end

ActiveRecord::TypedStore::Field::TYPES = T.let(T.unsafe(nil), Hash)

module ActiveRecord::TypedStore::IdentityCoder
  extend ::ActiveRecord::TypedStore::IdentityCoder

  def dump(data); end
  def load(data); end
end

class ActiveRecord::TypedStore::Type < ::ActiveRecord::Type::Serialized
  # @return [Type] a new instance of Type
  def initialize(typed_hash_klass, coder, subtype); end

  # @return [Boolean]
  def changed_in_place?(raw_old_value, value); end

  # @return [Boolean]
  def default_value?(value); end

  def defaults; end
  def deserialize(value); end
  def serialize(value); end
  def type_cast_for_database(value); end
  def type_cast_from_database(value); end
  def type_cast_from_user(value); end
end

class ActiveRecord::TypedStore::TypedHash < ::ActiveSupport::HashWithIndifferentAccess
  # @return [TypedHash] a new instance of TypedHash
  def initialize(constructor = T.unsafe(nil)); end

  def []=(key, value); end
  def defaults_hash(*_arg0, **_arg1, &_arg2); end
  def except(*_arg0, **_arg1, &_arg2); end
  def fields(*_arg0, **_arg1, &_arg2); end
  def merge!(other_hash); end
  def slice(*_arg0, **_arg1, &_arg2); end
  def store(key, value); end
  def update(other_hash); end
  def with_indifferent_access(*_arg0, **_arg1, &_arg2); end
  def without(*_arg0, **_arg1, &_arg2); end

  private

  def cast_value(key, value); end

  class << self
    def create(fields); end
    def defaults_hash; end

    # Returns the value of attribute fields.
    def fields; end
  end
end

ActiveRecord::UnknownAttributeError = ActiveModel::UnknownAttributeError
