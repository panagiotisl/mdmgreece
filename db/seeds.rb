# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = User.create(:email => 'admin@mdmgreece.gr', :password => 'foobar23', :password_confirmation => 'foobar23', :approved => true, :admin => true)
#user = User.create(:email => 'user1@mdmgreece.gr', :password => 'foobar33', :password_confirmation => 'foobar33', :approved => false)

=begin
form = Form.new
form.title = 'Οφθαλμολογικό Τεστ'
form.user_id = admin.id
#form = Form.create(title: 'Οφθαλμολογικό Τεστ', user_id: admin.id)
question1 = form.questions.build(category: 'multiple', description: 'Φύλο')
choice1 = question1.choices.build(content: 'Άρρεν')
choice2 = question1.choices.build(content: 'Θήλυ')
question2 = form.questions.build(category: 'number', description: 'Ηλικία')
question3 = form.questions.build(category: 'text', description: 'Παρατηρήσεις')
question4 = form.questions.build(category: 'multiple', description: 'Γυαλιά')
choice3 = question4.choices.build(content: 'Όχι')
choice4 = question4.choices.build(content: 'Ναι')
question5 = form.questions.build(category: 'text', description: 'Αγωγή')
form.save


File.open(File.join(Rails.root, 'db', 'eye.csv')) do |lines|
  lines.read.each_line do |line|
    q1, q2, q3, q4, q5 = line.chomp.split("\t")
    filling = Filling.new
    filling.form_id = form.id
    #filling = Filling.create(form_id: form.id)
    content = q5.nil? ? 'ΟΧΙ' : q5
    answer5 = filling.answers.build(category: question5.category, content: content, question_id: question5.id)
    answer4 = filling.answers.build(category: question4.category, question_id: question4.id)
    choice = q4.nil? || q4.empty? ? choice3.id : choice4.id
    pick2 = answer4.picks.build(choice_id: choice)
    content = q3.nil? || q3.empty? ? 'ΟΧΙ' : q3
    answer3 = filling.answers.build(category: question3.category, content: content, question_id: question3.id)
    content = q2.nil? || q2.empty? ? '0' : q2
    answer2 = filling.answers.build(category: question2.category, content: content, question_id: question2.id)
    answer1 = filling.answers.build(category: question1.category, question_id: question1.id)
    choice = q1.to_s == 'Α' ? choice1.id : choice2.id
    pick1 = answer1.picks.build(choice_id: choice)
    filling.save!
  end
end
=end

=begin
form = Form.new
form.title = 'Οδοντιατρικό Τεστ'
form.user_id = admin.id
#form.questions.build(category: 'date', description: 'Ημερομηνία Εξέτασης')
form.questions.build(category: 'text', description: 'Περιοχή-Σχολείο')
form.questions.build(category: 'number', description: 'Ηλικία')
#form.questions.build(category: 'text', description: 'Περιγραφή Εργασίας - Παρατηρήσεις')
question5 = form.questions.build(category: 'denture', description: 'Εξέταση')
question6 = form.questions.build(category: 'multiple', description: 'Έχει επισκεφθεί ποτέ οδοντίατρο;')
question6.choices.build(content: 'Όχι')
question6.choices.build(content: 'Ναι')
form.questions.build(category: 'number', description: 'Εάν ναι, πόσες φορές;')
question8 = form.questions.build(category: 'multiple', description: 'Βρίσκεται υπό οδοντιατρική παρακολούθηση;')
question8.choices.build(content: 'Όχι')
question8.choices.build(content: 'Ναι')
form.save
=end