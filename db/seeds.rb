User.create(email: "test@fanhelp.us",
            password: "password",
            confirmed_at: Date.today,
            profile_name: "tester",
            hometown: "Detroit",
            admin: true)

User.create(email: "phyl@fanhelp.us",
            password: "password",
            confirmed_at: Date.today,
            profile_name: "phyl",
            hometown: "Detroit",
            admin: true)

morrison = User.create(email: "jim@morrison.com",
                       password: "password",
                       confirmed_at: Date.today,
                       profile_name: "JimMorrison",
                       hometown: "Melbourne")

eminem = User.create(email: "slim@slimshady.com",
                     password: "password",
                     confirmed_at: Date.today,
                     profile_name: "SlimShady",
                     hometown: "Detroit")

aretha = User.create(email: "aretha@arethafranklin.com",
                     password: "password",
                     confirmed_at: Date.today,
                     profile_name: "Aretha",
                     hometown: "Detroit")

Entry.create!(user: morrison,
              community_name: "The Doors",
              hometown: "Los Angeles",
              genre: "Rock",
              youtube_url: "http://www.youtube.com/watch?v=6O6x_m4zvFs",
              song_title: "Light My Fire",
              bio: %Q{The Doors were an American rock band formed in 1965 in Los Angeles, California, with vocalist Jim Morrison, keyboardist Ray Manzarek, drummer John Densmore and guitarist Robby Krieger. The band took its name from Aldous Huxley's book The Doors of Perception, the title of which was a reference to a William Blake quotation: "If the doors of perception were cleansed every thing would appear to man as it is, infinite."})

Entry.create!(user: eminem,
              community_name: "Eminem",
              hometown: "Detroit",
              genre: "Hip Hop",
              youtube_url: "http://www.youtube.com/watch?v=j5-yKhDd64s",
              song_title: "Not Afraid",
              bio: %Q{Marshall Bruce Mathers III (born October 17, 1972), better known by his stage name Eminem and by his alter ego Slim Shady, is an American rapper, record producer, songwriter and actor.})

Entry.create!(user: aretha,
              community_name: "Aretha Franklin",
              hometown: "Detroit",
              genre: "R&B",
              youtube_url: "http://www.youtube.com/watch?v=STKkWj2WpWM",
              song_title: "I Say a Little Prayer",
              bio: %Q{Aretha Louise Franklin (born March 25, 1942) is an American musician, singer, songwriter, and pianist. In a recording career that has spanned over half a century, Franklin's repertoire has included gospel, jazz, blues, R&B, pop, rock and funk.})