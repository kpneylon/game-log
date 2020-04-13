class Game < ActiveRecord::Base
    belongs_to :user
    attr_accessor :title, :system
end