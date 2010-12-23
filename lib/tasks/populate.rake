namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'
    require 'ap'

    [Schedule, User, Authentication].each(&:delete_all)

    r = Random.new(Time.now.hash)
    item_texts = ['2x5x100m Kraul','2x100m Ruecken','200m Lagen']

    (r.rand(1000..2000)).times do
      #soviele user erstellen
      username  = Faker::Name.name
      email     = Faker::Internet.email
      user = User.create!(:username => username, :email => email, :password => 'generiert', :password_confirmation => 'generiert')
      r.rand(50..200).times do
        #soviele Schedules erstellen
        items = []
        r.rand(5..20).times do
          level = r.rand(0..2)
          case level
          when 0
            text = item_texts[r.rand(0..2)]
          when 1
            text = item_texts[r.rand(1..2)]
          when 2
            text = item_texts[2]
          end
          item = Item.new(:level => level, :text => text)
          unless item.valid?
            ap item.errors.full_messages
          end
          items.push(item)
        end
        Schedule.create!(  :title => Faker::Lorem.sentence(r.rand(1..3)),
                           :description => Faker::Lorem.paragraph(r.rand(3..6)),
                           :taggings => Faker::Lorem.sentence(r.rand(1..7)),
                           :original_date =>r.rand(2.years.ago..Time.now),
                           :user => user,
                           :items => items  )
      end
      ap Schedule.count
    end
    ap "#{User.count} User und "
    ap "#{Schedule.count} Schedules generiert"
  end
end

