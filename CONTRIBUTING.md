# Contributing

Envie suas alterações
-------------------------

A melhor maneira de enviar alterações para o Elixir Bank é fazer um fork do nosso repo e abrir um Pull Request.
GitHub possui um guia [como enviar um fork pull request] no próprio website.

[como enviar um fork pull request]: https://help.github.com/articles/fork-a-repo/

Você pode utilizar o CLI [hub](https://hub.github.com/) para fazer isso.
Da seguinte forma,
Você pode enviar o pull request do seu fork com os seguintes comandos:

    $ hub clone phsacramento/elixir-bank
    $ cd elixir-bank
    $ hub fork
    $ git checkout -b fix_readme
    $ vim CONTRIBUTING.md
    $ git commit CONTRIBUTING.md
    $ git push -u <YOUR GITHUB USERNAME> HEAD
    $ hub pull-request
