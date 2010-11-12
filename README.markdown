swimdb
======

Just messing around with rails 3, mongomapper, devise and BDD(rspec, cucumber)

Newest changes
--------------

- cached comments_count
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
- twitter-facebook login/Signup
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

- had to put the comments_count into the comments controller because of the callbacks

TODO
----

- search in general
- caching - memcache? bin? ... how to set it up on the server?

meh
---

Tested with rspec and cucumber under ree-1.8.7

