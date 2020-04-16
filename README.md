# Bank

Elixir Bank is an example Bank Application built for learning purposes.

## How It Works

### How to run it on your local machine

You can then run it using mix:

```shell
$ mix ecto.create
$ mix ecto.migrate
$ mix phx.server
```

To run tests, run:

```shell
$ mix test
$ mix credo
$ mix dialyzer --halt-exit-status
```

### Contributing

Getting started for contributors

Sending your change to us
-------------------------

The best way to send changes to Elixir Bank is to fork our repo, then open a pull request.
GitHub has a [howto for the fork-pull system] on their own website.

[howto for the fork-pull system]: https://help.github.com/articles/fork-a-repo/

BTW, the [hub] CLI is really cool.
With it,
you can make a pull request that modifies this file by running these commands:

    $ hub clone phsacramento/elixir-bank
    $ cd elixir-bank
    $ hub fork
    $ git checkout -b fix_readme
    $ vim CONTRIBUTING.md
    $ git commit CONTRIBUTING.md
    $ git push -u <YOUR GITHUB USERNAME> HEAD
    $ hub pull-request


### Author

Paulo Henrique Sacramento (@phsacramento)
