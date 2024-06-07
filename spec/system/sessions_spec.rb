require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正しく入力されている' do
      it 'ログイン処理が完了する' do
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
        expect(current_path).to eq mypage_path
      end
    end

    context 'フォームの入力値に不備がある' do
      it '登録されていないメールアドレスが入力されるとログインに失敗する' do
        visit new_user_session_path
        fill_in 'user_email', with: 'wine@example.com'
        fill_in 'user_password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'メールまたはパスワードが違います。'
        expect(current_path).to eq new_user_session_path
      end

      it 'メールアドレスが未入力の場合ログインに失敗する' do
        visit new_user_session_path
        fill_in 'user_email', with: nil
        fill_in 'user_password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'メールまたはパスワードが違います。'
        expect(current_path).to eq new_user_session_path
      end

      it 'パスワードが未入力の場合ログインに失敗する' do
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: nil
        click_button 'ログイン'
        expect(page).to have_content 'メールまたはパスワードが違います。'
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe 'ログイン後' do
    it 'ログアウトボタンを押すとログアウトする' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました。'
      expect(current_path).to eq mypage_path
      find('div', text: 'Menu', match: :first).click
      click_link 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
      expect(current_path).to eq root_path
    end
  end
end
