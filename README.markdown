swimdb
======

Just messing around with rails 3, mongoid, devise and BDD(rspec, cucumber)

Newest changes
--------------

- validation errors now have a red border, just had to add the sass snippet, even works with items
- replaced mongomapper for mongoid
- Passanger in development?!?
- more style
- now you can create a info item when add a leading '=>' to the text

Features until now
------------------

- creating and editing a schedule with nested items in one form
- calculate the complete distance of the schedule
- tag a schedule
- search/filter by tag
- comments, now also via js
- authentication(devise)
- twitter-facebook login/signup
- Admin Area
- jquery
- js calendar, new tagcloud
- compass; sass
- created a working capistrano script, but yeah I wont upload it here



Known Issues
------------

- not really an issue but I not really know how that mapreduce snippet works ;)
- when a failure while the comment creation happens it does just nothing(with JS)


to think about
--------------

- because of the way mongoid is doing thing the schedules update method is now very cutomized
- had to put the comments_count into the comments controller because of the callbacks

TODO
----

- search in general
- caching - memcache? bin? ... how to set it up on the server?

meh
---

- Ruby 1.9.2
- Rails 3.0.3
- RSpec
- Cucumber

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">swimdb</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/sch1zo/swimdb" rel="dct:source">github.com</a>.

Eger Andreas 2010

