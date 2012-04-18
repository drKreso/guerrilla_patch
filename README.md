Guerrilla Patch
================

I am tired of hunting and tracking down my own monkey patches. Not to mention hassle of dragging them between projects. I figured gem is a remedy for this.

Short oneliners method definition
--------------------------------
Support for defining one liners with more succinct syntax (let, let_self)

```
def right?
  @right ? "YES" : "NO"
end
```

Instead of ugly

```
def right?() @right ? "YES" : "NO" end
```

Becomes beautiful

```
let(:right?) { @right ? "YES" : "NO" }
```

The only sweet spot for this that I could find are really simple and short methods.

Complex string expressions concatenation
-----------------------------------------

Support for combining complex string expressions (not for the performance, but for the looks)

```
def mark
  year_of_manufacture <<
  city.blank? '' : city.address <<
  person.blank? '' : person.name[2..4]
end
```

You can write like this

```
def mark
  consists_of do |r|
    r.add year_of_manufacture
    r.when_present(city) { |c| c.address }
    r.when_present(person) { |p| p.name[2..4] }
  end
end
```

Somehow for my convoluted brain the later reads better.

BigDecimal
-----------
Not using BigDecimal is asking for trouble, but using it is way too verbose:

```
amount = BigDecimal.new("100.10210")/BigDecimal.new(200.12)
```

It is more succint to put it like this:

```
amount = 100.10210.to_d/200.12
```

Allocate
---------
I belive allocate is missing from standard library. (At least I am unable to find it)

```
90.allocate_evenly(3) #=> [30, 30, 30]
100.allocate_evenly(3) #=> [33.33, 33.33, 33.34]

100.allocate([1.to_d/2, 1/to_d/2]) #=> [50, 50]
100.allocate([30, 30, 30]) #=> [33.33, 33.33, 33.34]
```


Contributing to guerrilla_patch
-------------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
----------

Copyright (c) 2012 drKreso. See LICENSE.txt for
further details.

