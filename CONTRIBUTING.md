Getting started for contributors
================================

Thanks for wanting to help out with Elixir Bank!

Answering support questions
---------------------------

If you've been using Elixir Bank a lot,
you can help other people use it by answering questions on the Issues Sections.

Submitting bug reports
----------------------

Go ahead and submit an issue report;
we can't fix a problem if we don't know about it.
Even if you're not sure if it's a bug,
go ahead and submit it.
If a lot of users think it's a problem,
even if we don't think it's "really a bug,"
we'll probably try to figure out a way to fix it anyway.
Elixir Bank needs to be useful, not just correct.
Besides, that's why we call them "issue reports" instead of "bug reports."

If you get the chance,
please use the search bar at the top of the issues list to see if somebody else already reported it.
You don't have to do that,
if you don't have time,
or just can't think of what to search for.
Think of it as extra credit.
If we find a duplicate,
we'll just leave a comment saying "Duplicate of #some-other-issue-number"
(so that you know where the existing conversation is happening)
and close it.

Filing an issue is as easy as going to the [new issue page] and filling out the fields.

[new issue page]: https://github.com/phsacramento/elixir-bank/issues/new

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

You don't have to use anything like that if you don't want to,
though.

[hub]: https://hub.github.com/

Proposing and adding new features
---------------------------------

If you'd like to add a new feature, or make big changes to the way elixir bank works,
open a issue and place a tag `improvement proposal` and submit with an pull request of that new awesome feature.


### Entry-level issues

If you want to get started hacking on Elixir Bank, these are the issues to pick up. Whoever filed it knows how to fix it (they might've even already done it), and is willing to guide someone else through it. If you're working on it, and have a question, ask please. We want to help.

* [Easy]: Good first bugs. The filer should already know how to fix it; they may even have already fixed it in a private branch. Whichever it is, the point of working on a bug like this is to learn how to edit, deploy, and test an instance of Elixir Bank, and to file the pull request, get it reviewed, and merged. E-easy issues should be things that actually need done, but nothing is too easy for E-easy.
* [Medium]: This tag exists to provide a gradual path from "fixing typos and minor appearance glitches" to "taking an active role in the ongoing development in Elixir Bank." E-medium changes should be "good second bugs," meaning they require the contributor to learn how stuff works under the hood. As before, the filer should know how to fix it.
* [Hard]: The filer should have an idea about how it should be fixed, but an E-hard issue should require the contributor to know how Elixir Bank works.

### Language

The primary programming language this will need to be implemented in. If none is specified, it's Elixir.

### Pull request status

This is the only type of tag that is added to pull requests.

* S-do-not-merge-yet: Do not merge this pull request.
