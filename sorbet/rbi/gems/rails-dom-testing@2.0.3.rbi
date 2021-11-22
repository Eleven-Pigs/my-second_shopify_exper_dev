# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rails-dom-testing` gem.
# Please instead update this file by running `bin/tapioca gem rails-dom-testing`.

class HTMLSelector
  def initialize(values, previous_selection = T.unsafe(nil), &root_fallback); end

  def context; end

  # Returns the value of attribute css_selector.
  def css_selector; end

  # Returns the value of attribute message.
  def message; end

  def select; end
  def selecting_no_body?; end

  # Returns the value of attribute tests.
  def tests; end

  private

  def extract_equality_tests; end
  def extract_root(previous_selection, root_fallback); end
  def extract_selectors; end
  def filter(matches); end

  class << self
    def context; end
  end
end

HTMLSelector::NO_STRIP = T.let(T.unsafe(nil), Array)

module Rails
  class << self
    def app_class; end
    def app_class=(_arg0); end
    def application; end
    def application=(_arg0); end
    def autoloaders; end
    def backtrace_cleaner; end
    def cache; end
    def cache=(_arg0); end
    def configuration; end
    def env; end
    def env=(environment); end
    def gem_version; end
    def groups(*groups); end
    def initialize!(*_arg0, &_arg1); end
    def initialized?(*_arg0, &_arg1); end
    def logger; end
    def logger=(_arg0); end
    def public_path; end
    def root; end
    def version; end
  end
end

module Rails::Dom; end
module Rails::Dom::Testing; end

module Rails::Dom::Testing::Assertions
  include ::Rails::Dom::Testing::Assertions::DomAssertions
  include ::Rails::Dom::Testing::Assertions::SelectorAssertions::CountDescribable
  include ::Rails::Dom::Testing::Assertions::SelectorAssertions
  extend ::ActiveSupport::Concern
end

module Rails::Dom::Testing::Assertions::DomAssertions
  # \Test two HTML strings for equivalency (e.g., equal even when attributes are in another order)
  #
  # # assert that the referenced method generates the appropriate HTML string
  # assert_dom_equal '<a href="http://www.example.com">Apples</a>', link_to("Apples", "http://www.example.com")
  def assert_dom_equal(expected, actual, message = T.unsafe(nil)); end

  # The negated form of +assert_dom_equal+.
  #
  # # assert that the referenced method does not generate the specified HTML string
  # assert_dom_not_equal '<a href="http://www.example.com">Apples</a>', link_to("Oranges", "http://www.example.com")
  def assert_dom_not_equal(expected, actual, message = T.unsafe(nil)); end

  protected

  def compare_doms(expected, actual); end
  def equal_attribute?(attr, other_attr); end
  def equal_attribute_nodes?(nodes, other_nodes); end
  def equal_children?(child, other_child); end

  private

  def fragment(text); end
end

# Adds the +assert_select+ method for use in Rails functional
# test cases, which can be used to make assertions on the response HTML of a controller
# action. You can also call +assert_select+ within another +assert_select+ to
# make assertions on elements selected by the enclosing assertion.
#
# Use +css_select+ to select elements without making an assertions, either
# from the response HTML or elements selected by the enclosing assertion.
#
# In addition to HTML responses, you can make the following assertions:
#
# * +assert_select_encoded+ - Assertions on HTML encoded inside XML, for example for dealing with feed item descriptions.
# * +assert_select_email+ - Assertions on the HTML body of an e-mail.
module Rails::Dom::Testing::Assertions::SelectorAssertions
  include ::Rails::Dom::Testing::Assertions::SelectorAssertions::CountDescribable

  # An assertion that selects elements and makes one or more equality tests.
  #
  # If the first argument is an element, selects all matching elements
  # starting from (and including) that element and all its children in
  # depth-first order.
  #
  # If no element is specified +assert_select+ selects from
  # the element returned in +document_root_element+
  # unless +assert_select+ is called from within an +assert_select+ block.
  # Override +document_root_element+ to tell +assert_select+ what to select from.
  # The default implementation raises an exception explaining this.
  #
  # When called with a block +assert_select+ passes an array of selected elements
  # to the block. Calling +assert_select+ from the block, with no element specified,
  # runs the assertion on the complete set of elements selected by the enclosing assertion.
  # Alternatively the array may be iterated through so that +assert_select+ can be called
  # separately for each element.
  #
  #
  # ==== Example
  # If the response contains two ordered lists, each with four list elements then:
  # assert_select "ol" do |elements|
  # elements.each do |element|
  # assert_select element, "li", 4
  # end
  # end
  #
  # will pass, as will:
  # assert_select "ol" do
  # assert_select "li", 8
  # end
  #
  # The selector may be a CSS selector expression (String) or an expression
  # with substitution values (Array).
  # Substitution uses a custom pseudo class match. Pass in whatever attribute you want to match (enclosed in quotes) and a ? for the substitution.
  # assert_select returns nil if called with an invalid css selector.
  #
  # assert_select "div:match('id', ?)", /\d+/
  #
  # === Equality Tests
  #
  # The equality test may be one of the following:
  # * <tt>true</tt> - Assertion is true if at least one element selected.
  # * <tt>false</tt> - Assertion is true if no element selected.
  # * <tt>String/Regexp</tt> - Assertion is true if the text value of at least
  # one element matches the string or regular expression.
  # * <tt>Integer</tt> - Assertion is true if exactly that number of
  # elements are selected.
  # * <tt>Range</tt> - Assertion is true if the number of selected
  # elements fit the range.
  # If no equality test specified, the assertion is true if at least one
  # element selected.
  #
  # To perform more than one equality tests, use a hash with the following keys:
  # * <tt>:text</tt> - Narrow the selection to elements that have this text
  # value (string or regexp).
  # * <tt>:html</tt> - Narrow the selection to elements that have this HTML
  # content (string or regexp).
  # * <tt>:count</tt> - Assertion is true if the number of selected elements
  # is equal to this value.
  # * <tt>:minimum</tt> - Assertion is true if the number of selected
  # elements is at least this value.
  # * <tt>:maximum</tt> - Assertion is true if the number of selected
  # elements is at most this value.
  #
  # If the method is called with a block, once all equality tests are
  # evaluated the block is called with an array of all matched elements.
  #
  # # At least one form element
  # assert_select "form"
  #
  # # Form element includes four input fields
  # assert_select "form input", 4
  #
  # # Page title is "Welcome"
  # assert_select "title", "Welcome"
  #
  # # Page title is "Welcome" and there is only one title element
  # assert_select "title", {count: 1, text: "Welcome"},
  # "Wrong title or more than one title element"
  #
  # # Page contains no forms
  # assert_select "form", false, "This page must contain no forms"
  #
  # # Test the content and style
  # assert_select "body div.header ul.menu"
  #
  # # Use substitution values
  # assert_select "ol>li:match('id', ?)", /item-\d+/
  #
  # # All input fields in the form have a name
  # assert_select "form input" do
  # assert_select ":match('name', ?)", /.+/  # Not empty
  # end
  def assert_select(*args, &block); end

  # Extracts the body of an email and runs nested assertions on it.
  #
  # You must enable deliveries for this assertion to work, use:
  # ActionMailer::Base.perform_deliveries = true
  #
  # assert_select_email do
  # assert_select "h1", "Email alert"
  # end
  #
  # assert_select_email do
  # items = assert_select "ol>li"
  # items.each do
  # # Work with items here...
  # end
  # end
  def assert_select_email(&block); end

  # Extracts the content of an element, treats it as encoded HTML and runs
  # nested assertion on it.
  #
  # You typically call this method within another assertion to operate on
  # all currently selected elements. You can also pass an element or array
  # of elements.
  #
  # The content of each element is un-encoded, and wrapped in the root
  # element +encoded+. It then calls the block with all un-encoded elements.
  #
  # # Selects all bold tags from within the title of an Atom feed's entries (perhaps to nab a section name prefix)
  # assert_select "feed[xmlns='http://www.w3.org/2005/Atom']" do
  # # Select each entry item and then the title item
  # assert_select "entry>title" do
  # # Run assertions on the encoded title elements
  # assert_select_encoded do
  # assert_select "b"
  # end
  # end
  # end
  #
  #
  # # Selects all paragraph tags from within the description of an RSS feed
  # assert_select "rss[version=2.0]" do
  # # Select description element of each feed item.
  # assert_select "channel>item>description" do
  # # Run assertions on the encoded elements.
  # assert_select_encoded do
  # assert_select "p"
  # end
  # end
  # end
  def assert_select_encoded(element = T.unsafe(nil), &block); end

  # Select and return all matching elements.
  #
  # If called with a single argument, uses that argument as a selector.
  # Called without an element +css_select+ selects from
  # the element returned in +document_root_element+
  #
  # The default implementation of +document_root_element+ raises an exception explaining this.
  #
  # Returns an empty Nokogiri::XML::NodeSet if no match is found.
  #
  # If called with two arguments, uses the first argument as the root
  # element and the second argument as the selector. Attempts to match the
  # root element and any of its children.
  # Returns an empty Nokogiri::XML::NodeSet if no match is found.
  #
  # The selector may be a CSS selector expression (String).
  # css_select returns nil if called with an invalid css selector.
  #
  # # Selects all div tags
  # divs = css_select("div")
  #
  # # Selects all paragraph tags and does something interesting
  # pars = css_select("p")
  # pars.each do |par|
  # # Do something fun with paragraphs here...
  # end
  #
  # # Selects all list items in unordered lists
  # items = css_select("ul>li")
  #
  # # Selects all form tags and then all inputs inside the form
  # forms = css_select("form")
  # forms.each do |form|
  # inputs = css_select(form, "input")
  # ...
  # end
  def css_select(*args); end

  private

  # +equals+ must contain :minimum, :maximum and :count keys
  def assert_size_match!(size, equals, css_selector, message = T.unsafe(nil)); end

  def document_root_element; end
  def nest_selection(selection); end
  def nodeset(node); end
end

module Rails::Dom::Testing::Assertions::SelectorAssertions::CountDescribable
  extend ::ActiveSupport::Concern

  private

  def count_description(min, max, count); end
  def pluralize_element(quantity); end
end

class SubstitutionContext
  def initialize; end

  def match(matches, attribute, matcher); end
  def substitute!(selector, values, format_for_presentation = T.unsafe(nil)); end

  private

  def matcher_for(value, format_for_presentation); end
  def substitutable?(value); end
end
