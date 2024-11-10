# frozen_string_literal: true

class SocialNetworkService
  def self.authenticate_user(auth)
    existing_account = User::Account.find_by(uid: auth[:uid])
    email = auth[:info][:email].downcase
    user = if existing_account
             existing_account.user
           else
             User.find_or_initialize_by(email: email)
           end

    ActiveRecord::Base.transaction do
      account = user.accounts.find_or_initialize_by(provider: auth[:provider])
      account.uid = auth[:uid]
      account.save!
    end

    user
  end
end
