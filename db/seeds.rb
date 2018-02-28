USER_NUMBER = 10

GODS = %w[Aion Aether Ananke Chaos Chronos Erebus Eros Hypnos Nesoi Uranus Gaia Ourea Phanes Pontus Tartarus Thalassa Thanatos Hemera Nyx Nemesis Coeus Crius Cronus Hyperion Iapetus Mnemosyne Oceanus Phoebe Rhea Tethys Theia Themis Asteria Astraeus Atlas Aura Clymene Dione Helios Selene Eos Epimetheus Eurybia Eurynome Lelantos Leto Menoetius Metis Ophion Pallas Perses Prometheus Styx Abderus Achilles Aeneas Ajax Amphitryon Antilochus Bellerophon Castor Chrysippus Daedalus Diomedes Eleusis Eunostus Ganymede Hector Hercules Icarus Iolaus Jason Meleager Odysseus Orpheus Pandion Perseus Theseus Alcestis Amymone Andromache Andromeda Antigone Arachne Ariadne Atalanta Briseis Caeneus Cassandra Cassiopeia Clytemnestra Danaë Deianeira Electra Europa Hecuba Helen Hermione Iphigenia Ismene Jocasta Medea Medusa Niobe Pandora Penelope Phaedra Polyxena Semele Thrace].shuffle
TYPES = %w[God Primordial Titan Hero]

def seed_user(number)
  number.times do
    type = TYPES.sample
    name = GODS.pop
    email = name.delete(" ") + "@" + Faker::Internet.domain_name
    location = Faker::Address.city + ", " + Faker::Address.country
    intro = Faker::Overwatch.quote + "."

    user = User.new(name: name,
                    email: email,
                    password: "testing",
                    password_confirmation: "testing")
    user.save!

    user.profile.update_attributes(age: rand(2000..3000),
                                   location: location,
                                   intro: intro,
                                   kind: type.to_s.capitalize)
    user.profile.save!

    10.times { seed_posts(user) }
  end
end

def seed_friendships(number)
  number.times do
    # RANDOM() specific to postgres
    users = User.limit(2).order("RANDOM()")
    return if users.first == users.last
    users.first.friends << users.last
  end
end

def seed_posts(user)
  body = Faker::HitchhikersGuideToTheGalaxy.quote
  user.posts.create!(body: body)
end

def seed_comments(max)
  Post.all.each do |post|
    rand(0..max).times do
      body = Faker::HitchhikersGuideToTheGalaxy.quote
      user = User.order("RANDOM()").first

      post.comments.create!(user: user, body: body)
    end
  end
end

def seed_reactions(max)
  reaction_list = %w[bless smite]
  Post.all.each do |post|
    rand(0..max).times do
      post.reactions.create(user_id: rand(1..USER_NUMBER),
                            name: reaction_list.sample)
    end
  end

  Comment.all.each do |comment|
    rand(0..max).times do
      comment.reactions.create(user_id: rand(1..USER_NUMBER),
                               name: reaction_list.sample)
    end
  end
end

def create_admin
  admin = User.create!(name: "Brock McElroy",
                       email: "brxck@example.com",
                       password: "testtest",
                       password_confirmation: "testtest")
  admin.profile.update_attributes(age: 23,
                                  location: "Tucson, AZ",
                                  intro: "Odinbooks's Tom.",
                                  kind: "Prime Mover")

  User.all.each do |user|
    case rand(1..5)
    when 1
      user.friend_requests.create(friend_id: admin.id)
    when 2
      next
    else
      admin.friends << user unless user == admin
    end
  end

  2.times { seed_posts(admin) }
end

seed_user(USER_NUMBER)
create_admin
seed_friendships(USER_NUMBER * 4)
seed_comments(3)
seed_reactions(10)
