FactoryBot.define do
  factory :booking do
    user
    library
    package {"1500"}
    payment_method {"Online"}
    start_date {Time.now}
    end_date {Time.now + 90.days}
    subscription_length {"quaterly"}
    razorpay_payment_id {"pay_Dsvfgdbgdfgbhgfhn"}
    plan_id {"plan_Dfdfgdbzbhm"}
    payment_status {"paid"}
  end
end
