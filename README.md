# On-Site.com PRN challenge

The PEN calculator is implemented in following technologies

  - Ruby On Rails ( command line style web app)
  - Ruby (command line app)
  - Python(command line)
  
Each implementation is tested with unit testing packages. (Tests are added)

### DEMO
A web based(Ruby On Rails) demo is avilable at https://limitless-ocean-14953.herokuapp.com/

### Ruby On Rails implementation
* The implementation uses Rails 4.
* Active record is not used. Instead Redis key value store is used(which is also persistant). The redis store gives inbuilt support to data structures like set, hash, list etc, which made the calculator model to use stack as a persistant data storage. Also, Redis is an in memory data store. So that the speed of data access is high.
* To run this app on local machine make sure redis server is running as per config at ```config/inintilizers/redis.rb```
* For terminal syled UI, Jquery Terminal Emulator(http://terminal.jcubic.pl/) is used.
* The code is at on_rails.calculator_app folder. A demo is avilable at https://limitless-ocean-14953.herokuapp.com/

