## artapp Project #

### Project Summary
I’m practicing TDD while working on building a tool to facilitate connections between art galleries, patrons, and artists. It has a long way to go before it aligns with my vision for the project, but I’m enjoying carefully working through one piece of it at a time and refactoring as I find opportunities to do so.

### Project Highlights
* user authentication and sessions: built without the use of a third-party gem
* custom authorization: multiple roles and a flexible rule structure
* password reset: reset token is sent via email to allow user to change password
* Resque: sends password reset emails 
* spaces: pages for featuring artists and galleries on the site
* import spaces: super-admin can add spaces via csv import
* user account page: access to edit owned spaces
* space profile management: space owners can edit information
* image uploading and resizing: images uploaded to spaces are saved in multiple sizes
* subscriptions and Stripe: gallery owners can upgrade to a pro subscription and pay through Stripe
* Stripe webhooks: a failed charge changes the subscription to 'payment error'

#### Planned enhancements:
Enhanced subscription management, test removing json parse from webhook controller (verify how Rails handles the incoming request data), additional functionlity for pro subscribers, responsive front-end navigation and design, adjust display based on user's edit/view permissions, handle additional Stripe webhook events, enhance security of user session storage, improve testing performance, store uploaded images on S3, move secret token to environment variables file, and much more.

#### Additional features planned:
Users can request ownership/edit rights of a gallery space, artists can create spaces, users can request updates to unowned spaces, spaces can integrate their social media presence, site showcases featured galleries/artists/events, galleries can feature artists, users can browse or search spaces, spaces can create events, users can bookmark spaces and events, users can generate and share art walks, admin can add community events, and much more.


## Setup info:

### Environment
* cp config/application.example.yml config/application.yml
* edit config/application.yml with appropriate credentials


### Image Management
mini_magick is required for image resizing in this application. RMagick requires Imagemagick. On OS X, try "brew install imagemagick". On Linux, try "sudo apt-get install imagemagick"

Setup mailing in config/environments files for both production and development. Equivalent line in test.rb is:
config.action_mailer.default_url_options = { :host => 'www.example.com' }


### Redis & Resque
Redis setup: http://redis.io/download


### Capybara-Webkit
* May need to get qt working.
* Ubuntu: sudo apt-get install libqt4-dev
* Reference: https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit


### Stripe
* Setup API keys
* Setup subscription plans