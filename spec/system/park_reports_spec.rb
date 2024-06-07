require 'rails_helper'

RSpec.describe 'ParkReports', type: :system do
  let(:user) { create(:user) }
  let!(:tokyo_ward) { create(:tokyo_ward, name: '新宿区') }
  let!(:park) { create(:park, tokyo_wards: [tokyo_ward]) }

  describe '公園日記の作成' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました。'
      expect(current_path).to eq mypage_path
    end

    context 'フォームの入力が正しいとき' do
      it '全ての項目を埋めているとき投稿できる' do
        visit new_park_report_path
        fill_in 'park_report_park_name', with: park.name
        select tokyo_ward.name, from: 'park_report_tokyo_ward_id'
        fill_in 'park_report_title', with: '日記のタイトル'
        fill_in 'park_report_comment', with: '公園のコメント'
        click_button '投稿する'
        expect(page).to have_content '投稿が完了しました!!'
        expect(current_path).to eq park_path(park)
      end

      it 'データベースにある公園が入力されたとき、区の選択がなくても投稿できる' do
        visit new_park_report_path
        fill_in 'park_report_park_name', with: park.name
        select '区を選択', from: 'park_report_tokyo_ward_id'
        fill_in 'park_report_title', with: '日記のタイトル'
        fill_in 'park_report_comment', with: '公園のコメント'
        click_button '投稿する'
        expect(page).to have_content '投稿が完了しました!!'
        expect(current_path).to eq park_path(park)
      end
    end

    context 'フォームの入力に不備があるとき' do
      it '公園名と区が空の時、公園日記を作成できないこと' do
        visit new_park_report_path
        fill_in 'park_report_park_name', with: nil
        select '区を選択', from: 'park_report_tokyo_ward_id'
        fill_in 'park_report_title', with: '日記のタイトル'
        fill_in 'park_report_comment', with: '公園のコメント'
        click_button '投稿する'
        expect(page).to have_content '区を選択してください'
      end

      it 'データベースにない公園を入力した時に区の選択がないと公園日記を作成できない' do
        visit new_park_report_path
        fill_in 'park_report_park_name', with: 'データにない公園'
        select '区を選択', from: 'park_report_tokyo_ward_id'
        fill_in 'park_report_title', with: '日記のタイトル'
        fill_in 'park_report_comment', with: '公園のコメント'
        click_button '投稿する'
        expect(page).to have_content '区を選択してください'
      end

      it '公園名が未入力の時、公園日記を作成できない' do
        visit new_park_report_path
        fill_in 'park_report_park_name', with: nil
        select tokyo_ward.name, from: 'park_report_tokyo_ward_id'
        fill_in 'park_report_title', with: '日記のタイトル'
        fill_in 'park_report_comment', with: '公園のコメント'
        click_button '投稿する'
        expect(page).to have_content '公園の名前を入力してください'
      end

      it 'タイトルが未入力の時、公園日記を作成できない' do
        visit new_park_report_path
        fill_in 'park_report_park_name', with: park.name
        select '区を選択', from: 'park_report_tokyo_ward_id'
        fill_in 'park_report_title', with: nil
        fill_in 'park_report_comment', with: '公園のコメント'
        click_button '投稿する'
        expect(page).to have_content '公園をひとことで!!を入力してください'
      end
    end
  end
end
