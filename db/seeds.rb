# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = User.create(:email => 'mike@madgik.gr', :password => 'foobar23', :password_confirmation => 'foobar23', :approved => true, :admin => true)
user = User.create(:email => 'scottie@madgik.gr', :password => 'foobar33', :password_confirmation => 'foobar33', :approved => false)

form = Form.create(title: 'Οφθαλμολογικό Τεστ', user_id: admin.id)
question1 = Question.create(category: 'multiple', description: 'Φύλο', form_id: form.id)
choice1 = Choice.create(content: 'Άρρεν', question_id: question1.id)
choice2 = Choice.create(content: 'Θήλυ', question_id: question1.id)
question2 = Question.create(category: 'number', description: 'Ηλικία', form_id: form.id)
question3 = Question.create(category: 'text', description: 'Παρατηρήσεις', form_id: form.id)
question4 = Question.create(category: 'multiple', description: 'Γυαλιά', form_id: form.id)
choice3 = Choice.create(content: 'Όχι', question_id: question4.id)
choice4 = Choice.create(content: 'Ναι', question_id: question4.id)
question5 = Question.create(category: 'text', description: 'Αγωγή', form_id: form.id)


File.open(File.join(Rails.root, 'db', 'eye.csv')) do |lines|
  lines.read.each_line do |line|
    q1, q2, q3, q4, q5 = line.chomp.split('\t')
    filling = Filling.create(form_id: form.id)
    content = q5.nil? ? 'Όχι' : q5
    answer5 = Answer.create(filling_id: filling.id, category: question5.category, content: content, question_id: question5.id)
    answer4 = Answer.create(filling_id: filling.id, category: question4.category, question_id: question4.id)
    choice = q4.nil? ? choice3.id : choice4.id
    pick2 = Pick.create(answer_id: answer4.id, choice_id: choice)
    content = q3.nil? ? 'ΟΧΙ' : q3
    answer3 = Answer.create(filling_id: filling.id, category: question3.category, content: content, question_id: question4.id)
    content = q2.nil? ? '0' : q2
    answer2 = Answer.create(filling_id: filling.id, category: question2.category, content: content, question_id: question2.id)
    answer1 = Answer.create(filling_id: filling.id, category: question1.category, question_id: question1.id)
    choice = q1.to_s == 'Α' ? choice1.id : choice2.id
    pick1 = Pick.create(answer_id: answer1.id, choice_id: choice1)
  end
end