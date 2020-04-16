# Search repositories across Github

## Quick start

```
bin/rails s
```

## Running specs

```
bin/rspec spec
```

## TODOs / Trade-offs

* If you use authenticated requests with Octokit you get a higher rate limit. But I've added caching, so it helps a bit.
* Use some gem for service objects, like `interactor` (but it's not really needed for just one service)
* Use twitter-bootstrap gem instead of url to boostrap CDN (again, not really needed for such simple UI)
* CI like travis

