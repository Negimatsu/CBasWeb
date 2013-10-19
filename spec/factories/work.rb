# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :work do
    id 1
    title "test CBAS"
    description "This test"
    filename "file"
    finish_date DateTime.now + 1
    status_work "processing"
    is_bacteria true
    upload_date DateTime.now
    pid "1234"
  end
end
