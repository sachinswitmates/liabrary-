FactoryBot.define do
  factory :qrcode do
    code {attachments['code.png'] = File.read("#{Rails.root}/public/#{Qrcode.last.code.url}")}
  end
end
