# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Company.delete_all
Company.create([
                 { name: 'MoGo', location: 'New York' },
                 { name: 'Wirkkle', location: 'London' },
                 { name: 'Artesis', location: 'Saint-Petersburg' },
                 { name: 'BuildEmpire', location: 'London' },
               ])

Job.delete_all
Job.create([
             { name: 'Sinatra React', place: 'Remote', company_id: 1 },
             { name: 'Ruby React', place: 'Contract', company_id: 2 },
             { name: 'React', place: 'Remote', company_id: 3 },
             { name: 'Node React', place: 'Permanent', company_id: 1 },
             { name: 'Ruby on Rails', place: 'Remote', company_id: 4 },
             { name: 'Node', place: 'Permanent', company_id: 4 },
             { name: 'Javascript CSS HTML', place: 'Permanent', company_id: 4 },
           ])

Geek.delete_all
Geek.create([
              { name: "Mike", stack: "Sinatra React", resume: true },
              { name: "Alex", stack: "Ruby React", resume: true },
              { name: "Martha", stack: "Rails", resume: false },
              { name: "Juri", stack: "Java", resume: true },
              { name: "Andrew", stack: "PHP", resume: false },
              { name: "Nina", stack: "Node", resume: true },
              { name: "Bob", stack: "Front end", resume: true },
              { name: "Kate", stack: "PHP", resume: false },
              { name: "Boris", stack: "Full stack", resume: true },
            ])

Apply.delete_all
Apply.create([
               { job_id: 1, geek_id: 1, read: true, invited: true },
               { job_id: 1, geek_id: 2, read: false, invited: false },
               { job_id: 5, geek_id: 5, read: true, invited: false },
               { job_id: 6, geek_id: 8, read: false, invited: false },
             ])
