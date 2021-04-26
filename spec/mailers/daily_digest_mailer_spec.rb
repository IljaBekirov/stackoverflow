require 'rails_helper'

RSpec.describe DailyDigestMailer, type: :mailer do
  describe 'digest' do
    let(:user) { create(:user) }
    let(:mail) { DailyDigestMailer.digest(user) }
    let(:questions_yesterday) { create_list(:question, 2, :created_at_yesterday) }
    let(:questions_more_yesterday) { create_list(:question, 2, :created_at_more_yesterday) }

    it 'renders the headers' do
      expect(mail.subject).to eq('DailyDigest from Stackoverflow')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it "renders only yesterday's questions" do
      questions_yesterday.each { |question| expect(mail.body.encoded).to match question.title }
    end

    it "not renders more yesterday's questions" do
      questions_more_yesterday.each { |question| expect(mail.body.encoded).to_not match question.title }
    end
  end
end
