User.create(email: "test@fanhelp.us",
            password: "password",
            confirmed_at: Date.today,
            username: "tester",
            hometown: "Detroit",
            admin: true,
            tos: true)

User.create(email: "phyl@fanhelp.us",
            password: "password",
            confirmed_at: Date.today,
            username: "phyl",
            hometown: "Detroit",
            admin: true,
            tos: true)

morrison = User.create(email: "jim@morrison.com",
                       password: "password",
                       confirmed_at: Date.today,
                       username: "JimMorrison",
                       hometown: "Melbourne",
                       musician: true,
                       tos: true)

eminem = User.create(email: "slim@slimshady.com",
                     password: "password",
                     confirmed_at: Date.today,
                     username: "SlimShady",
                     hometown: "Detroit",
                     musician: true,
                     tos: true)

aretha = User.create(email: "aretha@arethafranklin.com",
                     password: "password",
                     confirmed_at: Date.today,
                     username: "Aretha",
                     hometown: "Detroit",
                     musician: true,
                     tos: true)

azealia = User.create(email: "azealia@azealiabanks.com",
                      password: "password",
                      confirmed_at: Date.today,
                      username: "azealia",
                      hometown: "New York",
                      musician: true,
                      tos: true)

cash = User.create(email: "johnny@johnnycash.com",
                   password: "password",
                   confirmed_at: Date.today,
                   username: "jcash",
                   hometown: "Kingsland",
                   musician: true,
                   tos: true)

Entry.create!(user: morrison,
              stage_name: "The Doors",
              hometown: "Los Angeles",
              genre: "Rock",
              youtube_url: "http://www.youtube.com/watch?v=6O6x_m4zvFs",
              title: "Light My Fire",
              profile_photo: File.open("public/images/doors.jpg"),
              bio: %Q{The Doors were an American rock band formed in 1965 in Los Angeles, California, with vocalist Jim Morrison, keyboardist Ray Manzarek, drummer John Densmore and guitarist Robby Krieger. The band took its name from Aldous Huxley's book The Doors of Perception, the title of which was a reference to a William Blake quotation: "If the doors of perception were cleansed every thing would appear to man as it is, infinite."})

Entry.create!(user: eminem,
              stage_name: "Eminem",
              hometown: "Detroit",
              genre: "Hip Hop",
              youtube_url: "http://www.youtube.com/watch?v=j5-yKhDd64s",
              title: "Not Afraid",
              profile_photo: File.open("public/images/eminem.jpg"),
              bio: %Q{Marshall Bruce Mathers III (born October 17, 1972), better known by his stage name Eminem and by his alter ego Slim Shady, is an American rapper, record producer, songwriter and actor.})

Entry.create!(user: aretha,
              stage_name: "Aretha Franklin",
              hometown: "Detroit",
              genre: "R&B",
              youtube_url: "http://www.youtube.com/watch?v=STKkWj2WpWM",
              title: "I Say a Little Prayer",
              profile_photo: File.open("public/images/aretha.jpg"),
              bio: %Q{Aretha Louise Franklin (born March 25, 1942) is an American musician, singer, songwriter, and pianist. In a recording career that has spanned over half a century, Franklin's repertoire has included gospel, jazz, blues, R&B, pop, rock and funk.})

Entry.create!(user: azealia,
              stage_name: "Azealia Banks",
              hometown: "New York",
              genre: "Hip Hop",
              youtube_url: "http://www.youtube.com/watch?v=i3Jv9fNPjgk",
              title: "212",
              profile_photo: File.open("public/images/azealia.jpg"),
              bio: %Q{Azealia Amanda Banks (born May 31, 1991) is an American rapper and singer. Originally from Harlem, New York, Banks at a young age pursued an interest in musical theatre before eventually becoming interested in a career as a recording artist.})

Entry.create!(user: cash,
              stage_name: "Johnny Cash",
              hometown: "Kingsland",
              genre: "Country",
              youtube_url: "http://www.youtube.com/watch?v=k7K4jH7NqUw",
              title: "I Walk the Line",
              profile_photo: File.open("public/images/cash.jpg"),
              bio: %Q{John R. "Johnny" Cash (February 26, 1932 - September 12, 2003), was an American singer-songwriter, actor, and author, who has been called one of the most influential musicians of the 20th century.})