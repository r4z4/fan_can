# FanCan

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Fan Can

Subscriptions occur in HomeLive Module. This is after the user has logged in and arrives at the Home Page.

To run concuerror Concurrency tests, need to run via the concuerror_test.sh script in root directory with
the name of the test module that you wish to test. Report will be generated also in root dir.

```console
./concuerror_test FanCan.ConcurrencyTest
```