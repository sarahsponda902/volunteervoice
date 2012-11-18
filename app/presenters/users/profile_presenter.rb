class Users::ProfilePresenter
  def initialize
    @user = current_user
  end

  def user_ids 
    User.all.map(&:id)
  end
  
  def reviews 
    @user.reviews.sort_by(&:created_at).reverse
  end
  
  def favorites
    @user.favorites.sort_by(&:created_at).reverse
  end
  
  def messages
    Message.where(:recipient_id => current_user.id, :recipient_deleted => false).sort_by(&:created_at).reverse
  end

  def sent_messages
    Message.where(:sender_id => current_user.id, :sender_deleted => false).sort_by(&:created_at).reverse
  end
  
end