Simple Automation for GoPuff

Assumptions:
1. This was tested on OS X so it should run on linux variant too
2. You have a go puff account, you will have to sign in multipe times
3. This is time boxed by the local provided (in Provo, Utah it was between 10am and ...not sure how late)

Tests:  
cart_spec - adds the first soda to the cart, got to the cart, delete that soda  
search_spec - look for Whoopers, there are none in Provo (That may be different somwhere else), then look for a Milky Way, which is found  

5. `bundle install`
6. `rspec cart_spec.rb`
7. `rspec search_spec.rb`
