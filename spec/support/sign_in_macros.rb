# coding: utf-8
module SignInMacros
  def sign_in(user)
    visit new_user_session_path
    fill_in t('activerecord.attributes.user.email'), with: user.email
    fill_in t('activerecord.attributes.user.password'), with: user.password
    click_button 'Log in'
  end
end
