Meowifier
=========

# Coding Standards

We're going to try to stick to this:

0. You should break these rules only if you have a good reason or your pair lets you.
1. Classes can be no longer than one hundred lines of code.
2. Methods can be no longer than five lines of code.
3. Pass no more than four parameters into a method. Hash options are parameters.
4. Controllers can instantiate only one object. Therefore, views can only know about one instance variable and views should only send messages to that object (`@object.collaborator.value` is not allowed).
5. Avoid non-resource routes (So avoid `member`, `collection`, and one-off routes like `get "blah" => 'foo#bar'`).
6. Avoid non-resource methods (aka ‘actions’) in controllers (So controller actions should only ever be index, show, new, create, edit, update, destroy).