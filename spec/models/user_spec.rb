require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーの作成' do
    it 'name,email,passwordとpassword_confirmationが存在すれば登録できること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'nameがない場合は登録できないこと' do
      user = build(:user, name: nil)
      expect(user).to_not be_valid
    end

    it 'emailがない場合は登録できないこと' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it '重複したemailが存在する場合は登録できないこと' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).to_not be_valid
    end

    it 'passwordがない場合は登録できないこと' do
      user = build(:user, password: nil)
      expect(user).to_not be_valid
    end

    it 'passwordが6文字以上であれば登録できること' do
      user = build(:user, password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      user = build(:user, password: 'pass', password_confirmation: 'pass')
      expect(user).to_not be_valid
    end
  end
end
