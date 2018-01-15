Run kudomonGo.rb to start

# Kudomon GO!
Credit Kudos' Technical Challenge.

## What is this challenge for?
We want to understand the way you think about problems, and how you write code to tackle them. We’re not looking for the most efficient algorithmics, we’re looking for the simplest solution. 

We’re not going to give much in the way of guidance as to the specifics of implementation - if you think a class needs an attribute or a method, you go ahead and do it. You’re in charge.

## How should solutions be presented?
Ideally, solutions will be vanilla `ruby` code with tests. `rails` is optional. If you're more comfortable in another language, feel free to use that!

To submit your response, fork this repo and raise a pull-request containing your answer.

## So, what’s the challenge?
Imagine that all around us, in a virtual world, are virtual creatures (`Kudomon`) that you can catch and collect.

Your task is to write a program that allows a `Trainer` (like you) to interact with these `Kudomon`. The challenge is broken down into **four** parts.

### Part 1
#### Define domain classes to model this application.
There are many different species of `Kudomon`, each having a `type`. Here are some (invented) examples:

- species: `"Sourbulb"`, type: `:grass`
- species: `"Mancharred"`, type: `:fire`
- species: `"Chikapu"`, type: `:electric`

Other `type`s include `:water`, `:rock` and `:psychic`. Feel free to invent your own `species` using these six `type`s!

Both `Trainer`s and `Kudomon` need to have a `Position`, so we can know how close different entities are to each other.

### Part 2
#### Gotta catch ‘em all!
In this part we’ll implement the means for a `Trainer` to catch a `Kudomon` and add it to their collection.

First, we need to know which `Kudomon` are nearby to a `Trainer`. Write code to calculate this. How you define “nearby” is completely up to you.

A `Trainer` can catch nearby `Kudomon` and add them to his/her collection. Write code to allow this.

### Part 3
#### Multi-player
Now we’re going to introduce the idea that multiple `Trainer`s can try and catch `Kudomon` at the same time.

Scenario:
1. I’m sat at my computer and I see a `Kudomon` I want to catch. I try to catch it.
2. At the exact same time, my neighbour Freddy sees the same `Kudomon` and also tries to catch it.
3. Freddy succeeds and adds the `Kudomon` to his collection before I’ve finished catching it.
4. I am unable to catch the `Kudomon`.
5. I now feel sad.

How can we avoid this situation? Does your program handle this elegantly? If not, how can you change it to allow for this feature?

Now imagine instead of just two people, it’s 10,000 people cramming into Central Park to catch the same `Kudomon` - would the same solution work then? What are the limitations? How could you mitigate?

### Part 4
#### Be the very best!
For some reason, `Kudomon` allow their `Trainer`s to make them battle each other until one of them is knocked out. 

Add the concept of a `Battle` between two `Kudomon` to your code. Amend your code to take into account that `Kudomon` have `health_points` or `hp` and `combat_points` or `cp`.

Write code for a fight with the following mechanics:

1. A randomly chosen `Kudomon` goes first.
2. Until one of the `Kudomon` is knocked out (i.e. when `health_points` <= 0), both battling `Kudomon` take it in turns to inflict damage on the other. The amount of damage is equivalent to their `combat_points`.
3. The fight should return the winner.

To make it more interesting, certain types `Kudomon` are `SUPER_EFFECTIVE` against other types. For example, a `:fire` `Kudomon` will beat a grass type easily, and a `:water` type will extinguish a `:fire` type.

You can characterise the strengths of each type as follows:

`:water` > `:fire` > `:grass` > `:rock` > `:electric` > `:water`

(`:psychic` is good against *everything* **except** other `:psychic`s.)

Amend your code to take this dynamic into account.
