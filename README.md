# bunch [![Code Climate](https://codeclimate.com/repos/54031e06e30ba06e940095e2/badges/543991ade3cec0100898/gpa.svg)](https://codeclimate.com/repos/54031e06e30ba06e940095e2/feed) [![Test Coverage](https://codeclimate.com/repos/54031e06e30ba06e940095e2/badges/543991ade3cec0100898/coverage.svg)](https://codeclimate.com/repos/54031e06e30ba06e940095e2/feed) 
## [http://bunch-ldn.herokuapp.com/](http://bunch-ldn.herokuapp.com/) [http://bunch-sf.herokuapp.com/](http://bunch-sf.herokuapp.com/)
[http://bunch-nyc.herokuapp.com/](http://bunch-nyc.herokuapp.com/)

###What is Bunch?

**Bunch** takes the arguments out of organising a meetup with friends. Just tell it where you're coming from and **Bunch** will find the best bars, cafes and restaurants in a central location that suits the whole group.

---

###Screenshots

![Bunch Home](/app/assets/images/screenshots/bunch-home.png?raw=true "Bunch main page")

![Bunch Map](/app/assets/images/screenshots/bunch-map.png?raw=true "Bunch map results")

---

###Development

**Bunch** was built in less than two weeks as part of the 12-week [Makers Academy] coding curriculum.

#### Meet the team:
  + [Charlotte Kelly](https://github.com/cmew3)
  + [David Bayon](https://github.com/bayonnaise)
  + [Jenny Wang](https://github.com/thejennywang)
  + [Jeremy Fox](https://github.com/foxjerem)
  + [Peter McCarthy](https://github.com/petermccarthy49)

####Technologies
Combining front-end mapping and back-end algorithm work, **Bunch** gave us the opportunity to use all the tools we'd learned in the previous 10 weeks at Makers Academy.

**Platform:** Ruby on Rails with a PostgresQL ActiveRecord database and a Thin web server

**Coding tools:** Ruby, JavaScript, JQuery, JBuilder, HTML5, CSS3, Mustache, Twitter Bootstrap

**Testing tools:** Rspec, Jasmine, Cucumber, Capybara

####APIs
**Bunch** uses [gmaps.js] to geocode addresses and display maps, the [Google Maps Distance Matrix API] for journey times, and [Foursquare] to find and display points of interest.

During the research phase we also investigated various [Google Maps APIs], [TfL], [TransportAPI], [Mapnificent], [Mapumental] and [Yelp].

####Agile
**Bunch** was managed, designed and built using agile methodologies.
- Before any code was written, we sketched out the full roadmap using Trello and Google docs.
- We determined our MVP and prioritised tasks to achieve it within the first three days.
- We held standups at the beginning and end of every day to discuss issues and adjust the roadmap.
- We pair-programmed at all times, with the team's odd number allowing for a trio or a roving member as required. Pairs were changed regularly to maximise code understanding.
- We used Github for version control, using multiple branches and merging regularly to minimise conflicts.
- We ended every day with a short refactoring session to keep the code clean.

####Next steps
With further development time we would add the following features to **Bunch**:
- Implement our own database of public transport journey times, to be able to calculate midpoints for multiple addresses without maxing out API rate limits.
- Add user accounts, with the ability to save friends' addresses, phone numbers and emails.
- Incorporate Foursquare check-in data to better filter venue results for each user.
- Extend coverage to other cities in the UK and beyond.

---

####How to run tests

```shell
git clone https://github.com/thejennywang/bunch.git
cd bunch
rspec
cucumber
open spec/jasmine/specrunner.html
```

[Makers Academy]:http://www.makersacademy.com/
[Google Maps Distance Matrix API]:https://developers.google.com/maps/documentation/distancematrix/
[gmaps.js]:http://hpneo.github.io/gmaps/
[Foursquare]:https://developer.foursquare.com/
[Google Maps APIs]:https://developers.google.com/maps/
[TfL]:https://www.tfl.gov.uk/info-for/open-data-users/
[TransportAPI]:http://transportapi.com/
[Mapnificent]:http://www.mapnificent.net/
[Mapumental]:https://mapumental.com/
[Yelp]:http://www.yelp.com/developers/documentation
