require 'rubygems'
require 'twitter'
require 'eventmachine'
require 'pp'

user = "banux_hartest"
passwd = "toto42"

last_id = 0

httpauth = Twitter::HTTPAuth.new(user, passwd)
base = Twitter::Base.new(httpauth)

EM.run do
   EM.add_periodic_timer(60) do
    if last_id == 0
      res = Twitter::Search.new('#har2009').fetch().results
    else
      res = Twitter::Search.new('#har2009').since(last_id).fetch().results    
    end
    if (res.size > 0)
    last_id = res.first.id    
    res.each do |t|
      if(t.from_user != user)
          base.update("RT @" + t.from_user + " " + t.text)       
      end 
    end
  end
  end
end
