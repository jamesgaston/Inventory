class Message < ActiveRecord::Base
belongs_to :user
validates :sender_id, :presence => true
validates :recipient_id, :presence => true
validates :item_id, :presence => true
validates :message_text, :presence => true
validates :show_email, :inclusion => {:in => [true, false]}
end
