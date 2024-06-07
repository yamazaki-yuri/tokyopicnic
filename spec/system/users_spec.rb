require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe 'ユーザーの登録' do
    it '有効な情報でユーザーを登録できること' do
      visit new_user_registration_path
      fill_in 'user_name', with: 'テストユーザー'
      fill_in 'user_email', with: 'picnic@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button '登録'

      expect(page).to have_content 'アカウント登録が完了しました。'
      expect(current_path).to eq mypage_path
    end

    context 'フォームの入力値が有効でない' do
      it '名前が未入力の時登録できない' do
        visit new_user_registration_path
        fill_in 'user_name', with: nil
        fill_in 'user_email', with: 'picnic@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button '登録'

        expect(page).to have_content '名前を入力してください'
      end

      it 'メールが未入力の時登録できない' do
        visit new_user_registration_path
        fill_in 'user_name', with: 'テストユーザー'
        fill_in 'user_email', with: nil
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button '登録'

        expect(page).to have_content 'メールを入力してください'
      end

      it '登録済みのメールが入力された時登録できない' do
        visit new_user_registration_path
        fill_in 'user_name', with: 'テストユーザー'
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button '登録'

        expect(page).to have_content 'メールはすでに存在します'
      end

      it 'パスワードが未入力の時登録できない' do
        visit new_user_registration_path
        fill_in 'user_name', with: 'テストユーザー'
        fill_in 'user_email', with: 'picnic@example.com'
        fill_in 'user_password', with: nil
        fill_in 'user_password_confirmation', with: 'password'
        click_button '登録'

        expect(page).to have_content 'パスワードを入力してください'
      end

      it 'パスワードが5文字以下の時登録できない' do
        visit new_user_registration_path
        fill_in 'user_name', with: 'テストユーザー'
        fill_in 'user_email', with: 'picnic@example.com'
        fill_in 'user_password', with: 'pass'
        fill_in 'user_password_confirmation', with: 'pass'
        click_button '登録'

        expect(page).to have_content 'パスワードは6文字以上で入力してください'
      end
    end
  end
end