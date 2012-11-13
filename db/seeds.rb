# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Entry.create(community_name: "The Doors",
             hometown: "Los Angeles",
             genre: "Rock",
             youtube_url: "http://www.youtube.com/watch?v=6O6x_m4zvFs",
             song_title: "Light My Fire",
             bio: %Q{The Doors were an American rock band formed in 1965 in Los Angeles, California, with vocalist Jim Morrison, keyboardist Ray Manzarek, drummer John Densmore and guitarist Robby Krieger. The band took its name from Aldous Huxley's book The Doors of Perception, the title of which was a reference to a William Blake quotation: "If the doors of perception were cleansed every thing would appear to man as it is, infinite."})

Entry.create(community_name: "Eminem",
             hometown: "Detroit",
             genre: "Hip Hop",
             youtube_url: "http://www.youtube.com/watch?v=j5-yKhDd64s",
             song_title: "Not Afraid",
             bio: %Q{Marshall Bruce Mathers III (born October 17, 1972), better known by his stage name Eminem and by his alter ego Slim Shady, is an American rapper, record producer, songwriter and actor.})

Entry.create(community_name: "Aretha Franklin",
             hometown: "Detroit",
             genre: "R&B",
             youtube_url: "http://www.youtube.com/watch?v=STKkWj2WpWM",
             song_title: "I Say a Little Prayer",
             bio: %Q{Aretha Louise Franklin (born March 25, 1942) is an American musician, singer, songwriter, and pianist. In a recording career that has spanned over half a century, Franklin's repertoire has included gospel, jazz, blues, R&B, pop, rock and funk.})
