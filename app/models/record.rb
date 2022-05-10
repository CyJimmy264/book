class Record < ApplicationRecord
  class Content
    def self.load(content)
      Content.new(content)
    end

    def initialize(content)
      @yaml = YAML.load(content)
      @text = content
    end

    def date
      @yaml['дата']
    end

    def to_s
      @text
    end
    alias to_str to_s
  end

  belongs_to :author, class_name: 'User'

  def content
    @content ||= Content.load(super)
  end

  before_save do
    self.created_at ||= Time.now
  end

  protected

  def timestamp_attributes_for_create
    [:updated_at]
  end
end
