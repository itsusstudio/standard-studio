# standard-studio

ITSUSSTUDIO rules for [Standard Ruby](https://github.com/standardrb/standard), packaged as a Standard plugin.

## Install

Gemfile, development group:

    gem "standard-studio", github: "itsusstudio/standard-studio", require: false

`.standard.yml`:

    plugins:
      - standard-studio

## Rules

### Studio/ClassStructure

Class contents go in this order:

1. `include`, `extend`, `prepend`
2. Constants
3. Attribute macros: `attribute`, `enum`, `store_accessor`
4. Associations
5. Validations
6. Callbacks
7. Class methods
8. `initialize`
9. Public methods
10. Protected methods
11. Private methods

Macros not named in `config/base.yml` (`scope`, `normalizes`, `delegate`, `generates_token_for`, `attr_reader` and so on) are not checked, so they can sit where they read best.

It is RuboCop's `Layout/ClassStructure` under another name. Standard pins that cop to off and does not let a plugin switch it on.

Autocorrect is unsafe (`standardrb --fix-unsafely`). It moves lines but drops the blank lines between groups, and the order of callbacks can change behaviour, so read the diff.
